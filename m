Return-Path: <linux-kernel+bounces-275398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1763D9484EA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A281C21F17
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33E916DC1E;
	Mon,  5 Aug 2024 21:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BMdgQDWy"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684C816D9AC
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 21:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722893652; cv=none; b=lAmJeBTJ8nvA23nfZmyRuQJQMbTC+izbTT4qLIbjlRU5kfvVrn5HypA+Xuq5rlb+8/eb9Bf5cuJ6UFHr4VYW3O1Lf/L8i8Vmt7zaoM+NeB9sXVjlQ3oYtB+0UT2xqqwtLjKHTwRZS2L1fli9Ww10KfIuLl5P4+mjFc1Q5uaO0zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722893652; c=relaxed/simple;
	bh=zqLuGEFdi+P0yo/VokfbNgwJV9KfQByh7n2g/iDAKvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3rxBiq9jN6tuOVPJTgIgBnNhkxewC6A0UMH2ZrkhXhOsOzLGyDYyt9r5B0xEHg9qj9+rj7yxrd4JrA9TBAzdhd1SVJqACXwAWjtWN+hmEMbT/KJ3KQEAFMkDlVfp7lB709Ze1q0Au9LSWo8cpQ2NFcZhJwxau5Cq3BYFG5jj/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BMdgQDWy; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5d5b986a806so2863852eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 14:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722893649; x=1723498449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJj/weLh4AnZstbA8m8zHpr8XkLqzL/0qgZoHSEQ9Eo=;
        b=BMdgQDWyrNyS0XrNSK6L5kKZoTkwRQsFyYHH+DKnyP88a/0fbGjw5atAEa5SaWsIbL
         LpO2VmvbRiRfwR7svPQdWAPsFUrr0vkzh6zNzx0EF814f3R/FuyUm4m4vVpzYULS9HjC
         xqMRZDNAdZFvyvdI+L4V/UjZ1odwuUDsnSnXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722893649; x=1723498449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJj/weLh4AnZstbA8m8zHpr8XkLqzL/0qgZoHSEQ9Eo=;
        b=NByEcM3N4zihLxGgU0zCaaCVFlPgMT2yhoSZEgbgsmTRxRGUJUoEECBGujU/wh5ozm
         Hhh0Hu6OwLSbQJDvm3dVvRwoJ7NUjLQWFRojGfttF3HCW4Hu+fDNpRX/+KFDuWuPk233
         QJlBlQhRhBuEobvdhC48yH85Egwkv506/72wTr9KZt7Q38w5KzN2xx2RSB+YenDUT9v7
         CoXyi8ZMDqzkOuT6/Nm/G8OOwr6Fp7VPvP6z878ua7dVyRQ+NT5uRg9ppUrcjk9iIr8E
         f8oP9jFJ82iog73fU9YqgaQDwkSiyAfNsH5UYS5OLIaebLLMQjt1TytunJg4tVFdrb1K
         TLaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0EALcHRF69iX+ip3eHR4LLW4My9EmX1T4LlI/VD2/9CIg2bb7JKk5y+8t3aMplKYDJWEQQ8EMMabLGJb6zyDeV2WHcCJmlB6PQWH4
X-Gm-Message-State: AOJu0YwiG7BcnYq5HAnk2nzJeuq4pxf9OrD5RycV95cfZLHf8aam03wR
	3Cir1pZVw6IYwWhJmX6xGRa3Y1MwcqoeD2RvQAlLMknbdi4Rxz7kvt04er1Phtzu4TkpWKlOObn
	tGzgtqlLh4fAiW1Ha/0YcBV4WAcQwKpN4YrMT
X-Google-Smtp-Source: AGHT+IE8TLudz2YreomFPKewuIm8hKAgVVHp3aBUWpNonauvOFyC4N7BUufAoKQLSGYePiH0K984kKpEDPpFSCQi7Sc=
X-Received: by 2002:a05:6870:1485:b0:267:dfce:95ec with SMTP id
 586e51a60fabf-26892644934mr6054136fac.14.1722893649241; Mon, 05 Aug 2024
 14:34:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801170838.356177-1-jeffxu@google.com> <20240801170838.356177-2-jeffxu@google.com>
 <202408051402.9C0FA18A12@keescook>
In-Reply-To: <202408051402.9C0FA18A12@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 5 Aug 2024 14:33:57 -0700
Message-ID: <CABi2SkU_TW1+NE6ofFSwiS+XV89d8T-NZy7X+OQi-2dG06O25w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] binfmt_elf: mseal address zero
To: Kees Cook <kees@kernel.org>
Cc: akpm@linux-foundation.org, jannh@google.com, sroettger@google.com, 
	adhemerval.zanella@linaro.org, ojeda@kernel.org, adobriyan@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 2:05=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Thu, Aug 01, 2024 at 05:08:33PM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Some legacy SVr4 apps might depend on page on address zero
> > to be readable, however I can't find a reason that the page
> > ever becomes writeable, so seal it.
> >
> > If there is a compain, we can make this configurable.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  fs/binfmt_elf.c    | 4 ++++
> >  include/linux/mm.h | 4 ++++
> >  mm/mseal.c         | 2 +-
> >  3 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index 19fa49cd9907..e4d35d6f5d65 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -1314,6 +1314,10 @@ static int load_elf_binary(struct linux_binprm *=
bprm)
> >                  emulate the SVr4 behavior. Sigh. */
> >               error =3D vm_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_EX=
EC,
> >                               MAP_FIXED | MAP_PRIVATE, 0);
> > +
> > +#ifdef CONFIG_64BIT
> > +             do_mseal(0, PAGE_SIZE, 0);
> > +#endif
>
> Instead of wrapping this in #ifdefs, does it make more sense to adjust
> the mm.h declaration instead, like this below...
>
Sure.

> >       }
> >
> >       regs =3D current_pt_regs();
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index c4b238a20b76..b5fed60ddcd9 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4201,4 +4201,8 @@ void vma_pgtable_walk_end(struct vm_area_struct *=
vma);
> >
> >  int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phy=
s_addr_t *size);
> >
> > +#ifdef CONFIG_64BIT
> > +int do_mseal(unsigned long start, size_t len_in, unsigned long flags);
>
> #else
> static inline int do_mseal(unsigned long start, size_t len_in, unsigned l=
ong flags)
> {
>         return -ENOTSUPP;
> }
>
OK.

> > +#endif
> > +
> >  #endif /* _LINUX_MM_H */
> > diff --git a/mm/mseal.c b/mm/mseal.c
> > index bf783bba8ed0..7a40a84569c8 100644
> > --- a/mm/mseal.c
> > +++ b/mm/mseal.c
> > @@ -248,7 +248,7 @@ static int apply_mm_seal(unsigned long start, unsig=
ned long end)
> >   *
> >   *  unseal() is not supported.
> >   */
> > -static int do_mseal(unsigned long start, size_t len_in, unsigned long =
flags)
> > +int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
> >  {
> >       size_t len;
> >       int ret =3D 0;
> > --
> > 2.46.0.rc1.232.g9752f9e123-goog
> >
>
> And if it returns an error code, should we check it when used in
> load_elf_binary()? (And if so, should the mm.h return 0 for non-64bit?)
>
It shouldn't fail. I can add pr_warning to handle the error case:
pr_warning("pid=3D%d, couldn't seal the page on address 0.\n",
task_pid_nr(current));

Thanks!
Best regards,
-Jeff


> --
> Kees Cook

