Return-Path: <linux-kernel+bounces-234085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0414191C1FE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF601F260F9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDEB1C689A;
	Fri, 28 Jun 2024 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4i82SHr9"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E291C6896
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 15:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586859; cv=none; b=ZAuZ0XxlWxdnmeX/WaHs6ia1jD0O3HaaxrCuyf7UThTDnzCE7b82D0h7McVU82bWZPLSON9SpZ75yF8g6OuAAfiYLXthCWT7q4fDMMp4D0Qk0riznVYiI4RKcLNV5mWRhtN5ZNoiY5ZrUGX6NV/58eDwRAfKpz+tJZqTb5ivzzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586859; c=relaxed/simple;
	bh=NYBuvrFJB0rpq/965KIJmsqoQ1vlti70KKWXCJ9Q9eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9JyMSXvmCfUL7PYxFMem5Utcm8k8muEYpFnlMMPd8peD+Oou/l6+cSR9AL/jqBYN7wCcYUEV5oFpq2e4G+ga392mS1PFfsI0FL8DLQ5KJPLCGrg64zH3+uLR4jQM5cz+saxvCMdIMhMIqX+3L/FjVmREyXmP9qcGsBwkbNUqOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4i82SHr9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42566fb8302so5495115e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719586856; x=1720191656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaXk99eR0EYPN3u/ul7DqSTUXvM4e2LJKqc1JYNQsfM=;
        b=4i82SHr9q/nsbMhh47kcQixLwTX1k1/KIpVmu1tOtZk24Wb5P8KAFHS0LbAfNq8k8R
         9u2lsP1pdt4lXS2tUshngyhvjDzXbS1FCxkmxPFiO+01Etw1n++8hoepXd+0wdmvEbaX
         mF30eP4Jqw8Pa+MDsYZoAO6Rf1fa3DdWmJdyzLc8FF/bpxjIR7P0l3lFo8L/JAoYpAS9
         45eYLzZ8JWJSU64oLg8hAoHdrcHHcCLNyux+48271sxAIzrb8IE+7ZDSsRkPmkQ21Rd1
         Qe9qint7C9MpVdRUZmQeb3d92AWL1JpuwpSu3J4W7+CfYN3LSaobuYcrpwLDEZjJf/IO
         XYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586856; x=1720191656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaXk99eR0EYPN3u/ul7DqSTUXvM4e2LJKqc1JYNQsfM=;
        b=q1xF5Sc4s7nIcM06rzsQU6U56GolW3Kn5SI7nf4SyxU2VQ9rdVAMGzXRSflSlxbRnq
         NqB4ryQqqhIgvI53dVe2WvVpWPj7BGtzTuyxqeWnuGDB7LrHFNFa4FeKB4YHVl4h3Nhb
         5SuzmmgbjiK/grzLIHg9at8Gc6uVnETlRjaUOWfZHBKYDZN7X2Y+OcKF1dcUDaRyxB/x
         PJ4/Nm8I3oAX0G1XxdvjXH4H/wfIf7wHOzWgyKhCHTSTqDA9x6R1Q3/wtNy2wZPjOt/t
         26FzMz0vKUBZZUCiphy5vcM6MENKWRpo5d1+mOkds2PvU/OpRMRHSEvtIhHi8q731c0T
         f9wg==
X-Forwarded-Encrypted: i=1; AJvYcCVbobN9f/8CZHIORYhK8hGvD9/7+TuZL8a+kbO3R09+NF9hwDABX55d14orC8rkQ1CpPjCOPmGKD9ZbFLgqcobRn4lv8ViEmWur2wrb
X-Gm-Message-State: AOJu0YwN93aLut5pQx642srgiLp6KDLBW30MHBwUJ5b3RSzFrd2NAiEF
	ncF/j5mVh/evPwnaHHJqs70T+nj3v0CRPxFwxzAVXoitB4DK6OXsYzm+HPs4o13PzoPEUOVjI1d
	Jx+qc3OBRcBUvMfBDW8WDvenuCif02l4QW3+e
X-Google-Smtp-Source: AGHT+IESdcI6LaDytmK9AInHOqYMv9VljHnolsBwI5gOZUcR1j68rKkzN962JA8SfBozypmh2BajVH84GzpD2gHipck=
X-Received: by 2002:adf:a31e:0:b0:364:a088:6525 with SMTP id
 ffacd0b85a97d-366e79fea95mr9796415f8f.22.1719586856100; Fri, 28 Jun 2024
 08:00:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621-tracepoint-v3-0-9e44eeea2b85@google.com>
 <20240621-tracepoint-v3-2-9e44eeea2b85@google.com> <CAH5fLghb6oVkgy3ckf=dUk9S4VdCeWin+yDBW1ffBoxu=HqBKw@mail.gmail.com>
 <ZnsIJ6ejNX_dAc8f@boqun-archlinux> <CAH5fLgiG5hdh1JJgjH94E=ZwJo6ERkuZUFDpkrrJ6ErQhTvCrg@mail.gmail.com>
 <20240626144313.3f1e8277@rorschach.local.home>
In-Reply-To: <20240626144313.3f1e8277@rorschach.local.home>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 28 Jun 2024 17:00:43 +0200
Message-ID: <CAH5fLgiCT37jiow3NRqupY_a=-V+40QRoGpR8aiu-PmuwbgE9w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rust: add tracepoint support
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 8:43=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 26 Jun 2024 10:48:23 +0200
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > >
> > > Because your hooks/rust_binder.h and events/rust_binder.h use the sam=
e
> > > TRACE_SYSTEM name? Could you try something like:
> > >
> > >         #define TRACE_SYSTEM rust_binder_hook
> > >
> > > in your hooks/rust_binder.h?
> >
> > I was able to get it to work by moving the includes into two different
> > .c files. I don't think changing TRACE_SYSTEM works because it must
> > match the filename.
>
> Try to use:
>
>  #define TRACE_SYSTEM_VAR rust_binder_hook_other_name
>
> in one. Then that is used as the variable for that file.

Thanks. I also made a change to restore the value of
DEFINE_RUST_DO_TRACE after define_trace.h

Alice

