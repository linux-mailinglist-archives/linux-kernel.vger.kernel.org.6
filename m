Return-Path: <linux-kernel+bounces-203862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EE48FE161
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A670B21245
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE06137C37;
	Thu,  6 Jun 2024 08:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcfBIF6+"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D489919D8B5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663589; cv=none; b=kZGLmz9nuuIUPnynM0R6bTGI7y+q44Jw0sS2WuZpUnK0pBDI/HJ89UPVGetK2D9vePZMj44b/4aoRsQGpak8xgAGXBoeslrUAuGh2F2nP0AqDZFTWA2ZICnEdqwZAuT6jmwp0jvToFTsj9mL4groeRP8RL+GwLQbOFdM9zolyC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663589; c=relaxed/simple;
	bh=XIyBT72Q4i1lpEtwmO9PXHXrr+0M6Zbmw3bd6u45yxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/oVWBkeOwF6ZAEaMty2DCRrjcG066ry8Mi2CNM2OHy+1QlK5cC2znOAyKfBHqtHxzZ7SuyDzPv+Z1yFfVuRUn5uQZS02tGdUBQBgTOfAkPNDTtIVdGbLD2ify433YO+C+nY5t0aey32O+YmeeNPnwO/NUWYzBwHTX/lEGfOVL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcfBIF6+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4215b0c4b7dso8251395e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717663586; x=1718268386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Z5it3rlnBFIN4GPFN6CunDNEJRGhfQqKqkscZbkHFI=;
        b=jcfBIF6+ynpBFqaM8dNt3TIZxfp51mODC3c4xof0WkXU4bW21y3fhAJCbScFe3Y3GG
         0f0sd30dne0VTI+qt8DICg+GXZaxrBOEJIAuJDBCqgIKfnkgfO7OefKjgniiSl4wRf1W
         mN5geRneQB8wCU2urmHQFP4CJzDNG/QZ8vPJI4kO+D2Yc1GDC4RmIQm0jAtNkc5FeXsv
         9T+Br2M8Msky1mPnyZxqC7Cz1Tzu3ourji2jIovp1DIce2gb9dG1wmU6RwbeAtRjcbr5
         csKWZdl4omVGgwW+Mff+Eikp4M9/KPpJxVHLs9UzORnVXLu+kuneS8HkJ//74j2Arm+T
         vq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663586; x=1718268386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Z5it3rlnBFIN4GPFN6CunDNEJRGhfQqKqkscZbkHFI=;
        b=s6Y1ssXz3grYY6JC30QGZL/4ts5fc1L6VSOBxxlK4p4oZ9mCifwW38ZxTU4MKEdIzc
         m6tjjlEuNkBUJFs0n/iFeYZ+RLG6sTRMl2WVCBp8+ZyhxEAvgJJ1tIobaqgOfqYDhwx/
         NL0WT0/a2qIHIJiY/SdGhdIyqSXRDcAXsw4Kmk9mKi8aO7gr7v2HggUm/qDxtIXxzV1B
         gSRAw4rej57rTZErUDvsp4eWaxG0by4r2JcNm4gqeihcW6Dx5CCRrYBTOyfcKYLar07s
         yfvc9WJE1Vakx96BKYkN2lUTRINdd0oymzUB8PZKzma5Ruauq6yvoKqTs4eOqQgcV/lj
         Uimg==
X-Forwarded-Encrypted: i=1; AJvYcCW9j2gbHQDYW2lT+zxp+37dWOjmRP7RJHe/6SqyEjs/3hPutwx5zIt0bmDE69k0TRvZexRW4EXMjEBhI+l5S4UcYwd9br30Nikr6hay
X-Gm-Message-State: AOJu0YyZKhGb2QaovrdeU3aLUh65masGRkelIc90gBjs/fWq+s5H2SK4
	IgvqiR339CZs2qlLdEkwEusTrxRzl60k0SPY+CyE6Ty5rw1ttd7r
X-Google-Smtp-Source: AGHT+IEMq/PfOsxWpZgUdMySGyzu0Vprtt8fQCjcHoNvY8qSX7cGYNJSYXfGoAbvrrqqP2K14K0FAA==
X-Received: by 2002:a05:600c:a293:b0:41f:fb7b:bc53 with SMTP id 5b1f17b1804b1-421562dc394mr44445095e9.22.1717663585765;
        Thu, 06 Jun 2024 01:46:25 -0700 (PDT)
Received: from gmail.com (1F2EF20A.nat.pool.telekom.hu. [31.46.242.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215814f6c0sm47515705e9.46.2024.06.06.01.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:46:25 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 6 Jun 2024 10:46:23 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH 4/3] x86/fpu: Push 'fpu' pointer calculation into the
 fpu__drop() call
Message-ID: <ZmF3Xx7kFzSuHm4P@gmail.com>
References: <20240605083557.2051480-1-mingo@kernel.org>
 <20240605083557.2051480-4-mingo@kernel.org>
 <20240605141733.GC25006@redhat.com>
 <CAHk-=wi4773Ls82kqVbPmM1deghS2NXkHNCCzWPc270kcByXPA@mail.gmail.com>
 <20240605162610.GF25006@redhat.com>
 <CAHk-=wg2zJgy69j8n6C9T4YARkxcJ09SFkpMiqrCqhChf0s3NQ@mail.gmail.com>
 <ZmFziN0i10sILaIo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmFziN0i10sILaIo@gmail.com>

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
index d9ff8ca5b32d..3223eb3dd09d 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -679,8 +679,10 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
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

