Return-Path: <linux-kernel+bounces-537182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5E7A488F3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471BA1889BDF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC9A26E96F;
	Thu, 27 Feb 2025 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIkpYg7+"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8439925D911;
	Thu, 27 Feb 2025 19:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684336; cv=none; b=kBsf3KTyD+H/pAp9qbIhC9VdLta0ZAzcGnnrvjlU8SN8gAJ5PZuO7Vh8dFXk2ZRlP05rbTrsr078uvR8lg2V7SxvuxmPzrSirBt7beq7Hm64qIIUZbrnmraJUdPP99XAPjUs40HV5qsRzKozkCLgK2wd2+w67Qw7wEfXyNbIVAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684336; c=relaxed/simple;
	bh=I4osQ5RPj6E7bXAobrn2V0yGZ0kIauATo/Cf+WI8eCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciL1SMYOY2dyoRK5Hom0B8jyK888AwjsCPFgy3d7ngEHUEEXumVNSfxH/ftQALxMbQ9teSaRlr2bK0aPU/ojPW8pFn6Z6ANLXOHVac60M7bALcBx0pWYdLnfzrORJO9ECa4u3mCIOrRjSNHEQqZdLABkLH1lXtziOS10HbESaiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIkpYg7+; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5485646441cso1401551e87.2;
        Thu, 27 Feb 2025 11:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740684333; x=1741289133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cocSoxI0vBLolc8jUN8YVirpU/dxiOfgNogxYs9IIlU=;
        b=YIkpYg7+7tYmpr7UVMzDA4tEJQkWwCZtOu0YJ3COFAxkPWdH4VKQrvhLmg8EpLym6b
         2RSvmwjzPbuSs817BpWejdtGq+JsjyV/o7GUsjablqIQFMNO1omRkrf8/Q4ZdgsfgWCN
         fUFpiia0Zi+2yKchrD0zu0UWTG9HZVOMXutey52kI+qaf5Z8I0MRGoRX9wUi3huj8tpK
         qvrm5vWtNZ+TgNvWY6tNyCpFBoZJEe7waxqlbntwBUhYY0aKC8CG/MhwvUfSreoHYE36
         mpyguEQOsvhq9X0TqmoOaSU7PqLzScMJyPQ1KoX9gsMeZtR+Cfk8RZhR4dTwXvpdcMwK
         slnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740684333; x=1741289133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cocSoxI0vBLolc8jUN8YVirpU/dxiOfgNogxYs9IIlU=;
        b=GYPre0N8YMcAYcjpFyjt+CpxAEzbentr/ZoaT/x7HofZrhEc/40pmPq0d+hoc2yWgU
         7C1XG/wOhrMKN9U6eBTuHO2YU/6msktxaQHZ/Gao3ETB+yP5XKZXB9k/0Wk+OsFTuA2t
         J60IoQu8KyfFwoOWASPKFDor9w6cfcSXwQVlnLp6drVNinEmTh9PqmbTKEKUTT6PKcSR
         aCzG+m7ZlgwyYyLucHVR0F3BHl3h+SFaCCWWVK/BPWipsQcGW8rKXfxBYl8PLj5JGal9
         49n6lY7qsUzvvkknNk/kiR6A6hBwx3IlRmtDhRY2FqHKYmmvwJt75k78YvQOhZMxHmKb
         xSvA==
X-Forwarded-Encrypted: i=1; AJvYcCXKt4UDhtldXpdSy5sOeCIF1Fj8rKPB0uq/nb4VKYTtYvb3XeB2gIIZy9bORqbl+2iuY6kKo/OQPMGbYFgi140=@vger.kernel.org, AJvYcCXPDetVFxnGbpGVD3fjt4/Cg0McBxpU+oyE3HMilkNvWTn95Mm951dGuQ0XcTTty+k2NGmEY6HFrNwhmJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN7wUwsYbO5PFAy9Z3C6N0LBv31N0e2VQLwgkW73OOWwcEJxCp
	32i22d00Co++WwZqM/oy9/TA0LU5QLGJoy2rlU9hm7fP4sDVHCzX/1bjjLhGi7fUjuI8ZHEtXdO
	9OoQUlib2fMqCtJULkG1FUUB73h8=
X-Gm-Gg: ASbGnctBcNMjY/viNuVn8jv8ufXGQt4sd0qSnT60ei80+H7BUslYnKVurfvgGTl/SjY
	I9CWmN8IVclHm1QotSv/VYbOGqJ2Hk+vLNIyvg6/uO1b0y2XFfR0YVO26a//POtCTZMrzCHMDLc
	LjffYjZ05F
