Return-Path: <linux-kernel+bounces-235842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7882991DA57
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15F23B22BA7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D112484A28;
	Mon,  1 Jul 2024 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DA/lPSUI"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB10839FE
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823611; cv=none; b=JC64/6iXsc2GH7ZXNd/VBQM8XKcVwYM+KvFUbdVWpjt+f2MXndftb/wUBb6PZKEKgFUbmFknRa4JLjBDNYbD6Sxj0IMm1ER4CpbIYppqpimjaKRTYgBZl/HzWHitIkl8DrTobUQ45wc8HR1kTQ4fImc0U5CrxGrwA7ont/81d9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823611; c=relaxed/simple;
	bh=Ek0djV4tlk59IdVII3ggD233/gJaTISJ3GpZV/+ZGTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1ARwDaxT7VrTW5DebYJ+Som9S0ZREBTwqSjuo0rTk0qqXypQfvGBW1Pk4YuSW+ljOo1UZMhO1QeC1Qfv/mynSVSQzNixvTWFzTZhcrZ3XtmSLOw1lq6MPgqO/5XObcJMNJIW1M1QbG+tpK87cQD4lOlQcZA5tjOi0QjrL+t9/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DA/lPSUI; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52cf4ca8904so4273492e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719823608; x=1720428408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+1tnkhEuXtfOoARakIg8mbFt2StTuYRqdlzd6B2WMY=;
        b=DA/lPSUIR2Qr0hJaaw3RUBzRxoVFnCkxoldJEr5SFhtaksyXA4Uy7+EvMi1FRTt1+W
         GBM22wzL/lbijbeElZnFtTzwB1GkrTl2pL3DBIcGwTHE8uy6ngqZi+IVZUITaRe6uxQ+
         FlRTrAdtz4iNhP4jMfE58aoL9f7Vdnz8sfNK9IminmkcoaxEVSUIdQq0TnuqI7HPHeUm
         qdodczZAokEvW7oOB/9qDxBShdxvwFQJjy/38dQ6Tc2riI4yUEd6hKUaKqf6bpX+++dO
         3zqZokEkxyh66c8ru1HkR+c3PuVcwdNuYv/Kt9x5SAakqQHOlbhTtxmr9cW63n3GI3P9
         gv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823608; x=1720428408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+1tnkhEuXtfOoARakIg8mbFt2StTuYRqdlzd6B2WMY=;
        b=kK3ohK/KXwTCcIcA9bNWjNMxKgncb8j1R7R+LvupSMy+EpDBX3mTK4XC+AafJB4opU
         24SA8CkNhhmoVpXv9j6zaWH8p3rCwn1DDCRd0ZbS3N4nknw/WzsooQjptOH68xl1jyxJ
         Dbywx38TV+5BUmtERArbZCoh+BVRSXkiK2c9vzQ92H58TQ4thJ5CjPQbcMg2jzIHQtvX
         L8WnHUBfM3e79g+4P21MQ53jgygD9TEAgHBFs+YVpMdyUpATky4ZY8DiWO3DcKmOXu4W
         mnIUu09i3dESOc/ym/h0e7KHf7xJbfMlZwxyJhthYACjsrphF67cDIMvdxPAsh1UiQW9
         tg0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFP99W4/+9+aAYuHB4l0/nklELRBgFqMzBb6Tm0XrT/YMryeSCFVltswjp2l4+lTX7853pY2DWR/mXuDrIrSjGiswdM+CKEJTEpBep
X-Gm-Message-State: AOJu0YxFxvkznfCtDWgOcblkIy6O8MTecTWi6zoVHsMb7bcIV4bCLro3
	GRzHcoaXosSn2cWp/jUleDZcLN8yLaH11C9bOwryubRy/4WlAIaA5MDs2puNxybmiCkcth5JgR+
	POa7n3V6QXn7c3lKMAF37wJRd1RBUFrcZjB7Rgg==
X-Google-Smtp-Source: AGHT+IHAoJW3lqKQlJq95t+IoDaN1o8zvLJKzRTavFHFh6Y5ZDBi3s3lgQXQjeCldl9vN/YuJW8/OgZC2Oes99WqFjc=
X-Received: by 2002:a05:6512:3da3:b0:52c:c89d:ddfa with SMTP id
 2adb3069b0e04-52e82744d30mr3919617e87.64.1719823607504; Mon, 01 Jul 2024
 01:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625121652.1189095-1-lgs156412@gmail.com> <Znug8e2cUzuA9qGu@kernel.org>
In-Reply-To: <Znug8e2cUzuA9qGu@kernel.org>
From: liangxi Liu <lgs156412@gmail.com>
Date: Mon, 1 Jul 2024 16:46:10 +0800
Message-ID: <CAPRrSS9ejhKPZUhgaBaXjePuTAA7BFDGuo=V2yTbCK1HMwUcRA@mail.gmail.com>
Subject: Re: [PATCH v2] memblock: export memblock_free() to free reserved memory.
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, liangxi Liu <lgs156412@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes. we have a reserved memory used for display the image, which needs
to be deleted from memblock.reserved list(memblock_free
()) after display and then released into the buddy system(free_reserved_pag=
e
()). Should I use memblock_free() or another API?


Mike Rapoport <rppt@kernel.org> =E4=BA=8E2024=E5=B9=B46=E6=9C=8826=E6=97=A5=
=E5=91=A8=E4=B8=89 13:05=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jun 25, 2024 at 08:16:52PM +0800, Guanshun Liu wrote:
> > On architectures that support the preservation of memblock metadata
> > after __init, allow drivers to call memblock_free() to free a
> > reservation configured in dts. This is a hack to support the
>
> "This is a hack" implies that it's not a proper solution, right?
>
> And anyway, memblock_free() will not actually free the memory after __ini=
t.
>
> > freeing of bootsplash reservations passed to Linux by the bootloader.
> >
> > Signed-off-by: Guanshun Liu <lgs156412@gmail.com>
> > ---
> >  mm/memblock.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 6d18485571b4..20e7f81fc076 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -848,6 +848,9 @@ void __init_memblock memblock_free(void *ptr, size_=
t size)
> >       if (ptr)
> >               memblock_phys_free(__pa(ptr), size);
> >  }
> > +#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
> > +EXPORT_SYMBOL_GPL(memblock_free);
> > +#endif
> >
> >  /**
> >   * memblock_phys_free - free boot memory block
> > --
> > 2.25.1
> >
>
> --
> Sincerely yours,
> Mike.

