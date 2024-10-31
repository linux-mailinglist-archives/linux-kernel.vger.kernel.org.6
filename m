Return-Path: <linux-kernel+bounces-390900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 176259B7FD1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BD87B2132D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA7E1BD4E2;
	Thu, 31 Oct 2024 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pt5sVmV2"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638A21BCA05
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391476; cv=none; b=IYLbGP7pPpoTRRMq9X0T5qeavMYOaGQQl6gqEBapAr9YP6EIr0o0UyD4IaYQJYgMn5BshHFSmjkLGuX5vDlQSq6b7NOKZ7TAE4F6rEOY581YMaXj45ADesln7UkMuLZJc7Sl3a+q9rRBrBfazB2a28kwmMcP17sQb97XM4VnsnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391476; c=relaxed/simple;
	bh=y2IsLyxoEKNnYtvowVlcI8ThZYqvYvSbPjW89cG/dkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c42p7GHu9kP8X3JJzvZBxOibcZwnXHQCf9696AWHTHO7RLgCb3tTJsuICjaWVJjCZhYihOfoP5/XNHzNuwK6QXhPBWctsIO4VmM5IKUy01H3nAgDosa9Hza6ykB+uKG2vO6Lu3XGieuQT4xDeRLtvAcCl5I21Y05DkM1Uj6SL1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pt5sVmV2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2d83f15f3so137871a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730391474; x=1730996274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPfyBMQZSoHiMisSRJWvTqEvvGUVXWxSu17kcRJj79k=;
        b=Pt5sVmV2ACBwf2qBc2iIP8HGg+dagSbgoTw7qQCpdR3zXmjf7EpgL86w8JojQjDWu7
         iFFfKJdbM9BecWnz1iaozr8UY/w3u+y6G7uUYGTI/JnZ5cAPvUkgHQoHbspoDDeChKY+
         Qb1tr26a+crmrWFw6m8mw8oHTUbMD9X89XpCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730391474; x=1730996274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPfyBMQZSoHiMisSRJWvTqEvvGUVXWxSu17kcRJj79k=;
        b=MXO7xbQNuV/cr+tvLP3ML2qoUN9ncJRLMdfdkVBhM7rzKGfUO1igrpw5qpdTzy57cQ
         V9DGXhD9V7nzK7zBoF3ZP40/OXaVlFO9xJQ/AnSQJtUUHNiWLfFOEifuyiWwV/wSi9wf
         kbtgBp9qj437St8D++e/CNYP6xDuAe6CNmlLmvRGAL2+lH18Su8mWI3aIQFiqTt9Uqe1
         9yHMJZRty6ePINVhARVwAIeYhXCyVeM1czVU2GDKAEtDjDofxFwAzrlWJWxCJB9iago/
         S0pYX7JIy3mpJO+0vJkk3X2qGZVnQNRx1Qfv4DdeMuECsv6/mgifUzDc3zFrbhUhXoUt
         SNtg==
X-Forwarded-Encrypted: i=1; AJvYcCX0dSNbCGalcH7UlGScixDxpi9cikayD8Fv2vAI0wnwDY2wcasonlQlAQxU6MvdWjczlN+TBtcVToK3UR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlWDDyCpuBbohCFrOcmUVndLsE8mhIp/72O1EXvhtHlgzrLmDX
	TWscqaPgVNLdmD2uIxqLOor5fS6T2Bg/kYJ9XzwMZaF8+BZg5xVSI8sgSqMvuhIMvROAt3nkYDv
	+qEfzEuFkiXLVsPmwdXtK//ryb3JqczoYz/C0
X-Google-Smtp-Source: AGHT+IHQOMo347a6zYohDR79O85jMWIxjxFPQ6AUAZc5+R+zHxd/Y3AKeAPgzu5rSE9m00wex3yeLnDqHQMXJ+x2qVA=
X-Received: by 2002:a17:90a:cb8b:b0:2d8:be3b:4785 with SMTP id
 98e67ed59e1d1-2e8f11beea7mr9539636a91.6.1730391473687; Thu, 31 Oct 2024
 09:17:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028195343.2104-1-rabbelkin@mail.ru> <20241028195343.2104-2-rabbelkin@mail.ru>
 <f4c533a8-0d5e-476a-96cb-e76b67a4d62c@linux.dev>
In-Reply-To: <f4c533a8-0d5e-476a-96cb-e76b67a4d62c@linux.dev>
From: Florent Revest <revest@chromium.org>
Date: Thu, 31 Oct 2024 17:17:42 +0100
Message-ID: <CABRcYm+fR0qRk1FS8edB0zNFtg+GXt3vp025HU4eq-vCR52rRg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: fix %p% runtime check in bpf_bprintf_prepare
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Ilya Shchipletsov <rabbelkin@mail.ru>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Nikita Marushkin <hfggklm@gmail.com>, lvc-project@linuxtesting.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Florent Revest <revest@chromium.org>

On Tue, Oct 29, 2024 at 7:18=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 10/28/24 12:53 PM, Ilya Shchipletsov wrote:
> > Fuzzing reports a warning in format_decode()
> >
> > Please remove unsupported %=EF=BF=BD in format string
> > WARNING: CPU: 0 PID: 5091 at lib/vsprintf.c:2680 format_decode+0x1193/0=
x1bb0 lib/vsprintf.c:2680
> > Modules linked in:
> > CPU: 0 PID: 5091 Comm: syz-executor879 Not tainted 6.10.0-rc1-syzkaller=
-00021-ge0cce98fe279 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 04/02/2024
> > RIP: 0010:format_decode+0x1193/0x1bb0 lib/vsprintf.c:2680
> > Call Trace:
> >   <TASK>
> >   bstr_printf+0x137/0x1210 lib/vsprintf.c:3253
> >   ____bpf_trace_printk kernel/trace/bpf_trace.c:390 [inline]
> >   bpf_trace_printk+0x1a1/0x230 kernel/trace/bpf_trace.c:375
> >   bpf_prog_21da1b68f62e1237+0x36/0x41
> >   bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
> >   __bpf_prog_run include/linux/filter.h:691 [inline]
> >   bpf_prog_run include/linux/filter.h:698 [inline]
> >   bpf_test_run+0x40b/0x910 net/bpf/test_run.c:425
> >   bpf_prog_test_run_skb+0xafa/0x13a0 net/bpf/test_run.c:1066
> >   bpf_prog_test_run+0x33c/0x3b0 kernel/bpf/syscall.c:4291
> >   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5705
> >   __do_sys_bpf kernel/bpf/syscall.c:5794 [inline]
> >   __se_sys_bpf kernel/bpf/syscall.c:5792 [inline]
> >   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5792
> >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > The problem occurs when trying to pass %p% at the end of format string,
> > which would result in skipping last % and passing invalid format string
> > down to format_decode() that would cause warning because of invalid
> > character after %.
> >
> > Fix issue by advancing pointer only if next char is format modifier.
> > If next char is null/space/punct, then just accept formatting as is,
> > without advancing the pointer.
> >
> > Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> >
> > Reported-by: syzbot+e2c932aec5c8a6e1d31c@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3De2c932aec5c8a6e1d31c
> > Fixes: 48cac3f4a96d ("bpf: Implement formatted output helpers with bstr=
_printf")
> > Co-developed-by: Nikita Marushkin <hfggklm@gmail.com>
> > Signed-off-by: Nikita Marushkin <hfggklm@gmail.com>
> > Signed-off-by: Ilya Shchipletsov <rabbelkin@mail.ru>
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>

