Return-Path: <linux-kernel+bounces-526136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B50A3FA7E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C8B440AED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC6A1E492D;
	Fri, 21 Feb 2025 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaAza9vS"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F161F0E53
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153723; cv=none; b=R2cYbB31KcIrzUun17N5tvH+MV4xwwhcNHE0wiQS6kf8061xa9ldc4OsUwhetSbOTvOSAqD/UKfPDaFPFkD/vM+UgjpQUOW99nBdjG6QTjv5Io77Jjn27YA+krLk90wnOyYrnNGljboY3hN7ekDhbtYbpBrKznJuUgs8u0POUwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153723; c=relaxed/simple;
	bh=GMHG4C6Vcw8ZEz9wWvsyryf+HolVtzqOEGBVMcI25eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Di2mrFNeQ0OYNzYtdN1tmX+i/jWoGHvkYEk8x9oFmmQTr8BWk/BpsfG43bH+VEt+VfiBfKSajoCw2N60hnZb88zE0D1lhdUYXoAzoN7N7hOX8R9f9FvBhCTxekCcLGlyOIw8DnSRbST4y7d+fLDtsPXnXe0WNMrbJcMwrvnhsIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaAza9vS; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-307c13298eeso26346471fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740153720; x=1740758520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0iNKnGeXeaez/gx6/HmK7VLjj/3hIzwyl3vZ2XIY0c=;
        b=QaAza9vSJlYWHVaP3SQpxGyCyNdXCBvAjQEpIVrR5UGzfcJerOE1gaTC46IyKm38lE
         s0lAC9eSaunKLpLkEmC/CKaJOEtO06O7NlpvS7E5QhEQcvz4Pgv9inGC9dmti1It8LIg
         1z6c63Rrg26sM4D0hW1rn9eLZX1ZxM7QCoZ6ZooeDG/+6yAwiPHUwwap4BXkj7yoD7/l
         IBuCWBzaibTso62fDl2MOW4B6HjOEQfQL7vQj6xTvBTi9M0m3tb8U95vSo/UZG5BAWqF
         eRi+AoIwMgAEAKtmeNCV4/Vgn7MnfPEo6iEzRwKnaziyMIwfdUNvZQd0+NtUyP1NxlGl
         VWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740153720; x=1740758520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0iNKnGeXeaez/gx6/HmK7VLjj/3hIzwyl3vZ2XIY0c=;
        b=M92VeHzaZeWJ/DHo+XcmULTK5zOwJCELZu7W0FPEYoQoOf5W+GbnhVZqw3Tu4ERkOt
         kNcK95Z0+ZgbpDzK+UlQ9ueLfGRdp52KYidDxih9NZ5YNKT7FKA7DLuYe3KzhE0fG0wi
         iJyWb5k4byr0eLaviILCWs+APAerqQ7TUruzQtSYrnbPyKG2/c7brXZd0eDlaHF7lCo9
         PxrZIrcychiO602fIT9AcW+1iQCcfyQ9P0o7as5L2qz8F/dKL5r+GrIbGOG4DIHlyfIO
         BOCVDPuN66I64S6Ha7K9Ux640wG46jHIUcar29TnlrDtdJNMvaLMDgKnOusFX8EeKebz
         uF+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsQKah/2vbA/5RNERM9BlRP7nQhRBveOG7ne8u5PN9dBzGrpdeHRxutLmPJmhPgQzHexr6Lg0aAA56QBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDVwjrF3T/qWUW9ChiPUwwXDb6Yj7vOC5PpRhJGEHci9TY3Uey
	PtjwaU2OkX9mjzWKjlzvyeRdLEiE4wgzoZmy2OccqQ0dvfgaxfZ1uYgv8qxr5Z1SKnmMYypg1nz
	lPPGUPg65Jk3zrzortjDewTZdR8U=
X-Gm-Gg: ASbGncseh5LxG3h4haTtX3ZclvvB+YNHX81Wc0MCV0oJoj3PZm03h9l0wV2szXJqONT
	LSglV5NnLiQfqW2Ydkh9c9Q108gyvIPmlHjhCOXrhJElJDfOREvw/6fMbsvVhnqD/bPH1dMHsLL
	i4Gge1yQI=
