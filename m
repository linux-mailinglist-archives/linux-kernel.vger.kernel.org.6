Return-Path: <linux-kernel+bounces-534589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF962A468E0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681621889347
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AE9221F21;
	Wed, 26 Feb 2025 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQVhB6jA"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25C623373C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593150; cv=none; b=NPxeGZutFazLu+Ud97KiZL7Pg0QZ2va4n3VbA/WFlWcKkAVTLdg9G9+cnm68ok9gFWvXM2q7d5wq6NdHJtT9WiPoiwJgbG+/bwxTSMeCTx63643bnPIVZhZYeetrFinwd43sJyqnrubi+4oBi4cytukRVxKsMgjRoMOE1upS4aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593150; c=relaxed/simple;
	bh=724XS3imcQB+rHD2VPy5MwoQNp0+HKF7rZ7lgx3gaQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deG+1V7pDtZPh1n85qFWveKuNIpcXXsHXI+XGrE1J1aIPAZHs5f+iN4Ij5zHLhaZAOmygGyMXO8OGZwQMtVx9igGkzTY3eIREQiX9w+Rfuh5R1RTD7WFhNLFxHOwrZzvNsPFboLaHRd5rkOyVkdabclDhGvX4JbnH/YyFj6AmII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQVhB6jA; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3f3ff03c89dso59949b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740593147; x=1741197947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCMIoyMeCBuhFoe1IXPIQM39sgN1witXCp5jUX2wbmg=;
        b=iQVhB6jAt4wqOj9zVhCXb5Pfqsm5xVl+tnkfqjGJq+F0+WEdcSzOgWsfKuObDyM2C4
         0pVqRsVhnE4W1pIsMn3wYT4TshmagYgfVNU0Xd0j8B6tzniNFXTB5uNghoNp9v5jxrrW
         UkVvXAOOU1hgCW7EjmdCPAkxAre0XZSlon38GctSCEBflfgjI4Cp58wVCX8HPB/3bXV4
         8tlozk1Q13jg8pIKhuFE4c3bMurv88KMmraGl/82ujBW/PPc16Qww2FyWMlXsyvW+Z5J
         I52nRokKymSRbUbMrBwBa/PZ5I+HdodgBbYUAqkyFf3ugutmUoO01HRDvKo34CotH6mb
         06sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740593147; x=1741197947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCMIoyMeCBuhFoe1IXPIQM39sgN1witXCp5jUX2wbmg=;
        b=HWJx+Kq42WwRAaTKMzYKOqAjEmwByXFPUOH7W9IVqnD3hGSBKtq5rZ95++jSbHxliF
         7We9gqXg37TpCTd943u00uGVaZuuTGh0jsUegdFA1yFwhwr9pXYuvKzUwyrDopTMaxXS
         9aPo8mq8A7g+UXxTRzD4lbHZKnEDIILHOVzGEVpgNJQLnv8aQl/KdnoeS4+D2E1Ny3WV
         FQIhuKG9MWa7Pd7TKFAkjRhmOEZ66t/xPABL7jy9XpqIUC2jkaT0arbao5D2YP7g+OG4
         KbrUUCsUZyA7qXQ8FtfR8TyonlzF4D9h8pBieivSgBPlGrUxBMWIlOblpScr4Ur/Irge
         dwig==
X-Gm-Message-State: AOJu0YzVb+TZBg2wuSGLkA2ME4lsY7OtYRx6nKuqiq6ABX4h2C712VlH
	CzXxGohDxL//721sY72FoT2/DY4KRYCDSWNMI/Vy0U9QBegAIz3RdwFi
X-Gm-Gg: ASbGncug88kRwew1CvOEJkN40JueJPm2cUBkNfGXteq8Gx5s7aSTc5XOq9VzH6/oASX
	X5p8aG4I8jTsIv3x19wfaAaoChOxJgxQv30isuff/G502bf00aXaXPW2gYTRiwNsLk1j8jcCmht
	SrweLoAMLZ6sdiYY1rjB+SPTZOMr595//WrgJ8QrrwWga+4y8RUQBpbXp1rTQPfHWwRbCP/wTqA
	n2uOAywrz8CR7IAVIwlW0TNnKMzcRfrtZ4nXH7cWQW2P2e/KAnx66Q9zqrJrBL6JE7uJAQu5gJ6
	DNop8SE=
