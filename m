Return-Path: <linux-kernel+bounces-226789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 230E59143C9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE4C1F2166D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 07:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B730F4502F;
	Mon, 24 Jun 2024 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q16CcNBA"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F0B4436E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719214583; cv=none; b=uNsR+ulIJCFn+gE9ZlNxcy/zS2aal5fuFrS2K4QlDqHd9cFCPzeYACqVlfafFCrG0FZHsZansK6zub7NR+MUlhZkGvV/qWdyRgAPbQfzvUGcq1DH2a1TvPIt4qmFzcvCTy5p41Csxf0MEBz7cc4hmGZmDbOgy3lOninQyknHZb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719214583; c=relaxed/simple;
	bh=dHsJIKi9ltWh5KwIraHj+1vuh/acJSsWcHwISUsG3+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YW0AiJxeBXX7HdoN9qcaA+pEUSwttN2jlU0/GTd552W/vztdqS13AcA2uLTGrOGFdiYy1AUuXLYZcDvtPtkAOed8u3RpC2bOPOhJCRFHWr407D9UNjDA8hyv9Y0WLIDnBdk0FE9mkhnq2BuTzu2D7Mw2Vv4gkh+5W4UnoS3vfdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q16CcNBA; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ec0f3b9cfeso46133271fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 00:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719214579; x=1719819379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+BXhTT8wJwtF1XUw6xsdMcrYOPNMj2Yz6sCSEx+NqU=;
        b=Q16CcNBArba641PTrPkgji12TbdhPIUlz2I4vtWkAgUow++eniDwCyXvJ2VW4ug4HM
         5JeUOn/3zbdJ4F8xkO5Wi4QE5oX1HUbBUJBJopo1MeWxY0/H1eIH1C1LinoSwxr/OONV
         dR2KIelt0dM97LSL2xf4jSe/5ec8Pbb00zZXe8B34hfzSVHLRR6yH1qN+l4ZDUclOa0l
         jmfvvWdp74rVnWdv6TviV2Uc+gKFlOadCA8jXUglUGbKc5NHFHjZeB5aG7lcV72wBND5
         sTn6B9ChfjosCwkdOAX9O3dNYvN0uEjoqJJpfuoNymKBT5RpkTO6YvARKtqKCCwTyrXc
         QYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719214579; x=1719819379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+BXhTT8wJwtF1XUw6xsdMcrYOPNMj2Yz6sCSEx+NqU=;
        b=rx8teT/kjx9hWY20fX3Ocws93PfqHc7qGa+tLIuupDgn45/WrTxNzQmQEnAp3QMTsQ
         mi0DVHr+FrhrZpffle81UBXk/sgI2MyIZr9eGIkp/8HclssE42gj728EV+5X4/1cnuO+
         izpyxSam5h3GigKnB8x39lsgy9w4JCcebwdqtNZExPps3qq5mJYFuv/TunItRXjgMm6u
         lri9RiiJcgu7Wobc5n0oDgp0MabhGJLyNfuhZoHx17WQSuudc2Gk7jq720IzOeH3M3NF
         ZXT8cykzAT8TdPDAp7GjGuIp0l3GIEaooV0qrAjOfQPBM6LtLGwSmM07KjhAtFhT3PQS
         Embw==
X-Forwarded-Encrypted: i=1; AJvYcCU5htcnsD+JNrpsBYh5hw0tgAK/PWmfaiUUNr35PUGZJ7pbbGR1DPske2nubhuceFHsDowUrNjQ4TuiF3j63vUo18cs2nVq9Sd0T+p0
X-Gm-Message-State: AOJu0YzDjhLLrskPS1RDaO6k3vciCgxMGjXquxiUt7cfRKfOYVlf+Bmw
	W4lQzuTbmv5Aupxoo7SDFyCqBF38s1q90CFZJ53OQfJkQvHOqxRn8yjYs3GT+UWSfoY7TiZ3y8t
	M85Qq20akl4HhYaOAz9JGsFnocdM=
X-Google-Smtp-Source: AGHT+IGXZ2dKLPFOeHXuatNNmFtCBKoMKvpZwLsfp6Uh4dJHvhw8Cb++fMZqdAq6WqTx8LCmklFshiJp19joklFOf7k=
X-Received: by 2002:a05:651c:1036:b0:2ec:1042:fb04 with SMTP id
 38308e7fff4ca-2ec594d00bbmr24643951fa.35.1719214579180; Mon, 24 Jun 2024
 00:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406230912.F6XFIyA6-lkp@intel.com> <CAFULd4YVOwxQ4JDaOdscX_vtJsqJBJ5zhd0RtXXutW=Eqh29Qw@mail.gmail.com>
 <CAHk-=wg1h4w_m=Op1U4JsyDjsvqG0Kw1EOVMQ+=5GX_XytdorQ@mail.gmail.com>
 <CAFULd4YR-VkAOKiS5yxSUYi0YMzY1p=pkYe4dOkgFs+A=9AFFA@mail.gmail.com>
 <CAHk-=wi_KMO_rJ6OCr8mAWBRg-irziM=T9wxGC+J1VVoQb39gw@mail.gmail.com> <CAHk-=whPqqZVSeJiQsMvsAxtAmtR9iAuB4gg_1sUK2D-uBPpLw@mail.gmail.com>
In-Reply-To: <CAHk-=whPqqZVSeJiQsMvsAxtAmtR9iAuB4gg_1sUK2D-uBPpLw@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 24 Jun 2024 09:36:13 +0200
Message-ID: <CAFULd4YAeF7=q7DYUh016kabxS8b32qRbFqDBJQrvLq6RjwEVg@mail.gmail.com>
Subject: Re: arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly
 requires more registers than available
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 8:07=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 23 Jun 2024 at 13:48, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Now, from having looked a bit at this, I can point you to the
> > differences introduced by having to have the emulation fallback.
>
> Ahh.
>
> Itr does all the same things *and* it has
>
>     "S" (_ptr)
>
> as an added register pressure, because if we take the "call
> cmpxchg8b_emu", we need the address in a fixed place.
>
> I don't see any immediately obvious workaround.

A real fix, not only a workaround, is to rewrite asm arguments to
something like (untested, but "should work"TM):

#define __arch_cmpxchg64_emu(_ptr, _old, _new, _lock_loc, _lock) \
({ \
union __u64_halves o =3D { .full =3D (_old), }, \
  n =3D { .full =3D (_new), }; \
\
asm volatile(ALTERNATIVE(_lock_loc \
"call cmpxchg8b_emu", \
_lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
    : "+a" (o.low), "+d" (o.high) \
    : [ptr] "S" (_ptr), \
      "b" (n.low), "c" (n.high) \
    : "memory"); \
\
o.full; \
})

(and in a similar way for __arch_try_cmpxchg64_emu).

We already have a memory clobber in the asm template, so to solve the
register pressure issue, just reuse the pointer in %esi to also form
the memory address of cmpxchg8b. GCC is smart enough to do this by
itself, but the current asm template indeed doesn't force "other"
compilers to do so.

Uros.