X-Google-Smtp-Source: AGHT+IGhbbNdldFlT1JsFIL/bZUc5QMgBcKD1C4p6UnyOxhq4bfqjR23qEPLevccNlxCUOZzD4GpIZBpocqW04uLGe4=
X-Received: by 2002:a2e:9843:0:b0:308:e587:ca8e with SMTP id
 38308e7fff4ca-30a598ebcdcmr13483551fa.11.1740153717866; Fri, 21 Feb 2025
 08:01:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220200439.4458-1-ubizjak@gmail.com> <CAMzpN2i8uR7L9DmL1AX1R9p__x5KwAtdey_4iJ5ZP_frTqu9vQ@mail.gmail.com>
 <CAFULd4b8kgXfr1QcWud-n7PyuKKVUGTNd00GSZU=6va6Gr65EA@mail.gmail.com>
 <CAMzpN2hHb_T3gZfueeVRbOxUFt8+syWsm8iWQxF4PaUOQA-k=w@mail.gmail.com>
 <CAFULd4ZGW-FYtEe-BJ53QVjHMLr1jyj_6vJhNEwqqwW6Z77+Tg@mail.gmail.com>
 <CAMj1kXGKDtWxcuWbPP+o=6_pwhOHKJF_NnOL8F95y0tXt-dQQg@mail.gmail.com>
 <CAFULd4YuL9DCOs23Ev+iXooirLfKT3O_9poSUM7JeW_dO34o9A@mail.gmail.com>
 <CAMj1kXG_zKei335-CqXwNi=+AkqtQt6xmoVw+qD1XzW7q-aPtA@mail.gmail.com> <CAMzpN2hPWSQudpmccDtCAQAy_rHFwbBwo+95GMaqw6P-E4RPZg@mail.gmail.com>
In-Reply-To: <CAMzpN2hPWSQudpmccDtCAQAy_rHFwbBwo+95GMaqw6P-E4RPZg@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 21 Feb 2025 17:01:46 +0100
X-Gm-Features: AWEUYZmNKAD8A2j9Ma4R7h6NowGZkHNhFHYvj-4JRRabihpdXa2tJy3el3sIHJo
Message-ID: <CAFULd4aO6-1_FKXFyXW+QT5UL-3mU3Tr=yjjwt9-b1yM=TrN+w@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/stackprotector: Move stack canary to struct pcpu_hot
To: Brian Gerst <brgerst@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 4:54=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> On Fri, Feb 21, 2025 at 9:38=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > On Fri, 21 Feb 2025 at 15:33, Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > On Fri, Feb 21, 2025 at 3:13=E2=80=AFPM Ard Biesheuvel <ardb@kernel.o=
rg> wrote:
> > >
> > > > > > I got a warning from the relocs tool, but not a hard error.  Wh=
at
> > > > > > compiler/linker are you using?
> > > > > >
> > > > > > Does the attached patch build in your configuration?
> > > > >
> > > > > Ah, the attached patch is similar to my previous approach, where =
the
> > > > > build system *warned* on an offset (the patch was abandoned due t=
o
> > > > > Ard's request to put stack_canary to the *beginning* of struct
> > > > > pcpu_hot, and this allowed for a simplified patch).
> > > > >
> > > > > The attached patch builds for me without warning/error for both, =
SMP
> > > > > and !SMP build.
> > > > >
> > > >
> > > > Did you try building modules too?
> > >
> > > make -j 24 olddefconfig prepare modules_prepare bzImage modules
> > >
> > > for defconfig, SMP and !SMP.
> > >
> >
> > OK.
> >
> > I think I prefer Brian's approach - the only nit is that the placement
> > of stack_canary creates a padding hole in struct pcpu_hot. However,
> > that does not actually matter until we run out of space so I think it
> > is fine as is.
>
> Going off on a tangent, as struct pcpu_hot grows I think it can be
> done better as a subsection of percpu data (".data..percpu..hot").
> That way each variable has its own symbol again and it reduces header
> dependencies.

Please note an optimization in common.h:

/* const-qualified alias to pcpu_hot, aliased by linker. */
DECLARE_PER_CPU_ALIGNED(const struct pcpu_hot __percpu_seg_override,
            const_pcpu_hot);

struct pcpu_hot has its const alias, so we are able to use:

    if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
        return this_cpu_read_const(const_pcpu_hot.current_task);

where the compiler is able to eliminate a sequence of reads to the
const_pcpu_hot.current_task.

LTO does not like the approach, though, but clang does not use x86 seg
support, and gcc does not perform LTO.

Uros.