X-Google-Smtp-Source: AGHT+IGjwmWsqHP3kkBCauZVFGgTI0KmOgXycZFrLwCX1DPoHJ88Elv0S1i08c3US7YpBT9HdOcK0Q==
X-Received: by 2002:a05:6808:2e95:b0:3f4:1197:29bc with SMTP id 5614622812f47-3f540ec2d02mr5558570b6e.10.1740593147450;
        Wed, 26 Feb 2025 10:05:47 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fe9428c8b3sm755069eaf.39.2025.02.26.10.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:05:46 -0800 (PST)
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
Subject: [PATCH v2 02/11] x86/percpu: Move pcpu_hot to percpu hot section
Date: Wed, 26 Feb 2025 13:05:21 -0500
Message-ID: <20250226180531.1242429-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226180531.1242429-1-brgerst@gmail.com>
References: <20250226180531.1242429-1-brgerst@gmail.com>
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
 arch/x86/include/asm/current.h | 28 +++++++++++-----------------
 arch/x86/kernel/cpu/common.c   |  2 +-
 arch/x86/kernel/vmlinux.lds.S  |  3 +++
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index bf5953883ec3..60bc66edca83 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -13,32 +13,26 @@
 struct task_struct;
 
 struct pcpu_hot {
-	union {
-		struct {
-			struct task_struct	*current_task;
-			int			preempt_count;
-			int			cpu_number;
+	struct task_struct	*current_task;
+	int			preempt_count;
+	int			cpu_number;
 #ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
-			u64			call_depth;
+	u64			call_depth;
 #endif
-			unsigned long		top_of_stack;
-			void			*hardirq_stack_ptr;
-			u16			softirq_pending;
+	unsigned long		top_of_stack;
+	void			*hardirq_stack_ptr;
+	u16			softirq_pending;
 #ifdef CONFIG_X86_64
-			bool			hardirq_stack_inuse;
+	bool			hardirq_stack_inuse;
 #else
-			void			*softirq_stack_ptr;
+	void			*softirq_stack_ptr;
 #endif
-		};
-		u8	pad[64];
-	};
 };
-static_assert(sizeof(struct pcpu_hot) == 64);
 
-DECLARE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot);
+DECLARE_PER_CPU_CACHE_HOT(struct pcpu_hot, pcpu_hot);
 
 /* const-qualified alias to pcpu_hot, aliased by linker. */
-DECLARE_PER_CPU_ALIGNED(const struct pcpu_hot __percpu_seg_override,
+DECLARE_PER_CPU_CACHE_HOT(const struct pcpu_hot __percpu_seg_override,
 			const_pcpu_hot);
 
 static __always_inline struct task_struct *get_current(void)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8b49b1338f76..9b8bf43019e8 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2014,7 +2014,7 @@ static __init int setup_clearcpuid(char *arg)
 }
 __setup("clearcpuid=", setup_clearcpuid);
 
-DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) = {
+DEFINE_PER_CPU_CACHE_HOT(struct pcpu_hot, pcpu_hot) = {
 	.current_task	= &init_task,
 	.preempt_count	= INIT_PREEMPT_COUNT,
 	.top_of_stack	= TOP_OF_INIT_STACK,
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 1769a7126224..7586a9be8c59 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -187,6 +187,8 @@ SECTIONS
 
 		PAGE_ALIGNED_DATA(PAGE_SIZE)
 
+		CACHE_HOT_DATA(L1_CACHE_BYTES)
+
 		CACHELINE_ALIGNED_DATA(L1_CACHE_BYTES)
 
 		DATA_DATA
@@ -328,6 +330,7 @@ SECTIONS
 	}
 
 	PERCPU_SECTION(INTERNODE_CACHE_BYTES)
+	ASSERT(__per_cpu_hot_end - __per_cpu_hot_start <= 64, "percpu cache hot section too large")
 
 	RUNTIME_CONST_VARIABLES
 	RUNTIME_CONST(ptr, USER_PTR_MAX)
-- 
2.48.1


