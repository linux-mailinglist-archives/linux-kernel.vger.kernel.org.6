Return-Path: <linux-kernel+bounces-537344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FAFA48ABC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02FA216BD48
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A549271291;
	Thu, 27 Feb 2025 21:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fHu0FEuA"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F056271285
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 21:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740692687; cv=none; b=QOikhllynBhB6FecTjnToWA+zqfmd03JS2GcRlMlf+LzTcx5wHteN/Y7tYGj5POIgf9AK4faO4VK4kjzDc8Eq10lZafcmZxVtL9v51Sj0Ll2CdG8dr05omdkJIMZfNbjDfxIYAQ94slX85pew7RdCHWonJQTEAzb3fWRrEhx+VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740692687; c=relaxed/simple;
	bh=n6njHu7ybdBsZiHui7SoRCsudV2bX4MYy8gZpvTckbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FvGv3SnuWWrmgz9UOZJIWnwhSREoSrSomYehPrSyzjJ2SV6Ol9J3F/OsCGahS4oq3g87CTXUPT+J9w+Kg+WofW7+z8spXhVZfYtUL9hMIV+p2MoEs6P1Y0LOGKQYaP3hv/TakcOkcp9j11QAbLNbTqdlnAEzhEopl+8DEQPpULI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fHu0FEuA; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7272c81328bso95076a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740692685; x=1741297485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41P9T7rAOn5C903KcslM4I+TaCE2v2OwMWOr2r9y6yc=;
        b=fHu0FEuAOX/0jwIpdBgZIni3fAXQi4QC7sEnk6NuKZwTpmQFNsGxDPL9eIEwH4xCUz
         QX+FmmryD4+D0nY/AIbV0dMeZQ/ZDBH28zdOhkAafTFz+HEWyu/jkXhvdfngbzOmF+U8
         XTOalWs77FjGmZq7EqN8VCRxh2A+lKACmeXIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740692685; x=1741297485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41P9T7rAOn5C903KcslM4I+TaCE2v2OwMWOr2r9y6yc=;
        b=rec3J2Ah9xd8KYZWmI7G/iItUy5aZhmThRWjFTa37yltCzHMMME9+qoWccWMWIF2QW
         NxTaCDQ9Zo8JHvKphWw/dmL8wmN9L7cdgp2vnNM4RK3njxkUowj1nioMR3jwBWVw1ZL/
         X4cgIwtbPmAUSU4Vp9cQWtbK6y6EudacYUjKMtsODuCL1K2JhKUUXFYtmTowrAuMZL5k
         1FYtpV46Mai6s7EaVLpcQF3sU2U3IMVfqCIHHYWLe31C/3ycXGIcbL+nnhj+a/BEsh41
         +uYgU7Ir299Njoq6syTsUMEKq1yZQsx8I9n8/KdL3hhH/FL+SYZXd7BJKq/IWm49AqpZ
         nyKw==
X-Forwarded-Encrypted: i=1; AJvYcCVPZ8V+qeva2udI//XGkMI+nHdr1OFNjeogi2Axc/Q0Mk+mv+XHvwama9lvlxlf/zeyZFjvbRJECEYJ2xE=@vger.kernel.org
X-Gm-Message-State: AOJu0YweKjaHLN26e+HI/TJE2eRzRNgIx0K4ydYOM7wnlfI25K5q5/x1
	l87Mv1unZWhsRhIyuP8813QPNqxKXyORThnWW3GLtNWj9OXQJxGeBNIh3PoZHorNTFKsdIPKpo7
	X4g/AkCyvm6/rlAz2V+p7dXm8KozgghjfJEBc/R7bhmXLaFo=
X-Gm-Gg: ASbGnctpB+WdKkUxlOucLS4jargMLYBkiANjOOpXEyxlQQcyA4Ibfdm8gfrUJSfkUSO
	5xJz5wIHGGeVrREvSqufp4mikDAwLluDe2uIUwZs1zvxlbO+TnRgTzx8eiLAL8C7iVpcrNwRB6y
	IN3nh7eKCWJTzS8j+kfT0xuKj6fzIbtKjXrhUS
X-Google-Smtp-Source: AGHT+IFughb8ucHe5DsofFLYJInuUUcNg3DNnlqCne5qRA9aKO1ulCgbX8TUXLDOT+muClmgGU9fnGmggYJ9ApqcZz8=
X-Received: by 2002:a05:6870:d8d0:b0:2b7:c7b4:7df7 with SMTP id
 586e51a60fabf-2c178712c5cmr176343fac.11.1740692685142; Thu, 27 Feb 2025
 13:44:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <20250224225246.3712295-4-jeffxu@google.com>
 <20250225085728-24167715-8562-45a8-86cd-0ea503e4bc73@linutronix.de>
 <CABi2SkUwETzrBSYm0QV9+eoeo0kgA+r2JM4QaFpQqeTiidFEDA@mail.gmail.com> <20250226082701-9057b348-b074-488f-9aca-49ffbc78237f@linutronix.de>
