Return-Path: <linux-kernel+bounces-368607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 429B79A1231
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A6F280FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0543C18C32C;
	Wed, 16 Oct 2024 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="luCQ9kJy"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5D412E75
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105238; cv=none; b=EaY+g49MPf3bsvsbOcOBxh2XsF6pY1hNf16YvC2d4oPqWgbHNWBeIiTkUjWNl69qk7ahI3Mu89//hxTINmaqJ/J99h+p3+EQ6VFLhRpuEMynTXVT6/K3hklN2gm9mbYx+IF92C1olI17j1YDhRGOrFH9na6wmJt2SVl2P2qoNOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105238; c=relaxed/simple;
	bh=wWWgEkhtTUeYSVeugdYqBGhch23uzJuGS/8qrJPgn2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEQW8FGO8LiyBoacyOTdQ6PH/ziu1d4tA/7rLZ4LDX0v3VR/lIdow4ZmIDEmqR7i2sNy37r2hzIacu/LZJTd3HNyffWswBufqS1q8XAnGQeAtbtoaWQuHYZL0QCrGC/lXznWXIzyjWfnX0dfGHAJc3B9qINVhYnB28udYXhUOgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=luCQ9kJy; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so2015131fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729105235; x=1729710035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+9rFH2EyIhLeVd0k2EbmyRJcB/lNaDtVTgDaUM7QHw=;
        b=luCQ9kJy/dEjrGmvMUkGZAmSWz5GiLaW5scXi60bP1TVuxYenVhBqgAKh6uDLCi2qv
         IejX4d572r3frxLD6v3smdSGOP3LtW21j3J5zxVWcz1XwAyWt6NBJuI/6ZeW5NG5dk4z
         3hks8U3bhZAfIZSJd8kBOsUo1gvbqJVsIcR3sawSo+/hMCxBzwXBdVb0W/wU2LFtbT8E
         JrK2OiFIftceiPYhmG3UGLnW6rScZo0Od7S5VfRsArTKofd7gGRot5VR76jrZRTAvBah
         /XzZ4efB8WS8R9bbT+55Y8PRDH4KjmkhwC9ZfqTEjd+ux+Gx4oq7PQdIIQobLrkWR05f
         2zMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729105235; x=1729710035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+9rFH2EyIhLeVd0k2EbmyRJcB/lNaDtVTgDaUM7QHw=;
        b=UF+GUXMmrcIwmKrvzHbAFSqzUtg70fwDq13uWV9a8o+cxaikKNxzAm8VIYm3FzIk7T
         CF1dxDFH2S1aqVZl2nk5GCHmiDuFNVc9gB6QHKgAJhJrctpdJyrjcx8EVIXwQ7zx63UF
         78Sd2sF9J72ETroNOlU5Lr6jIFpf972GExUGJ6zYxqquExLmD2YUtiGfbvU48n4MbNUr
         noZlE/Q4qYP657eqLEO+h8KzdfkJeuLAqLbxyHTPrC8n5wEOd+Y5+3uRkVxGeFzR2jQC
         BEgn1VlqOxtkM7s7jpExiEpQnTqcaQ7Yi7TkIdgEIfUzjtLdV/cT+Ve9R/MOQThSZ4mQ
         588g==
X-Forwarded-Encrypted: i=1; AJvYcCXMIcl/vU5pDpL2Nvp9PKMoQkJ8BDxdi6L3Dqv4HHJAY0ZUZnZUHr2E12n0rXSDAGKGHK4nFvWE7nsobQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxqKRFPxZ/5QTAuTtIIuKJvIk+adyCuOB4KMnCjtAPXDaB+5A2
	4v+eHoYX+bFG9d5MjyNOppD6ydEaADHIxVySilSjvVz1m9n66fv8soGOKg0eeIn33AtVkjyo/yT
	/rcdH5cOAm4jsj3el0eB68Yz/J+7h9+FQkhNf2A==
