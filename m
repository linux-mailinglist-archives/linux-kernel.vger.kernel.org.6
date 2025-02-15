Return-Path: <linux-kernel+bounces-516338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A68A36FDF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE32B3AF63D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2AE1D89FA;
	Sat, 15 Feb 2025 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwzbJCdW"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E481FDE39
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739641117; cv=none; b=oO+mG3Hyh1dJwybjCeVl144d40b8ZVxgfyx5/Agg4quTU+Vi2fU0Oi0bABg03QjUhQDKgGZxmnPoluXDGiVrRPm6jhKtV/CiZNddF2FOplL1Wsp6sYAhfZE5qLJbKBk5wnphWUS6mTzC2lxXV7onNvZ6uldEHRumEfza0JgWZ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739641117; c=relaxed/simple;
	bh=R9JcFarqOJwyNgPlHFO1pjrmDbE8auqsaOP+7eBAoCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAQpXGIOq3PuHw9QzJePEOB1+qWaPg8d76JdsqEpaqoSdJsw6AVhUmMI4KuCvyqU11fcAoJNBjBZsbxPE+Wqkybu0rT86yjfRC+rWpoiIVnZy1pusMBbjky5viK8ZHQSqAsIhUAZ+2VuWpFNOZ58p4oL7hVGE8xTDE6/IQC1o8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwzbJCdW; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5452c2805bcso1729080e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 09:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739641113; x=1740245913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e23thYrVFz7izQrLfyCHZJvjAgG77Y/0y3FpMKO2LUk=;
        b=XwzbJCdWverof9zsrUuwNBZIN7z7QgPwSguoql3mAo+jgiXxIXh0zs7XprVkFreGoV
         E6PsvRWNhnrttzkW08QBN1XuLsRMB8ohRoX1XG2IGW6fXtDpQLxxPozK4vF7UGQzLY2Z
         +G50TmMvXrbG1QCPDJMFq0S6c4PrcAnjFhxtSfgjDF34Qg3yCC73Ydk9YGGwkWNDuG7m
         mymtlUGDASX5unRauECYQM5MhBYqmhvmwgqYoy+f1d7GYLHcOGhKPMg/LlJGHXweVpVj
         rRkEfAFn+O+sx2rUS8VC0fz10uvdQtgTFy+qc7XqsO5A2ZZO7MQOuAJjW1r85AW746Uo
         pJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739641113; x=1740245913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e23thYrVFz7izQrLfyCHZJvjAgG77Y/0y3FpMKO2LUk=;
        b=Tf3k/RV1Uv8TEGkvSBmOWwBScxkZD0FLpA68pjb/65gMhclfeSgYpZMGoe2WC0s1v8
         0T1vjGwIkOCxMT9ZIDqsqbRFCeICPwdZLsTAvbq16GM6Hed10m3C0a34ed+xixg+b/sp
         yFF24ENDIzmmAG4ZKeOoAFUJE8DKlIfRtB95lBHD2GR6t3qWOORG7oUsPFEak6Y1qUQb
         YdAthW2fOsuFDypGEwRBZ17R8V8rmrBMr8ZYNj9HH1e32tZkUm+0bPwOkrvIkFrb7p2w
         YHi2o8nLg4VsgQbpnWhvqyneEFe4sM8zmKJ12sIJJfrjGfoKPf9rbOSJPSGeYi4aeyt7
         Fr6Q==
X-Gm-Message-State: AOJu0YwLT8eXn0QSZp9pQ+1J1yNL3k+wWxAPVoqXsUz3yIxc5YX/3/TT
	JMeh0vw5WGYsIuhbvdKBeQ9zuxr0Gtf48f7psfHB5ZzudBbQUYhMjbYpqFlFamH1AJDx3AtNxG0
	HwB9QoVpZkITqDv7dlBJENLsO0g==
