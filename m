Return-Path: <linux-kernel+bounces-206928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917D6900FFF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7CB1C21800
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 07:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969B9178377;
	Sat,  8 Jun 2024 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPTX3ulz"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D17417BAF
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717831944; cv=none; b=mVvd4VJ0YfZGqF2oSi9JWsCo+XdEqLg3ZSjQYfckj8ywMRAWf+oKqIY1XfZ3P1s9uan5KEKVA2uw0PhIwSVlGDJ8238KmAX+Nf/CDZqiHQefLvQsJS7J6YSZe1XcGkjR2J5bDoPZIRNNthXWdd8dvNjx0nv6PSlF+cvXxItNn5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717831944; c=relaxed/simple;
	bh=NPbHCS9f0nBSWkbqacoINu9Sm2IaRds7yMCrldRHK78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqbAzAo3KSj8SKZZXkAStCtwMHWkLpexrr+PuaJZTOiNDQyxulaVHPLFw6BeWOrtaY1r5yMZ9AjJT+TwaaAu3qt5AHg3SgkXHndmdej4Od22LRdS0ygiClwHepFMxvfSMgOoT8A6nAq4B0Q60dUAGGSI6iJtUGgpUeWbD+9oGtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPTX3ulz; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6ef793f4b8so93920966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 00:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717831941; x=1718436741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I52Ss9P+t77Fk6nJffqozhx7Mo6O/vHA5ocISHNQDuE=;
        b=FPTX3ulzLXEH0vccOZPRePseJ+bmg8Y94Aeu343KkpQT7sYKYLrLZ/vhWe1l7cCGWZ
         esFd4z8y4LhcHr40ZtxGykU/ryJLPMa1h3dIY/Q9EOw0hL6IpBrPNnJZACOWY1nQtAVz
         78Jrxfv87PPH/R/FQp3IYYe8ATTGCtNfXf0ClI9NHMymKUnND9y2blD51mg1nvq/9N9Q
         GmCMiRkCfCciggBav7Jf1J6WuR15NOVUHYzVASo4Bxig6Sr31ugBs1IrGWRBm17S8muH
         rwc5B5yRMGTD9U2N7GNfGJQWIjTzqFGNAEDrP2GWEvQcQCaV+Q+Yc5xxXMx1J+uYNOgF
         I4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717831941; x=1718436741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I52Ss9P+t77Fk6nJffqozhx7Mo6O/vHA5ocISHNQDuE=;
        b=OLttAxol89QNv/bxJ0NZLdPARe/BYBb4PVVfIxVpaQDnpf/Ggz9J3c+XcAxZW0q06U
         0ay9IfOg2QNlkJtMT7qtSOF8ZQ0DrMRcANOiSlwYbrP4sJd9fRNT83vvVQ5l+LDfVbVy
         j/q8q/xTyWy1y2XrjaAobuuARv3izAbex3N+DQnEQ/jsyX34RknqoEP41dasGdqZSzfR
         ggtl1+UixKyOpJLAWKwk30WfE9tncUtDNHjhtPZ4pij6BHaEujQaWkCtvgKPIlAF2NjK
         sPLKRWBthGhGpq63Va0qguLehZ98JgiRYHdAMfIlKrfh5ut3P4yCGW1/D7Hg9ZXJAdRQ
         1xAg==
X-Gm-Message-State: AOJu0YxHKhBA21uTSMoaEmJMAyGJeum4XpHddgfzGj9ktdPFC23pgxSn
	jNcPcVxjn8aH4ATaLnxZ2yqvJqevpgkRYVe/UfmygVe2E9DYK0NvwDU01ARH
X-Google-Smtp-Source: AGHT+IGWWk4MSouJxW08xN80V+cRIaseq45V2ieTr473uukebYC8k3dKVom2XgNMfEMVPMQCcXk48g==
X-Received: by 2002:a17:906:3556:b0:a6e:f763:1c88 with SMTP id a640c23a62f3a-a6ef7631ce7mr131809966b.37.1717831940959;
        Sat, 08 Jun 2024 00:32:20 -0700 (PDT)
Received: from kepler.. (1F2EF20A.nat.pool.telekom.hu. [31.46.242.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efe5262cdsm61350466b.117.2024.06.08.00.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 00:32:20 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH 5/9] x86/fpu: Push 'fpu' pointer calculation into the fpu__drop() call
Date: Sat,  8 Jun 2024 09:31:30 +0200
Message-ID: <20240608073134.264210-6-mingo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240608073134.264210-1-mingo@kernel.org>
References: <20240608073134.264210-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This encapsulates the fpu__drop() functionality better, and it
will also enable other changes that want to check a task for
PF_KTHREAD before calling x86_task_fpu().

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/fpu/sched.h | 2 +-
 arch/x86/kernel/fpu/core.c       | 4 +++-
 arch/x86/kernel/process.c        | 3 +--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
index 1feaa68b7567..5fd12634bcc4 100644
--- a/arch/x86/include/asm/fpu/sched.h
+++ b/arch/x86/include/asm/fpu/sched.h
@@ -10,7 +10,7 @@
 #include <asm/trace/fpu.h>
 
 extern void save_fpregs_to_fpstate(struct fpu *fpu);
-extern void fpu__drop(struct fpu *fpu);
+extern void fpu__drop(struct task_struct *tsk);
 extern int  fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
 		      unsigned long shstk_addr);
 extern void fpu_flush_thread(void);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 167a9c7ed6d3..c85667c0695d 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -672,8 +672,10 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
  * a state-restore is coming: either an explicit one,
  * or a reschedule.
  */
-void fpu__drop(struct fpu *fpu)
+void fpu__drop(struct task_struct *tsk)
 {
+	struct fpu *fpu = x86_task_fpu(tsk);
+
 	preempt_disable();
 
 	if (fpu == x86_task_fpu(current)) {
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 4184c085627e..0a24997c8cc6 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -114,7 +114,6 @@ void arch_release_task_struct(struct task_struct *tsk)
 void exit_thread(struct task_struct *tsk)
 {
 	struct thread_struct *t = &tsk->thread;
-	struct fpu *fpu = x86_task_fpu(tsk);
 
 	if (test_thread_flag(TIF_IO_BITMAP))
 		io_bitmap_exit(tsk);
@@ -122,7 +121,7 @@ void exit_thread(struct task_struct *tsk)
 	free_vm86(t);
 
 	shstk_free(tsk);
-	fpu__drop(fpu);
+	fpu__drop(tsk);
 }
 
 static int set_new_tls(struct task_struct *p, unsigned long tls)
-- 
2.43.0


