Return-Path: <linux-kernel+bounces-204009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7093B8FE2DC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7935C1C24FB4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBE117837D;
	Thu,  6 Jun 2024 09:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2BLQDX7"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B2817C9FB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666245; cv=none; b=MtJ417g5H3ND2PLjMQ0bZOolvUnov2fuOj55Y6MpYlyMYNJKEk615978g9y9lucnFSo2/Zc0HJJ81kpv3kcUVNIsHSk33MrW++CwjK80/qxRFz8wxdkw/JsEQt8uo5aXSy/VXFBwD/wEamBG9D5j/N5DZ7HH10UDoEZ3EBw32lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666245; c=relaxed/simple;
	bh=VLhNWmvRrSClxF+rekg2eSTJv5rjV4byVi/cT/a0RQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIO0KuB2H3T+0c7PN+d24YbCVjlNmiOLXk8dB7A9sRIDnYrkjWOGSiqjUZOwF3i98lVjDpdmTKZdowhyUD/bGvffVVkYYgCv/vQMDrJo2XzdB38uiSdJqdjiFz3HkHpAawTHrj4ggxHnPJ2Ap/zL32vJRxFDe+FRV+CiBR5H0ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2BLQDX7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4213b94b8b5so8638465e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 02:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717666241; x=1718271041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1pBbZAFqzrZDgDdfYVwGoMmcdxP7e2j16JwbU5hjzo=;
        b=R2BLQDX7M7NF0tWttMte3BqiedcSEiMkkKyPocx7Ghc9oSl2ABgUw20dd274sB2HrF
         RmiI9hGm4wySEdruKcyb9N4/nZbIVfWcVSMiCtRKIUUAFETKZseXH6Pc+eBVpOCTkD8t
         BKd0qzJoC+V+cKmFpUsmg2TCQinoazoJNZRY/08mgqIVMlQ0CMzEAWgX+Ymoj/PqSxge
         vYyO4z0SENadg/MC4erT2Y+JK8hh4qLPuu+C2sMK8BXebmaaKGN86+SZqVT94GW19lJp
         tpLwsvYdUfMRnB48eWDaGtnb764zVJ802lmdOEAg5gkt8FCe+p+oO24Oco4xx8GjUEsY
         oDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717666241; x=1718271041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1pBbZAFqzrZDgDdfYVwGoMmcdxP7e2j16JwbU5hjzo=;
        b=CCaDJMGvJxVbFXg420D2NM3If9i0cGiNn9NfaAT7stG9UF+VbNiQDUUWEilQSeAdsq
         sI/jP5kjiB5wOwyxrEdPtOgiit8kXVdGahqcuCD5d7hQt30GRvKd8s6FP1oyWpb8gjoe
         jY1Fz/QTPTpUfQdLYC9rniE+JSLRp46vf/2cLVNx9i0JR9YkRRqdzwX/pbGKYmiULjhT
         tn6jjlPd1jobr7y/MjjVqeFMj+5bP6F3H6Z/PNifyvSHrPdirZToYtSSshtfw+z07aOg
         dIjLPaTJ4oWQS0w6QXOIFhx1HhKh5eNi9pdoquwx+3+nx3US10rb5+HPMdjheUva2JLz
         FV3Q==
X-Gm-Message-State: AOJu0Yzb19QcLibmPp1A3p9SXgDG52BeCZikEybzghqO7GXZa+0izder
	RJWQ6ZiebuVHAW6dzQPRUi9R1p4zBYpM2vLhosZY6Wv7d0wHGAnm
X-Google-Smtp-Source: AGHT+IFG3MVo3jFT7Qt0tbfXWEg35i081/4P5WX4e/tX/oPm2b/wikv4lMsKBnQ4/vwbIMPZ6TKtvQ==
X-Received: by 2002:a5d:47c4:0:b0:354:db35:63ab with SMTP id ffacd0b85a97d-35e8ef09a48mr4213626f8f.39.1717666241372;
        Thu, 06 Jun 2024 02:30:41 -0700 (PDT)
Received: from gmail.com (1F2EF20A.nat.pool.telekom.hu. [31.46.242.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d29653sm1056553f8f.21.2024.06.06.02.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:30:40 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 6 Jun 2024 11:30:38 +0200
From: Ingo Molnar <mingo@kernel.org>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH] x86/fpu: Fix stale comment in ex_handler_fprestore()
Message-ID: <ZmGBvsCCM-4H0Oml@gmail.com>
References: <20240605083557.2051480-1-mingo@kernel.org>
 <20240605083557.2051480-2-mingo@kernel.org>
 <204e541d-ff48-487c-8f70-619f90f65635@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <204e541d-ff48-487c-8f70-619f90f65635@intel.com>


* Chang S. Bae <chang.seok.bae@intel.com> wrote:

> On 6/5/2024 1:35 AM, Ingo Molnar wrote:
> >   /*
> >    * Handler for when we fail to restore a task's FPU state.  We should never get
> > - * here because the FPU state of a task using the FPU (task->thread.fpu.state)
> > + * here because the FPU state of a task using the FPU (task->thread.fpu->state)
> 
> Just a nitpick:
> 	fpu::fpstate now points to the active FPU in-memory storage.

Yeah, that is a stale comment, but this was just a 'sed' job in essence, 
and I'd like to keep that particular patch semi-automated.

Note that later on that comment gets further mangled into:

/*
 * Handler for when we fail to restore a task's FPU state.  We should never get
 * here because the FPU state of a task using the FPU (x86_task_fpu(task)->state)
                                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^
 * should always be valid.  However, past bugs have allowed userspace to set
 * reserved bits in the XSAVE area using PTRACE_SETREGSET or sys_rt_sigreturn().
 * These caused XRSTOR to fail when switching to the task, leaking the FPU
 * registers of the task previously executing on the CPU.  Mitigate this class
 * of vulnerability by restoring from the initial state (essentially, zeroing
 * out all the FPU registers) if we can't restore from the task's FPU state.
 */

... which didn't improve clarity either. :-)

How about the patch below?

Thanks,

	Ingo

=========================>
From: Ingo Molnar <mingo@kernel.org>
Date: Thu, 6 Jun 2024 11:27:57 +0200
Subject: [PATCH] x86/fpu: Fix stale comment in ex_handler_fprestore()

The state -> fpstate rename of the fpu::fpstate field didn't
get propagated to the comment describing ex_handler_fprestore(),
fix it.

Reported-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/extable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 1359ad75da3a..bf8dab18be97 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -111,7 +111,7 @@ static bool ex_handler_sgx(const struct exception_table_entry *fixup,
 
 /*
  * Handler for when we fail to restore a task's FPU state.  We should never get
- * here because the FPU state of a task using the FPU (x86_task_fpu(task)->state)
+ * here because the FPU state of a task using the FPU (struct fpu::fpstate)
  * should always be valid.  However, past bugs have allowed userspace to set
  * reserved bits in the XSAVE area using PTRACE_SETREGSET or sys_rt_sigreturn().
  * These caused XRSTOR to fail when switching to the task, leaking the FPU