X-Gm-Gg: ASbGnctQYj/H9sQd3mXXTuVkG1eE73s3gGMNBoFsdvhuqZh48oHAmWUenYDNBTm7EWd
	MjDxYXdq2/uDbg9PgaOyReIsi6M/WhmVIE68/zc1sx7RY2vDCXvD3RCbN9o0G+LIpIVqtjcsJ/I
	H9yPb2U5airb0=
X-Google-Smtp-Source: AGHT+IHmIy9D5scxb+6srcgy48VXBB2I0UiPP3/5kpAcVAaBm7Ln1VSMp2aIW5CVV76yHRa0lSCt5vTJfQTf/MVzO8I=
X-Received: by 2002:ac2:4e0a:0:b0:544:138d:4b7b with SMTP id
 2adb3069b0e04-5452feab078mr1296983e87.52.1739641113104; Sat, 15 Feb 2025
 09:38:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105155801.1779119-1-brgerst@gmail.com> <20241105155801.1779119-9-brgerst@gmail.com>
 <20250215142714.GFZ7CkQtdXoUM-xKMo@fat_crate.local>
In-Reply-To: <20250215142714.GFZ7CkQtdXoUM-xKMo@fat_crate.local>
From: Brian Gerst <brgerst@gmail.com>
Date: Sat, 15 Feb 2025 12:38:21 -0500
X-Gm-Features: AWEUYZneyE7EgLynpNzKvZ3wZZ6mC7waiQqIjVbOVPkk6O__hZJ-6zRR2VUA3-s
Message-ID: <CAMzpN2h05N+KZzpFY6YXZjMViK+_U9gks36mOfRJpSOMY-Xm5A@mail.gmail.com>
Subject: Re: [PATCH v5 08/16] x86/stackprotector/64: Convert to normal percpu variable
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 9:27=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Tue, Nov 05, 2024 at 10:57:53AM -0500, Brian Gerst wrote:
> > Older versions of GCC fixed the location of the stack protector canary
> > at %gs:40.  This constraint forced the percpu section to be linked at
> > absolute address 0 so that the canary could be the first data object in
> > the percpu section.  Supporting the zero-based percpu section requires
> > additional code to handle relocations for RIP-relative references to
> > percpu data, extra complexity to kallsyms, and workarounds for linker
> > bugs due to the use of absolute symbols.
> >
> > GCC 8.1 supports redefining where the canary is located, allowng it to
> > become a normal percpu variable instead of at a fixed location.  This
> > removes the contraint that the percpu section must be zero-based.
>
> Unknown word [contraint] in commit message.
> Suggestions: ['constraint',...
>
> Use a spellchecker for your commit messages please.
>
> > diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> > index 5b773b34768d..88a1705366f9 100644
> > --- a/arch/x86/Makefile
> > +++ b/arch/x86/Makefile
> > @@ -140,14 +140,7 @@ ifeq ($(CONFIG_X86_32),y)
> >          # temporary until string.h is fixed
> >          KBUILD_CFLAGS +=3D -ffreestanding
> >
> > -    ifeq ($(CONFIG_STACKPROTECTOR),y)
> > -        ifeq ($(CONFIG_SMP),y)
> > -            KBUILD_CFLAGS +=3D -mstack-protector-guard-reg=3Dfs \
> > -                             -mstack-protector-guard-symbol=3D__ref_st=
ack_chk_guard
> > -        else
> > -            KBUILD_CFLAGS +=3D -mstack-protector-guard=3Dglobal
> > -        endif
> > -    endif
> > +        percpu_seg :=3D fs
>
> Any particular reason this var is not in all caps like the rest of the va=
rs in
> this file?
>
>         PERCPU_SEG :=3D fs

The convention appears to me to be that all caps are used for global
variables used by the core build scripts and/or exported to
subdirectory makefiles, whereas lower case is for local variables.

PS.  Please comment on the most recent patch series, v6.



Brian Gerst

