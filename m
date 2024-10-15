Return-Path: <linux-kernel+bounces-366075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF5B99F079
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5F92819E5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699431FAEEB;
	Tue, 15 Oct 2024 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nbUwBxfg"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18541FAEE7
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004139; cv=none; b=VSLgwZ4ruyaCc2iE8tiDGIu/l/YdrlxUUiTe/sEdDO0pHrZq6s0ML0DC1fCGuqWHZZqWjGkU3w5zV0blCcqaid6oT84KcyofKf62yKgnuUnhBHc8VlfQ1pS9Sn8gV06LRoqmNliYqpugG9K/v1xFMOSl9jcLPo9uThiIelfwK1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004139; c=relaxed/simple;
	bh=VeHVtin04YMbNdDANnwUhAhwv4ZW4ddx4mf/rqjQ9vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TK94x0TtoYlj6fYk66MvakXSJV/UwDeLgZFazEyCGpCGuexBKE7NpvsTQ6fZLw/kTEC1o+qKcJQXnbA/eAHuAu9jBEukRepSQyu99q8VzuZPuM2rRk/K4lv54DHQcxscaCfoOMBh1FFm0nGL3MJdE+W/CKurQc7xTneeMU0aHoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nbUwBxfg; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb58980711so16931921fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729004136; x=1729608936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeHVtin04YMbNdDANnwUhAhwv4ZW4ddx4mf/rqjQ9vo=;
        b=nbUwBxfgPT9dpu9EUAuzNg+LmUgR9MZCNDDZ09fQajxXEL+3rjGenykA5Obz06O6He
         hUG9I9mCxpbk6JtSWpG/Lyza1aoNGRGpJfwZ4zt/ENa3PIklfZSRU3tl8PdoG1dvcv1J
         8Rs3CHIZTlI1Pau7RN7SdkG7uqEw+JOzHrZsqv4eZ4berXbqKYPD1vhccUgXA7ob3mec
         7A/w/452LxWZg+Pz/zYGwMTZ+XM+7017dwreEOEVZ9AmvOON8BDCx9mq0kXDG/78Gdoo
         rf2SeBe1od6mX0WJh3Kh8roF/2FNyeA1Y9ELj1um3pAmPTtXerbk5EdL025QS1zk67CK
         +X0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729004136; x=1729608936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VeHVtin04YMbNdDANnwUhAhwv4ZW4ddx4mf/rqjQ9vo=;
        b=ah7Oue8RsQrhugKX61ldyKkTJhDJjfoOG2l0qPoPLmXGQ0voHq0iMNTW9OncFpLfHV
         8wuNkqG2KZ9agMqUPB00JzTdPe/PvCKqe5qKBgBctQUkdOVV2VLUOh2vtccKS1UIeMIJ
         EDTT0v8Co+IXoXzdRQ1Tl6hkBfSwkwIeJfYWVh/eWsgqtKpFxcX0UCi2IEyyRR+sHIOb
         R6ljXDgDi6rCfpoTWSMmEF5u9Q1YsRPhK/An3+Iw7bA4sbae6GlsZt8XVqUc3OXBcXRX
         n8eEyN6naj9aNBDMwYJMorHNwaF6LFDSdAd7H23zpNg2z9C20SAh1ttOJLCDz6+kqqo6
         ibIw==
X-Forwarded-Encrypted: i=1; AJvYcCWvStuJ30lsfJTHvbjmM3mwJaIQcNPHn1aeabuJ0/j2SIHCddJCRcTwi/O4A9tXfFKaBrbD6sIC+WMk2OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBTSxNSpOciETyR2TK5cpLIDsVUvHJCM3MdlPGpJ8YEvxSscqR
	ij9orqYRg5415bOE6xXkSNZYZb6PQs09fEGHuLkFUMGoaNn0ee2/yWOTHGY9gD5BWYfDsm69Lro
	aJ2RfMYSHWEBk2c2TnBq0iFK2JpD3LRjV02wZQQ==
