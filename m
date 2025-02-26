Return-Path: <linux-kernel+bounces-534791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A08BA46B31
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC19188B8D3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B54B245006;
	Wed, 26 Feb 2025 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nG1UHMOC"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473BA23F421
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598576; cv=none; b=WrBe4OKvQbx7l7QT8ThvYe6Z2STPBlR9ERHgiQqrP/zxB/jMo++6Q1qAbtR9ojdFf/OOPdLPf154v24ADRdGjCHt2KW0ucBW2KwPgVS9t49g4PYgw7TFE0vQEkxP0//SiQUUixgrT5/siKXGxcAPsETahtaIQqnNImLzhN+tySo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598576; c=relaxed/simple;
	bh=g+iiKdUb2E9CsZarEfg/ev4I8qTrKojqqP3O6+6iWpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6cgFJ7dQHIDqEyPwVYe4b+tZISDz0s0dT+XA7x+vED1CHSZlRvunJZczVdXvPScd63Wfw5qWTmdhq08n8e/C+RRZ2clKmG3bjiMyK10/ggiLCWAPIi3nUhjzQCG+trTbiG8+/4onzPAE4MvV6ls3WL089DhtYQ24lWEH+5EXPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nG1UHMOC; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30613802a04so2061481fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740598572; x=1741203372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0w0u5Y65TictZtMS/POysX6dE7cNRS6012ydb7aso7o=;
        b=nG1UHMOCy8KqMpBle8V+BXHfclIrAjm/x+LuX02Amw0dUXUG+hqAzGmi0NZ+mY0h3X
         yytUXUqGVwGuq7PSOBfclaRYqkxCTL5wLgPKsdXTwzNIdHW8FEcCgFR117+1kerUnAEB
         0p/c1qJm71QzRU3RzjFgjishDQ3ZtKrxl0q4in9L3NKF3wydFyZgb541k1NT4IE72PL6
         9/pR4Y+ZAQhOeA4LLVrOKA0gublbUknd+9hHXYV0/0iKqTBx11bXE+56Qa+55lU8rWk8
         14qMkEhOrzialdvfZWe09cEpgwIiViEfD9lVhMaL0zg5F/iC6eDEJbBZszEJQVi6DMo0
         6oWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740598572; x=1741203372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0w0u5Y65TictZtMS/POysX6dE7cNRS6012ydb7aso7o=;
        b=vD4GKEn0kYlKqXRNw/o/al+gGWBYKu8QTpi3BzmgZ39ocaBdAzrw3eHSXEJDlS3sqq
         vzonHxU/X3khx26rhAqAlqsD8p4wP/V7xv4ApqNsuxRyqDWVjo/Sg384uSzE55GzTShT
         ot85Y4Tqq3ZIUqPyLGfy+MoVJwlVkUUl57msRYUcw+sraMaYl+ZmxjsZaHLKVchq1WTu
         8SwGVD25mQdF3lEMZHicogsqfKWae3Xs6N9a3+dgrqNcNRqFjfwxiKvVu/JBZUYDE274
         cyPokzup/2lxRakkBU1QtHC3hV+6l5W41XCgYTYe+hQHH44WUIZYsjYW3OmBX7lK5ECD
         /2Nw==
X-Gm-Message-State: AOJu0Yy0A/i+PI4DVKI7g8STnqqGep7ujESeNJgJtpH4VCWeTL7SQaKw
	1eXcz7ERv9INb0kRLTyVeYeDx4hlBXP2PWv3dYZZEViL8dN80MpgjvHKQax7/Zom8vLzLHdJc8J
	BlQtxgGhVk2vaUUZf20EgpIqeDRQ=
X-Gm-Gg: ASbGncvZiH5AVEL4FDx2PrxZr+pcpQMjmzzPjyeYZz64LXw8cojKhoCexoONvlhzAxL
	0jFyJXT+SHUWqnbmhFI+OLQjaFVBKIJh4oY1XZbrqePj67BskEZBoTkCY/hAhbMGOevnWGi4z3D
	z4aP7jhRw=
