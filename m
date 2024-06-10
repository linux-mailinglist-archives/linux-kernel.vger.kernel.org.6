Return-Path: <linux-kernel+bounces-208917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1352902A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8191F21D36
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BB86F2EE;
	Mon, 10 Jun 2024 21:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mBvbdPYE"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B3E1CF8D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 21:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718055085; cv=none; b=AR7UxerQWOzvPmnyHDohFlXmCCYshUGO6Dxeq5J2PIYDMBq14RS3bdHoN9BjE8uITqPjHFbP+q7S81ZR0rEqrZ6AB1N2fzssmO1rj8keCHdf3NmIXqsBd8T6a0iduwRhUMu53rOfqTIPZR0CloiyAYIcbehfOgIqxbkxHgX5WJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718055085; c=relaxed/simple;
	bh=SfluqvPw18zZm21EjL8PZD3dt2e7CnA/7EwXFgI2ZfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PyFPDV24zBYztVJxeCpTTEOxvT9JlZvAA8cyKrOPtnp93P0lH+wFCoSptV9cXfjNld6MjQz5EXiAstGc4dR85PmYlMVI9sYHUB3hTk6loftw0s+jREP5ScfPwKhgjbb2PXfARJLxAAOxajXErXqgJE/Ctzvs6GfegObubPi8wnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mBvbdPYE; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70255d5ddc7so402421b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718055083; x=1718659883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srmtWDLn7HyLT5YaIX7R6X8HCxfXWwh3FOO5Hc8ZZKc=;
        b=mBvbdPYE6AncRM6LROibfSdwHxjiGGBCk3a9G0uHPEf0TuKY78w24qL1EfhrydiPKE
         lXlo010WVh2hUasiQtjHVFzHi2V/AeDlG64UDbA9aa8gyxIrQ0nXDryT1zZ6XaNJH9Sy
         WZCSSaNzrr613hsit+PpEZAKfjKF4zU5iYZRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718055083; x=1718659883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=srmtWDLn7HyLT5YaIX7R6X8HCxfXWwh3FOO5Hc8ZZKc=;
        b=AI+gQUknzuRVjDr5cmuPvFBS/1AfMa4/Zv5YKzk/PvByD5XCiZos2ITmS8KdI82QrJ
         0Qwsp1xTm8mIy8r+ntZqlG5Qpmak1MJO01szl79Gur1Ljod6DwnhCUnStjA4WlEZeWdG
         tERolqTs85I9NOKGgt0I3yiKZxsg+AlLNeDtMKy4hts/UCCpKNDZDyD/NqT5ltUbZcGf
         guOxpdTjW4cfcGKtHnbnXuPWq+QhA4OqHChQuX9yQrP0EZkew/HWYkpjcx60eCOIRj99
         g3UydhOgGadT/Fu8OQx70F2wcYmBVUaC5ng7DgvV2o8+0ZZELF7EjdwL4c798R8NgU1j
         yvVg==
X-Forwarded-Encrypted: i=1; AJvYcCUgz5JYXwF75kZtScdFbNcfeKe4tu8WTaRVJvkWirBbbUm+h0ip9oZPAzzIAXk3Gwrl0pgs6imKblpejkZblKYlJJq1IMsmmD+gjuIi
X-Gm-Message-State: AOJu0YwDUXaaCrUwh2P0BYJ/P2atxb9/ivfBemSDUif5oZYhYJrGRfYT
	zYDCZmjfkulNq0UbEYzU8dx23cl8pDVeO7WrN2tip7jasClHIgXBvrorbwa1Yg==
X-Google-Smtp-Source: AGHT+IH8FYK6+vJ+n0xyKfWJc/sXwUm9a/NS/RsR+W4rtqQGfx+7Vpur92sX0jEmAG9aLa85Y8jcWg==
X-Received: by 2002:aa7:8881:0:b0:703:fe89:6ebe with SMTP id d2e1a72fcca58-7040c74a67dmr11332032b3a.29.1718055082850;
        Mon, 10 Jun 2024 14:31:22 -0700 (PDT)