X-Google-Smtp-Source: AGHT+IHe1hepoC1K7fGWGmywx94Jj36HM8McPm3iSpQxje7/hhxzz3+rcx6aXTe1IeAO7GFfcjjO1asR7o77DGG5xN0=
X-Received: by 2002:a2e:5109:0:b0:2fb:60d8:744d with SMTP id
 38308e7fff4ca-2fb61b585cemr4274281fa.19.1729004135784; Tue, 15 Oct 2024
 07:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com>
 <Zw5D2aTkkUVOK89g@J2N7QTR9R3> <CACRpkdY79nbBoaHe6ijuyJS9dDduNw_sv1J90pz121YDgCvC3Q@mail.gmail.com>
 <Zw51fhCkmCYrTOeV@J2N7QTR9R3.cambridge.arm.com> <CAMj1kXEcLD3PWd-9osjo9AOe5Jg-NMOmJ8afB_x7VeboueLoeQ@mail.gmail.com>
 <Zw59x0LVS-kvs9Jv@J2N7QTR9R3.cambridge.arm.com> <CAMj1kXEnhHkxywh8TH1i=fmyAR8cXZ8D-rvV43X-N7GpCf2Axw@mail.gmail.com>
In-Reply-To: <CAMj1kXEnhHkxywh8TH1i=fmyAR8cXZ8D-rvV43X-N7GpCf2Axw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Oct 2024 16:55:24 +0200
Message-ID: <CACRpkdbwS8L9_O_paqiW3B3x_-CmrQeYajhO7jBW4-c2+D9gyg@mail.gmail.com>
Subject: Re: Crash on armv7-a using KASAN
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Clement LE GOFFIC <clement.legoffic@foss.st.com>, 
	Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	Antonio Borneo <antonio.borneo@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 4:45=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
> On Tue, 15 Oct 2024 at 16:35, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Tue, Oct 15, 2024 at 04:22:20PM +0200, Ard Biesheuvel wrote:
> > > On Tue, 15 Oct 2024 at 16:00, Mark Rutland <mark.rutland@arm.com> wro=
te:
> > > >
> > > > On Tue, Oct 15, 2024 at 03:51:02PM +0200, Linus Walleij wrote:
> > > > > On Tue, Oct 15, 2024 at 12:28=E2=80=AFPM Mark Rutland <mark.rutla=
nd@arm.com> wrote:
> > > > > > On Mon, Oct 14, 2024 at 03:19:49PM +0200, Clement LE GOFFIC wro=
te:
> > > > >
> > > > > > I think what's happening here is that when switching from prev =
to next
> > > > > > in the scheduler, we switch to next's mm before we actually swi=
tch to
> > > > > > next's register state, and there's a transient window where pre=
v is
> > > > > > executed using next's mm. AFAICT we don't map prev's KASAN stac=
k shadow
> > > > > > into next's mm anywhere, and so inlined KASAN_STACK checks recu=
rsively
> > > > > > fault on this until we switch to the overflow stack.
> >
> > [...]
> >
> > > > > Yeah it looks like a spot-on identification of the problem, I can=
 try to
> > > > > think about how we could fix this if I can reproduce it, I keep t=
rying
> > > > > to provoke the crash :/
> > > >
> > > > It's a bit grotty -- AFAICT you'd either need to prefault in the
> > > > specific part of the vmalloc space when switching tasks, or we'd ne=
ed to
> > > > preallocate all the shared vmalloc tables at the start of time so t=
hat
> > > > they're always up-to-date.
> > > >
> > > > While we could disable KASAN_STACK, that's only going to mask the
> > > > problem until this happens for any other vmalloc shadow...
> > >
> > > Is the other vmalloc shadow not covered by the ordinary on-demand fau=
lting?
> >
> > It depends on what the vmalloc memory is used for; if it's anything els=
e
> > used in the fault handling path, that'll fault recursively, and it's
> > possible that'll happen indirectly via other instrumentation.
> >
> > > When I implemented VMAP_STACK for ARM, I added an explicit load from
> > > the new stack while still running from the old one (in __switch_to) s=
o
> > > that the ordinary faulting code can deal with it. Couldn't we do the
> > > same for the vmalloc shadow of the new stack?
> >
> > We could do something similar, but note that it's backwards: we need to
> > ensure that the old/current stack shadow will be mapped in the new mm.
> >
> > So the usual fault handling can't handle that as-is, because you need t=
o
> > fault-in pages for an mm which isn't yet in use. That logic could be
> > factored out and shared, though.
> >
>
> Not sure I follow you here. The crash is in the kernel, no?
>
> So there is only a single vmalloc space where all the mappings should
> reside, but each process has its own copy of the top level page table,
> which needs to be synced up when it goes stale.

That's how it works AFAICT.

The vmalloc/kernel space is mapped using the very same
actual page tables in all per-process MM contexts, so I also
think it's just a matter of syncing the top-level page table (PGD),
so I will try to do that.

Yours,
Linus Walleij

