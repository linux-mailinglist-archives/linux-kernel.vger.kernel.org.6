Return-Path: <linux-kernel+bounces-252168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEDD930F67
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0399F1C213FA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C71184131;
	Mon, 15 Jul 2024 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jUKypdCY"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34349184106
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721031156; cv=none; b=Hhmb7Z63GNcZjjTZKMiqBGq8+BndJ0VinPm9pOyRl0aa7Ys47uEwvFSMDDHZgJNeBFBmqXjRY8DuQNQef9L+FuJn7LCoetmE5SilT3t+d0BRFnpo1lCf/Crx3CUJyj4QY2Bo+hHuJpDaHRZ+XkFp7hU8kfND4Z0Lu8L1+LxtgNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721031156; c=relaxed/simple;
	bh=5NT0nQnnuvnj76YU9TmtoXstPxW/ueKhrxD8hU9yT+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTZw5utq8g1lLegNTEbs1D0f/g7Jjv5KRRD+fDQL4wx6tFFRtLCv7Fj4ZhzemPkmzjXeeiApsKs6KrCFFzO4C5rsq0+Wr/P3A9VJ07IBzPMz+WOA9o2fN7c4IMFJyrd+PIwZHblxJOYnf5p0LrvDS2erKNxOsocqSqET/p5QUoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jUKypdCY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77c1658c68so438778866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 01:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721031152; x=1721635952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03jWWWCVzc5/LJdqyioI99prKjte6wH3TiKjV7DS5tM=;
        b=jUKypdCY0qNpX8Vc/i5UXyx0VbW9NdWlG8SWSGWJ89cL0H+9Fvjy9/b9SGpcdP1MCS
         Eem2l1xkAg/SQgZXCCg2EPqABTBhZn9CCcWAP+ty7t9bWpULQwA+OORjW6KSd3Ld85AP
         hFg1clu9Hh5Km27E8Aao28WbPhKipRK3gmLm+ep5iV8U6BWLEsmBmsRiu8o/yt8kbBLK
         0IBJOpwuAX83n6Fs9aLUtX13p8ej0G3HMRtNrCgpnYHPOmrK08uJWzAqrim+Sv+GMrcD
         b5sp3Tk85z8IbuZ5NTQn4/JQqp2oxri9gxHGUIjeUF3yB3YaVpSP2+KUDAm1E3rgrNfl
         WnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721031152; x=1721635952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03jWWWCVzc5/LJdqyioI99prKjte6wH3TiKjV7DS5tM=;
        b=F8GffrDrXX1zwBQeD8XiP1hudcQ9cGpdhkDuqE99qtarqMEhRI5prHvQhD1649bppQ
         eyqoVBcszDpQtGtMC7IyuHzmU0gPIriBqcm8B7clV2SXhUSxyjFAmcptYMUImfBZgEsS
         YsI8ra/6qkfwBKUiiXIxop75jOf9J4k3N+qFMO8urfkJGK1taKyyyrCfJHUYmzv5Baez
         07DXMAsuUcilSjRJ19Iwv1d8qE5syE1GeHS7dJe2h5YEjqSzO5BgaeIMqwV91L2nxNe3
         NlcACUgDopEQA90ryapEk0PwuHGxBIQJHNUMJdG4FC1SV3yufsBArCaKlNBt1VQXWYOR
         hBbw==
X-Forwarded-Encrypted: i=1; AJvYcCWuI4l1FDgtkTGKGMLGeLcZnPLvzuN0m5v/D9VlGqlevx2gOvqIufenHwvmOGxgjzMAavTZogIY/2rgW+Rk7lAQS3aeHXz4HW1fNDWx
X-Gm-Message-State: AOJu0Yy9yDOW+SLQyObwjUNk+pmBoybrJVmJ51TggMqICnGVpEUnGjAF
	0YMxr0i6wHvjafbADWXNoUVSNHOTptCczPhF3Cn6eIaHhdhrjgwDAJYvztq5wPTjkeKb66Fiys7
	5V5IEW+ztOPSCSUrfwCSv7Ts3BknRSyo6+aiWhQ==
X-Google-Smtp-Source: AGHT+IFAM/JbPKSHGtXJzUtImNJqPcsuIujR27+IbnzngqO96PYEia8kBR8MYr6ACsxPM+BKbwLFE6qk68WRrNEudhw=
X-Received: by 2002:a17:906:66c9:b0:a77:cf9d:f497 with SMTP id
 a640c23a62f3a-a780b70513emr1187421166b.40.1721031152552; Mon, 15 Jul 2024
 01:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624082141.153871-1-alexghiti@rivosinc.com> <CAMuHMdUwx=rU2MWhFTE6KhYHm64phxx2Y6u05-aBLGfeG5696A@mail.gmail.com>
In-Reply-To: <CAMuHMdUwx=rU2MWhFTE6KhYHm64phxx2Y6u05-aBLGfeG5696A@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 15 Jul 2024 10:12:21 +0200
Message-ID: <CAHVXubicJ=g_vXWUh+uGbv00X0gnn24J3SCaU4PhRD-1ZReY8g@mail.gmail.com>
Subject: Re: [PATCH -fixes] riscv: patch: Flush the icache right after
 patching to avoid illegal insns
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Andy Chiu <andy.chiu@sifive.com>, Puranjay Mohan <puranjay12@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Tue, Jul 9, 2024 at 10:13=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Alexandre,
>
> On Mon, Jun 24, 2024 at 10:23=E2=80=AFAM Alexandre Ghiti <alexghiti@rivos=
inc.com> wrote:
> > We cannot delay the icache flush after patching some functions as we ma=
y
> > have patched a function that will get called before the icache flush.
> >
> > The only way to completely avoid such scenario is by flushing the icach=
e
> > as soon as we patch a function. This will probably be costly as we don'=
t
> > batch the icache maintenance anymore.
> >
> > Fixes: 6ca445d8af0e ("riscv: Fix early ftrace nop patching")
> > Reported-by: Conor Dooley <conor.dooley@microchip.com>
> > Closes: https://lore.kernel.org/linux-riscv/20240613-lubricant-breath-0=
61192a9489a@wendy/
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> Thanks for your patch, which is now commit edf2d546bfd6f5c4 ("riscv:
> patch: Flush the icache right after patching to avoid illegal
> insns") in v6.10-rc6.
>
> > --- a/arch/riscv/kernel/patch.c
> > +++ b/arch/riscv/kernel/patch.c
> > @@ -189,9 +205,6 @@ int patch_text_set_nosync(void *addr, u8 c, size_t =
len)
> >
> >         ret =3D patch_insn_set(tp, c, len);
> >
> > -       if (!ret)
> > -               flush_icache_range((uintptr_t)tp, (uintptr_t)tp + len);
> > -
> >         return ret;
> >  }
> >  NOKPROBE_SYMBOL(patch_text_set_nosync);
>
> patch_text_set_nosync() is now identical to (static) patch_insn_set(),
> and the latter has no other callers.
>
> > @@ -224,9 +237,6 @@ int patch_text_nosync(void *addr, const void *insns=
, size_t len)
> >
> >         ret =3D patch_insn_write(tp, insns, len);
> >
> > -       if (!ret)
> > -               flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len=
);
> > -
> >         return ret;
> >  }
> >  NOKPROBE_SYMBOL(patch_text_nosync);
>
> patch_text_nosync() is now identical to patch_insn_write(), and both
> functions are called from outside this file.
>

I'll do something about that, thanks.

Alex

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