In-Reply-To: <20250226082701-9057b348-b074-488f-9aca-49ffbc78237f@linutronix.de>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 27 Feb 2025 13:44:33 -0800
X-Gm-Features: AQ5f1Jr2cfmQo_Z39J7t8YiLBoePGb9dDRH-76W5jrebQ_aLePoCE7SzRjIwf7A
Message-ID: <CABi2SkXwaJ=s3XqHKu1aFVfcacgxpQ5Ji1_BqaN+ch2i_RnA9Q@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] mseal, system mappings: enable x86-64
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	avagin@gmail.com, benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas

On Tue, Feb 25, 2025 at 11:35=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> On Tue, Feb 25, 2025 at 04:48:47PM -0800, Jeff Xu wrote:
> > On Tue, Feb 25, 2025 at 12:08=E2=80=AFAM Thomas Wei=C3=9Fschuh
> > <thomas.weissschuh@linutronix.de> wrote:
> > > On Mon, Feb 24, 2025 at 10:52:42PM +0000, jeffxu@chromium.org wrote:
> > > > From: Jeff Xu <jeffxu@chromium.org>
> > > >
> > > > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on x86-64,
> > > > covering the vdso, vvar, vvar_vclock.
> > > >
> > > > Production release testing passes on Android and Chrome OS.
> > > >
> > > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > > ---
> > > >  arch/x86/Kconfig          |  1 +
> > > >  arch/x86/entry/vdso/vma.c | 16 ++++++++++------
> > > >  2 files changed, 11 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > > index 87198d957e2f..8fa17032ca46 100644
> > > > --- a/arch/x86/Kconfig
> > > > +++ b/arch/x86/Kconfig
> > > > @@ -26,6 +26,7 @@ config X86_64
> > > >       depends on 64BIT
> > > >       # Options that are inherently 64-bit kernel only:
> > > >       select ARCH_HAS_GIGANTIC_PAGE
> > > > +     select ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
> > > >       select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> > > >       select ARCH_SUPPORTS_PER_VMA_LOCK
> > > >       select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
> > > > diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> > > > index 39e6efc1a9ca..1b1c009f20a8 100644
> > > > --- a/arch/x86/entry/vdso/vma.c
> > > > +++ b/arch/x86/entry/vdso/vma.c
> > > > @@ -247,6 +247,7 @@ static int map_vdso(const struct vdso_image *im=
age, unsigned long addr)
> > > >       struct mm_struct *mm =3D current->mm;
> > > >       struct vm_area_struct *vma;
> > > >       unsigned long text_start;
> > > > +     unsigned long vm_flags;
> > > >       int ret =3D 0;
> > > >
> > > >       if (mmap_write_lock_killable(mm))
> > > > @@ -264,11 +265,12 @@ static int map_vdso(const struct vdso_image *=
image, unsigned long addr)
> > > >       /*
> > > >        * MAYWRITE to allow gdb to COW and set breakpoints
> > > >        */
> > > > +     vm_flags =3D VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXE=
C;
> > > > +     vm_flags |=3D VM_SEALED_SYSMAP;
> > > >       vma =3D _install_special_mapping(mm,
> > > >                                      text_start,
> > > >                                      image->size,
> > > > -                                    VM_READ|VM_EXEC|
> > > > -                                    VM_MAYREAD|VM_MAYWRITE|VM_MAYE=
XEC,
> > > > +                                    vm_flags,
> > > >                                      &vdso_mapping);
> > > >
> > > >       if (IS_ERR(vma)) {
> > > > @@ -276,11 +278,12 @@ static int map_vdso(const struct vdso_image *=
image, unsigned long addr)
> > > >               goto up_fail;
> > > >       }
> > > >
> > > > +     vm_flags =3D VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|VM_PFNMAP;
> > > > +     vm_flags |=3D VM_SEALED_SYSMAP;
> > > >       vma =3D _install_special_mapping(mm,
> > > >                                      addr,
> > > >                                      (__VVAR_PAGES - VDSO_NR_VCLOCK=
_PAGES) * PAGE_SIZE,
> > > > -                                    VM_READ|VM_MAYREAD|VM_IO|VM_DO=
NTDUMP|
> > > > -                                    VM_PFNMAP,
> > > > +                                    vm_flags,
> > > >                                      &vvar_mapping);
> > >
> > > This hunk (and the vvar mapping in the arm64 patch) will conflict wit=
h my
> > > "Generic vDSO datapage" series.
> > > That series is already part of the tip tree (branch timers/vdso) and =
scheduled
> > > for the next merge window.
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=3D=
timers/vdso
> > >
> > > The conflict resolution is fairly easy:
> > > Move the new flag logic into lib/vdso/datastore.c
> > >
> > Thank you for bringing this to my attention.
> >
> > In your change,  it seems lib/vdso/datastore.c implements a
> > vdso_install_vvar_mapping(), then all the architectures call this
> > function.
>
> Correct.
>
> At least all the architectures using the generic vDSO infrastructure,
> which are the ones you care about.
> Sparc for example has its own implementation.
>
> > So merging conflict won't be as straightforward.
>
> Wouldn't it be enough to unconditionally use VM_SEALED_SYSMAP in
> vdso_install_vvar_mapping()?
> The symbol is a noop on architectures or configurations where the new
> functionality is not available or enabled.
>
Yes. That will work.

> > Maybe a better
> > approach is that I continue resolving all the comments, based on the
> > latest main. Then wait for your change to be merged and submit another
> > version.
>
> That would work, too. As you prefer.
Great !

Thanks
-Jeff