X-Google-Smtp-Source: AGHT+IFs0ic/RO8u43005pYpU4DytPMIS2lDKvgAI3lh+8akwLkFNjNkWbm8m0mxtqFReTj71QDPIRZ+d7PvO3EHN0s=
X-Received: by 2002:a2e:870a:0:b0:309:2267:32cc with SMTP id
 38308e7fff4ca-30a5b216a0amr93288291fa.36.1740598571997; Wed, 26 Feb 2025
 11:36:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226180531.1242429-1-brgerst@gmail.com> <20250226180531.1242429-2-brgerst@gmail.com>
In-Reply-To: <20250226180531.1242429-2-brgerst@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 26 Feb 2025 20:36:00 +0100
X-Gm-Features: AQ5f1JptR_qOFh-LnYrxzHwFRpi5C5IBaSMtujZhRYET_YfK91atd1aPDfHmM_A
Message-ID: <CAFULd4ZP58hPacGp+n_bBZV0e7nomzLMdX7OOu3DEeGe2OxomA@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] percpu: Introduce percpu hot section
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Linus Torvalds <torvalds@linuxfoundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 7:05=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> Add a subsection to the percpu data for frequently accessed variables
> that should remain cached on each processor.  These varables should not
> be accessed from other processors to avoid cacheline bouncing.
>
> This will replace the pcpu_hot struct on x86, and open up similar
> functionality to other architectures and the kernel core.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> ---
>  include/asm-generic/vmlinux.lds.h | 10 ++++++++++
>  include/linux/percpu-defs.h       | 12 ++++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmli=
nux.lds.h
> index 92fc06f7da74..92dd6065fd0a 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -385,6 +385,11 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROP=
ELLER_CLANG)
>         . =3D ALIGN(PAGE_SIZE);                                          =
 \
>         __nosave_end =3D .;
>
> +#define CACHE_HOT_DATA(align)                                          \
> +       . =3D ALIGN(align);                                              =
 \
> +       *(SORT_BY_ALIGNMENT(.data..hot.*))                              \
> +       . =3D ALIGN(align);
> +
>  #define PAGE_ALIGNED_DATA(page_align)                                  \
>         . =3D ALIGN(page_align);                                         =
 \
>         *(.data..page_aligned)                                          \
> @@ -1065,6 +1070,10 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PR=
OPELLER_CLANG)
>         . =3D ALIGN(PAGE_SIZE);                                          =
 \
>         *(.data..percpu..page_aligned)                                  \
>         . =3D ALIGN(cacheline);                                          =
 \
> +       __per_cpu_hot_start =3D .;                                       =
 \
> +       *(SORT_BY_ALIGNMENT(.data..percpu..hot.*))                      \
> +       . =3D ALIGN(cacheline);                                          =
 \
> +       __per_cpu_hot_end =3D .;                                         =
 \
>         *(.data..percpu..read_mostly)                                   \
>         . =3D ALIGN(cacheline);                                          =
 \
>         *(.data..percpu)                                                \
> @@ -1112,6 +1121,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PRO=
PELLER_CLANG)
>                 INIT_TASK_DATA(inittask)                                \
>                 NOSAVE_DATA                                             \
>                 PAGE_ALIGNED_DATA(pagealigned)                          \
> +               CACLE_HOT_DATA(cacheline)                               \

There is a typo in the above macro name.

Uros.

>                 CACHELINE_ALIGNED_DATA(cacheline)                       \
>                 READ_MOSTLY_DATA(cacheline)                             \
>                 DATA_DATA                                               \
> diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
> index 40d34e032d5b..eb3393f96e5a 100644
> --- a/include/linux/percpu-defs.h
> +++ b/include/linux/percpu-defs.h
> @@ -112,6 +112,18 @@
>  #define DEFINE_PER_CPU(type, name)                                     \
>         DEFINE_PER_CPU_SECTION(type, name, "")
>
> +/*
> + * Declaration/definition used for per-CPU variables that are frequently
> + * accessed and should be in a single cacheline.
> + *
> + * For use only by architecture and core code.
> + */
> +#define DECLARE_PER_CPU_CACHE_HOT(type, name)                          \
> +       DECLARE_PER_CPU_SECTION(type, name, "..hot.." #name)
> +
> +#define DEFINE_PER_CPU_CACHE_HOT(type, name)                           \
> +       DEFINE_PER_CPU_SECTION(type, name, "..hot.." #name)
> +
>  /*
>   * Declaration/definition used for per-CPU variables that must be cachel=
ine
>   * aligned under SMP conditions so that, whilst a particular instance of=
 the
> --
> 2.48.1
>