X-Google-Smtp-Source: AGHT+IGmz3SDIjwUf650O06/BOGFOUeZSuH0R/NJnsSCnd6RILHZH+mod4oXz7sd4joI8dbQKVS0+waCt4VbSo3X3Nw=
X-Received: by 2002:a05:651c:2123:b0:2fb:3d86:d932 with SMTP id
 38308e7fff4ca-2fb61b4c18fmr35985921fa.12.1729105234513; Wed, 16 Oct 2024
 12:00:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zw5D2aTkkUVOK89g@J2N7QTR9R3> <CACRpkdY79nbBoaHe6ijuyJS9dDduNw_sv1J90pz121YDgCvC3Q@mail.gmail.com>
 <Zw51fhCkmCYrTOeV@J2N7QTR9R3.cambridge.arm.com> <CAMj1kXEcLD3PWd-9osjo9AOe5Jg-NMOmJ8afB_x7VeboueLoeQ@mail.gmail.com>
 <Zw59x0LVS-kvs9Jv@J2N7QTR9R3.cambridge.arm.com> <CAMj1kXEnhHkxywh8TH1i=fmyAR8cXZ8D-rvV43X-N7GpCf2Axw@mail.gmail.com>
 <Zw6Jk74-d0mhR0jx@J2N7QTR9R3.cambridge.arm.com> <CAMj1kXG3bwMGpArYNUm-qMO7PPgb3--wy5kp-3Ks2Uv9M479xg@mail.gmail.com>
 <Zw6X9KQT0-z7r7SY@J2N7QTR9R3.cambridge.arm.com> <CAMj1kXGGmsWs2XpM7zLURjKp67Uz2ePi1pSV1=rPCMgviLVUgw@mail.gmail.com>
 <Zw9_imsl2KLf7_GY@J2N7QTR9R3>
In-Reply-To: <Zw9_imsl2KLf7_GY@J2N7QTR9R3>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 Oct 2024 21:00:22 +0200
Message-ID: <CACRpkda8tO=QLF_zznoNjdNfNZJVntY_3+247E=qK6zNqRnVSA@mail.gmail.com>
Subject: Re: Crash on armv7-a using KASAN
To: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Clement LE GOFFIC <clement.legoffic@foss.st.com>, 
	Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	Antonio Borneo <antonio.borneo@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 10:55=E2=80=AFAM Mark Rutland <mark.rutland@arm.com=
> wrote:

> I believe that's necessary for the lazy TLB switch, at least for SMP:
>
>         // CPU 0                        // CPU 1
>
>         << switches to task X's mm >>
>
>                                         << creates kthread task Y >>
>                                         << maps task Y's new stack >>
>                                         << maps task Y's new shadow >>
>
>                                         // Y switched out
>                                         context_switch(..., Y, ..., ...);
>
>         // Switch from X to Y
>         context_switch(..., X, Y, ...) {
>                 // prev =3D X
>                 // next =3D Y
>
>                 if (!next->mm) {
>                         // Y has no mm
>                         // No switch_mm() here
>                         // ... so no check_vmalloc_seq()
>                 } else {
>                         // not taken
>                 }
>
>                 ...
>
>                 // X's mm still lacks Y's stack + shadow here
>
>                 switch_to(prev, next, prev);
>         }
>
> ... so probably worth a comment that we're faulting in the new
> stack+shadow for for lazy tlb when switching to a task with no mm?

Switching to a task with no mm =3D=3D switching to a kernel daemon.

And those only use the kernel memory and relies on that always
being mapped in any previous mm context, right.

But where do we put that comment? In kernel/sched/core.c
context_switch()?

It's no different in any architecture I think, and they pretty much all
use KASAN these days.

Or in ARM32's enter_lazy_tlb() in arch/arm/include/asm/mmu_context.h?

I'm unsure. I would make it a separate patch.

> In the lazy tlb case the current/old mappings don't disappear from the
> active mm, and so we don't need to go add those to the new mm, which is w=
hat
> we need check_vmalloc_seq() for.

Yups that's how I understand it too.

Yours,
Linus Walleij

