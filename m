Return-Path: <linux-kernel+bounces-240782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0B49272A5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB4F2876CF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E141A4F18;
	Thu,  4 Jul 2024 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rxfE8q+z"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A458C16D303
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 09:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083898; cv=none; b=W9asnQyUh0J8TlJy7oLTPOVTJGWnN/OD7ec9j6UXN4vM3hySJpHwMG/p3T+d2W4WkfgDeNwSL6ryfVoBQWvHknlP74hywrl/KqPyuIgKNAOkQbcuE5XETiZ0qstkZNHQP4P0zP4brCd492wmLauDOHjPPuazdrtl4woXIYOpA+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083898; c=relaxed/simple;
	bh=cXnHg0QuLNUYyJOorGso5uFmaeWJlUBHIzaSOgKFQBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ljpjz9VAF+ecmoPXcfFADR/c/qnKvQ/e4yh/oCzD1K8AjEtpEmLLBhCO0/EDg83or8Sv0accsAOVdMNttZgERfUgL2dGmQmL/CV6o0qHNTA3WuMZs48A7gHAlz808VhAIag0Tcc0E612HIQcM2cnMM1C68hT/h8SrRibFaGh2MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rxfE8q+z; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec50a5e230so3883981fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 02:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720083895; x=1720688695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mC0iPRTa0Tp+6wnSRZw+Nypk195vi+wp+1Whl/cijnA=;
        b=rxfE8q+zYsTx+wwmlGy4h3yogprOXyEo4LINBcR92lnG7EWQ/Br7qMZDzyNTHWpTb2
         vfqoC7lm7RkpqRGkbSLbj3tP1x73SUrj94ReMZg5s4xyrLfEfuMU0M8+goi4R5VJ0f99
         vLpBIgZZZzOYEprxJGPfAkrQBVD6Lg7gJAc+NUxtTiZSo8ai/pen9M1/u4Fh8jhzBupB
         WivUn90N54oAu3ZDG21d6dGWpf0m5HsfzhQZigT+JIsfvOMHTcqBR2vV90P4NdO5EjDd
         NN4XTys5xo8JisA3vUgkgeEbKcE94MYa35CHpHqwOPjcOXjJ5vkFZCMvfOorYdpeovOW
         9xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720083895; x=1720688695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mC0iPRTa0Tp+6wnSRZw+Nypk195vi+wp+1Whl/cijnA=;
        b=HsZJgLgauoVf6gHKS00QH3AJkc5bHMHEA1kK3eQv9ponSbXB/0JoPbgUc92JMiPMUf
         UkN2jTzNS8m4unh7RxIOqI8DRIwPyHikORtsspd/Ur5L08Xg8rSoQumN+7993ioTzZb6
         CwuXPB71B42dQnJ8e7oiWe7pj1CTcKYk8yTDuxwNiNuBJbq0g/toU8kTmQADEpShSObP
         papF3cuq+tbXW4xPOm9dIiy/HJqhWLCDiNlZzxvZo+u5PXQ7tQ2I/58NDurTtzhe2I8u
         5bJOFzNI/HERMKQoKngKgWrAhIGSmxPoBRCpauuXNp+MeNkxzsHCMkoLW6h323E/ROLh
         X59g==
X-Forwarded-Encrypted: i=1; AJvYcCVKfDwHJFnfntKpUUGQh4AQ45FK85kFAoZQO1HNlsBplmuRuZ8dVUBlz9QuQBJM6LRkEkMPb2adpLR38ZxL1TAxqwpx+bzbxOFe5eUM
X-Gm-Message-State: AOJu0Yy+iqxxPdrVLSh6PRM/FfndUDs4PeYdZm7inD/LkVFF7efetR9b
	vkEHx5Gj1WBrmfQwJ5hbWBge6F00RMzl+jk/q2N1do66vUkwZBSpSgPmFuN1QfcGfQ4NACV+mR1
	SWH6pIt/YyVQXcpZA5o9z8CK57r8oRHquF+F3
X-Google-Smtp-Source: AGHT+IEoQz6XrBtbF3SqYJycMjsWJckbHK9rJBs57w8vKFwwtM2ZhWFpliDSS2ec/glXwNt0tRjJ5gTc/BGHev8Vdpw=
X-Received: by 2002:a2e:7d07:0:b0:2ec:5a85:66f9 with SMTP id
 38308e7fff4ca-2ee8ee1b10emr5688761fa.51.1720083894215; Thu, 04 Jul 2024
 02:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2dbd1491-149d-443c-9802-75786a6a3b73@gmail.com>
 <CAH5fLgj3z4TMnXz=zygLW9Fku6N6nX0jyw2b0uvg=Kat-d-o2Q@mail.gmail.com> <CAMj1kXEHpaOnFTDiLUZEUcq-SzwyXnRgbYokrAnrZc_0YOH31A@mail.gmail.com>
In-Reply-To: <CAMj1kXEHpaOnFTDiLUZEUcq-SzwyXnRgbYokrAnrZc_0YOH31A@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Jul 2024 11:04:41 +0200
Message-ID: <CAH5fLgj5KENn0_zEgDp7xnokvvPLchY-bFDs7mTN=vkf1Rr2Kg@mail.gmail.com>
Subject: Re: [PATCH v2] arm: rust: Enable Rust support for ARMv7
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Christian Schrefl <chrisi.schrefl@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Jamie Cunliffe <Jamie.Cunliffe@arm.com>, 
	Sven Van Asbroeck <thesven73@gmail.com>, Geert Stappers <stappers@stappers.nl>, Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 10:42=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Thu, 4 Jul 2024 at 10:20, Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > On Mon, Jun 17, 2024 at 6:04=E2=80=AFPM Christian Schrefl
> > <chrisi.schrefl@gmail.com> wrote:
> > > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > > index 71afdd98ddf2..9cc10e32e8be 100644
> > > --- a/arch/arm/Makefile
> > > +++ b/arch/arm/Makefile
> > > @@ -150,6 +150,7 @@ endif
> > >  KBUILD_CPPFLAGS        +=3D$(cpp-y)
> > >  KBUILD_CFLAGS  +=3D$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $=
(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -m=
soft-float -Uarm
> > >  KBUILD_AFLAGS  +=3D$(CFLAGS_ABI) $(AFLAGS_ISA) -Wa,$(arch-y) $(tune-=
y) -include asm/unified.h -msoft-float
> > > +KBUILD_RUSTFLAGS +=3D --target=3Darm-unknown-linux-gnueabi
> >
> > On arm64 we use a target called aarch64-unknown-none. Should you also
> > be using arm-unknown-none? Or maybe the arm64 target should be changed
> > to aarch64-unknown-linux-gnueabi?
> >
>
> Neither. EABI is highly specific to 32-bit ARM, no point in trying to
> align this between architectures.

Ok. Thanks for the clarification.

Alice

