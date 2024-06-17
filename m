Return-Path: <linux-kernel+bounces-216619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBE090A250
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 04:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5281C21227
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 02:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197A616C6AF;
	Mon, 17 Jun 2024 02:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VmjSGG5Q"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7A279F3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718590223; cv=none; b=Y3mzsJ0U0kglRu9trFy4Vyt97V7L7rC0K/5hf38fISQRomvU4Mhu09LQWnWAQNcv8m6Rftg2248dJFBn7BUvN1J2qCUJUHUMZG3F5ZB4RgdgUOe/ZPWrCJYUWj9WJs02K8bM7DELX0cSoDW0QGJ8/oJgWIBCyv30enEuydCqM8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718590223; c=relaxed/simple;
	bh=5cDTheXxPIdIssxnQWjv/qLVCXYIkgJSlf1PwQPKjZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kplGhDjTQu+sXV4kGmtXlbXDexNnADiIoQAD7k1rtaqGK8VdojkVAA9Opt04Ca5l5HNDHyRHRrtrmusRo7Yt3LcCc76wTDaLtkYph6On/6ZzmseIfoODzoMwLl++ghD9gI0kPPUKysueJYpiVqrmTsBct3EeKfM2uYEdXVSFInU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=VmjSGG5Q; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dfab4779d95so3855322276.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 19:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718590221; x=1719195021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqCXTr60lfURDiU6o/ziPYUoB/pkh4/Y0UTODd/6hiA=;
        b=VmjSGG5QQuHHAieYtNzm8JYK0MbU/t6m4n/g6jT2in/GAto75KeMPMKk8XdCWOkzFZ
         LwsV0WAXPOnUb7aLPxybGSFA/+NMl++TXndfYHbOB79aPYMKu0bxTkaWlXNy5RRvkfDh
         HRhINwDdPr87TAGC6gf7w9QJgMCNgihSO/OC+pQGpKpPGkQ30jeXDNEUpgiN+ATCWwJ7
         qLhZ57iGHeSvi7w+NJTsTFDka3+TTElJGLsWiRtndGZuGzrvzMDLCFjHJvTi9WckILMg
         gCoSJtioj0JLpB4HyWmaLyTv8K8L3M/BggOQw3/TxM/0jJP5MdEtieaRcdLJNDcMYVEk
         Qeog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718590221; x=1719195021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqCXTr60lfURDiU6o/ziPYUoB/pkh4/Y0UTODd/6hiA=;
        b=WHnyOj6nuqJOYcWcVa8NAvcUzdapjc9Lsx3m0jTBXVEy9wIhG+/TtOOMnetd/SkLxC
         zUeIkyeeRWVMzf6ULviRDyjCLmqddadF0J2uXqve1TKMaSniqWxh85irfD2aAmFxVABB
         LFw/oTXK1SqM9XEg2xUjE3GvONE++cgyv+dHyziPW3lzX4RHlfM4cr+QzATI3UqEGLpS
         VHIXy5cnJHingYDzgRQHlU4U+WIUaCX3IAMtNoU9j16c6c9VJJKFf1KsLLfpmEUigFSY
         admY5e0VsEWtRH4ycndVhgZgv7cXNvyl6vpjypDkac4EhvoM6EQ0MYWI22kZ196e4khW
         s1nw==
X-Forwarded-Encrypted: i=1; AJvYcCV+kgGbkzzqF5PLYrFowiFlletPsQ8UWNIZseQmYvt8igzZvtsBJy1uOZVr0SUt/mld+omptFg8dw4pI3SlfHSfb/yGpJyPL42SXTT+
X-Gm-Message-State: AOJu0YzRKXmXmJRDNIxluyUn08xxjRKsHtc/O2q8Q3lgVAhww6nU1vpc
	D9rodRYg77hsrnq4+nyE7/uMQG/0aY3GB0QZr5pzBVU3PoZ8Qmv1FwFvdPBhtz10k8rkHTTazW9
	Ry9SI5CLgPSS7mef+D2369wax89/DoOYmLHMWFw==
X-Google-Smtp-Source: AGHT+IHVdf4CeK9m5TY7u8n2i5EYX8aCm7rXG/PvOUZXj0qTxh3niUzEWChMP06D9pYzethEgSj8BqmnKZHhXWATYww=
X-Received: by 2002:a25:6612:0:b0:dff:3b6a:6322 with SMTP id
 3f1490d57ef6-dff3b6a64a9mr2668500276.34.1718590220902; Sun, 16 Jun 2024
 19:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
 <20240613-dev-andyc-dyn-ftrace-v4-v1-2-1a538e12c01e@sifive.com> <20240613093233.0b349ed0@rorschach.local.home>
In-Reply-To: <20240613093233.0b349ed0@rorschach.local.home>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Mon, 17 Jun 2024 10:10:09 +0800
Message-ID: <CABgGipXB8uQ7XZbBFMZa8b7mymKAW7qOkKKaA8qVZ0hGXziSYA@mail.gmail.com>
Subject: Re: [PATCH 2/8] tracing: do not trace kernel_text_address()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Zong Li <zong.li@sifive.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 9:32=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 13 Jun 2024 15:11:07 +0800
> Andy Chiu <andy.chiu@sifive.com> wrote:
>
> > kernel_text_address() and __kernel_text_address() are called in
> > arch_stack_walk() of riscv. This results in excess amount of un-related
> > traces when the kernel is compiled with CONFIG_TRACE_IRQFLAGS. The
> > situation worsens when function_graph is active, as it calls
> > local_irq_save/restore in each function's entry/exit. This patch adds
> > both functions to notrace, so they won't show up on the trace records.
>
> I rather not add notrace just because something is noisy.
>
> You can always just add:
>
>  echo '*kernel_text_address' > /sys/kernel/tracing/set_ftrace_notrace
>
> and achieve the same result.

Sounds good, I am going to drop this patch for the next revision

>
> -- Steve

Thanks,
Andy