X-Google-Smtp-Source: AGHT+IFSs2bI1kvd8svQvV0yYqC4L2f0QU31S933XS4fK48/mlI2CA8/SvzCilIe1uYB4dcFtVyxl2+NSdpFe8SrYp0=
X-Received: by 2002:a05:6512:4021:b0:546:2f44:ee99 with SMTP id
 2adb3069b0e04-5494c11b5b0mr270889e87.17.1740684332213; Thu, 27 Feb 2025
 11:25:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CANiq72mdzUJocjXhPRQEEdgRXsr+TEMt99V5-9R7TjKB7Dtfaw@mail.gmail.com>
 <lz7hsnvexoywjgdor33mcjrcztxpf7lzvw3khwzd5rifetwrcf@g527ypfkbhp2>
 <780ff858-4f8e-424f-b40c-b9634407dce3@ralfj.de> <CAFJgqgRN0zwwaNttS_9qnncTDnSA-HU5EgAXFrNHoPQ7U8fUxw@mail.gmail.com>
 <f3a83d60-3506-4e20-b202-ef2ea99ef4dc@ralfj.de> <CAFJgqgR4Q=uDKNnU=2yo5zoyFOLERG+48bFuk4Dd-c+S6x+N5w@mail.gmail.com>
 <7edf8624-c9a0-4d8d-a09e-2eac55dc6fc5@ralfj.de> <CAFJgqgS-S3ZbPfYsA-eJmCXHhMrzwaKW1-G+LegKJNqqGm31UQ@mail.gmail.com>
 <CANiq72mw_zo4ai7QWD5eLN_oFXE1RVkotFsGS+f=6LRmJoHM7Q@mail.gmail.com>
In-Reply-To: <CANiq72mw_zo4ai7QWD5eLN_oFXE1RVkotFsGS+f=6LRmJoHM7Q@mail.gmail.com>
From: Ventura Jack <venturajack85@gmail.com>
Date: Thu, 27 Feb 2025 12:25:16 -0700
X-Gm-Features: AQ5f1Jpv6efWrpBsz_NNHvYeXfkaD5e-40YnVta7Hcw-aWaliwo1gWLR8BsXl_0
Message-ID: <CAFJgqgR+hFY3XkUusq0HkdgUEp54kpQH7zJi8WcgYNB7i33ygA@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Ralf Jung <post@ralfj.de>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Gary Guo <gary@garyguo.net>, torvalds@linux-foundation.org, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 10:59=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Feb 27, 2025 at 6:34=E2=80=AFPM Ventura Jack <venturajack85@gmail=
.com> wrote:
> >
> > I have seen some Rust proponents literally say that there is
> > a specification for Rust, and that it is called rustc/LLVM.
> > Though those specific individuals may not have been the
> > most credible individuals.
>
> These "Some say..." arguments are not really useful, to be honest.

I disagree, I think they are fine to mention, especially
if I add any necessary and relevant caveats.

> > A fear I have is that there may be hidden reliance in
> > multiple different ways on LLVM, as well as on rustc.
> > Maybe even very deeply so. The complexity of Rust's
> > type system and rustc's type system checking makes
> > me more worried about this point. If there are hidden
> > elements, they may turn out to be very difficult to fix,
> > especially if they are discovered to be fundamental.
>
> If you have concrete concerns (apart from the ones you already raised
> so far which are not really applicable), please explain them.
>
> Otherwise, this sounds a bit like an appeal to fear, sorry.

But the concrete concerns I raised are applicable, I am
very sorry, but you are wrong on this point as far as I can tell.

And others also have fears in some related topics. Like the
example I mentioned later in the email.

>>[Omitted] several
>> issues are labeled with "S-fear".
>>
>>      https://github.com/lcnr/solver-woes/issues

Do you have any thoughts on those issues labeled
with "S-fear"?

And the argument makes logical sense. And Ralf Jung
did discuss the issues of osssification and risk of
overfitting.

I am convinced that succeeding in having at least
two major Rust compilers, gccrs being the most
promising second one AFAIK, will be helpful directly, and
also indirectly allay some concerns that some people have.

> > You mention ossifying, but the more popular Rust becomes,
> > the more painful breakage will be, and the less suited
> > Rust will be as a research language.
>
> Rust is not a research language -- I guess you may be including
> features that are not promised to be stable, but that means even C
> would a research language... :)

I have heard others describe Rust as experimental,
and used that as one justification for not adopting
Rust. On the other hand, companies like Amazon
Web Services have lots of employed Rust developers,
AWS more than 300, and Rust is probably among the
20 most used programming languages. Comparable
in usage to Scala AFAIK, if for instance Redmonk's
rankings are used.

Best, VJ.