Received: from localhost (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-703fd50beb6sm7401469b3a.176.2024.06.10.14.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 14:31:22 -0700 (PDT)
From: jeffxu@chromium.org
To: aruna.ramakrishna@oracle.com
Cc: dave.hansen@linux.intel.com,
	keith.lucas@oracle.com,
	linux-kernel@vger.kernel.org,
	mingo@kernel.org,
	tglx@linutronix.de,
	x86@kernel.org,
	andrew.brownsword@oracle.com,
	matthias.neugschwandtner@oracle.com,
	jeffxu@chromium.org,
	jeffxu@google.com,
	jannh@google.com,
	keescook@chromium.org,
	sroettger@google.com,
	jorgelo@chromium.org,
	rick.p.edgecombe@intel.com
Subject: Re [PATCH v5 1/5] x86/pkeys: Add PKRU as a parameter in signal handling functions
Date: Mon, 10 Jun 2024 21:31:22 +0000
Message-ID: <20240610213122.3377462-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240606224035.3238985-2-aruna.ramakrishna@oracle.com>
References: <20240606224035.3238985-2-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jun 06, 2024 at 10:40:31PM +0000, Aruna Ramakrishna wrote:

> diff --git a/arch/x86/include/asm/sighandling.h b/arch/x86/include/asm/sighandling.h
> index e770c4fc47f4..de458354a3ea 100644
> --- a/arch/x86/include/asm/sighandling.h
> +++ b/arch/x86/include/asm/sighandling.h
> @@ -17,11 +17,11 @@ void signal_fault(struct pt_regs *regs, void __user *frame, char *where);
>  
>  void __user *
>  get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
> -	     void __user **fpstate);
> +	     void __user **fpstate, u32 pkru);
>  
> -int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs);
> -int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
> -int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
> -int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
> +int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru);
> +int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru);
> +int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru);
> +int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru);

Does ia32 support PKEY ? I thought it is X64 only.
It might be possible to not to change any of ia32 code.

>  
>  #endif /* _ASM_X86_SIGHANDLING_H */
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index 247f2225aa9f..2b3b9e140dd4 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -156,7 +156,7 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
>  	return !err;
>  }
>  
> -static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
> +static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf, u32 pkru)
>  {
>  	if (use_xsave())
>  		return xsave_to_user_sigframe(buf);
> @@ -185,7 +185,7 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
>   * For [f]xsave state, update the SW reserved fields in the [f]xsave frame
>   * indicating the absence/presence of the extended state to the user.
>   */
> -bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
> +bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size, u32 pkru)
>  {
>  	struct task_struct *tsk = current;
>  	struct fpstate *fpstate = tsk->thread.fpu.fpstate;
> @@ -228,7 +228,7 @@ bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
>  		fpregs_restore_userregs();
>  
>  	pagefault_disable();
> -	ret = copy_fpregs_to_sigframe(buf_fx);
> +	ret = copy_fpregs_to_sigframe(buf_fx, pkru);
>  	pagefault_enable();
>  	fpregs_unlock();
>  
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index 31b6f5dddfc2..94b894437327 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -74,7 +74,7 @@ static inline int is_x32_frame(struct ksignal *ksig)
>   */
>  void __user *
>  get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
> -	     void __user **fpstate)
> +	     void __user **fpstate, u32 pkru)
>  {
>  	struct k_sigaction *ka = &ksig->ka;
>  	int ia32_frame = is_ia32_frame(ksig);
> @@ -139,7 +139,7 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
>  	}
>  
>  	/* save i387 and extended state */
> -	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size))
> +	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size, pkru))

You might find that we only need to update PKRU right before copy_fpstate_to_sigframe,
so no need to pass pkru all the way from top.

-Jeff

