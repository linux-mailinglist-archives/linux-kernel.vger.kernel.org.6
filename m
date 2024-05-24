Return-Path: <linux-kernel+bounces-188101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFAF8CDD5E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 01:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D6328562D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201251292FF;
	Thu, 23 May 2024 23:14:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1291292D9;
	Thu, 23 May 2024 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716506056; cv=none; b=BSQ1t+YT0K1ls14JBAZGV1uwReF2ik4kKDgRjUajkOTlo2KOs7ntsRDx5hFXvHlDQGWnGkRXnAqFOJxScW5gFmT0D/eLiWTaZaWkm73eSo0/ROw6xxfaHkEb52Y/B6SOSu27uQ5r0HrThO3+Z7ZTLXbIhU5BtrDQnJQgf8u3aCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716506056; c=relaxed/simple;
	bh=EC4mMstx3GoDVOr94WNVc788fgZGZZasw7u9LmyR0Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQNfKcLIooKZPfodgBZWZaaTFbNgWk3dtG6veOczl6y2+9/Uc/wEKGfJcVMqjEbYXYHDA2FxvPngsH/ZwChKdGaqxD5fYWK8d/LjV7eTL/p+ZgpRUQINAVLBG9DpCgbnwpjGvuk/MpkPHFmSmTgb0hbciQxQ6SbGu1ZN3Aaw9fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45F5C32789;
	Thu, 23 May 2024 23:14:13 +0000 (UTC)
Date: Thu, 23 May 2024 19:14:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v10 03/36] x86: tracing: Add ftrace_regs definition in
 the header
Message-ID: <20240523191459.3858aecf@gandalf.local.home>
In-Reply-To: <171509091569.162236.17928081833857878443.stgit@devnote2>
References: <171509088006.162236.7227326999861366050.stgit@devnote2>
	<171509091569.162236.17928081833857878443.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 May 2024 23:08:35 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add ftrace_regs definition for x86_64 in the ftrace header to
> clarify what register will be accessible from ftrace_regs.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v3:
>   - Add rip to be saved.
>  Changes in v2:
>   - Newly added.
> ---
>  arch/x86/include/asm/ftrace.h |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> index cf88cc8cc74d..c88bf47f46da 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h
> @@ -36,6 +36,12 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
>  
>  #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
>  struct ftrace_regs {
> +	/*
> +	 * On the x86_64, the ftrace_regs saves;
> +	 * rax, rcx, rdx, rdi, rsi, r8, r9, rbp, rip and rsp.
> +	 * Also orig_ax is used for passing direct trampoline address.
> +	 * x86_32 doesn't support ftrace_regs.

Should add a comment that if fregs->regs.cs is set, then all of the pt_regs
is valid. And x86_32 does support ftrace_regs, it just doesn't support
having a subset of it.

-- Steve


> +	 */
>  	struct pt_regs		regs;
>  };
>  


