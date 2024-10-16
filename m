Return-Path: <linux-kernel+bounces-368845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BED59A1592
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7FB1C21228
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22B41D2F6D;
	Wed, 16 Oct 2024 22:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bFn/q6Dy"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8012E1D2780
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 22:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116384; cv=none; b=k1MjoqhA8MGz1Ebrym7RVVckG3ukvO3ShESj0cCxEbwmI1F1zrfmxJa0jZy31jgJPlU7e0XNq+6M+uyWhU9hi4Tpe6BLQVPRxuJ2Mkf2Ll2zIb2sDpC4YWKWYFCBEPQoye/R4VA4VHhFDM+4OXqh4S1DX/mtgzqD7MrjUqQ7SNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116384; c=relaxed/simple;
	bh=9z9XLQJrLQVtIR/5T/wjdf4LyvHylSASgTUT1DwjjG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apkBptLBQjgHTo449A6X3IqFKztOzoiyzbOZoPcSTgVKprvY1AjDQyG96xZhHtMkVqQH48EkBX4aUws37b9i8QSydCcH5EScinP+C+hl8mUBlMZdaMocErdHp02AxWFr8iP+0FiLyqVmYCPoMwJoZRQNGwDBDn+PPDENq3hrPqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bFn/q6Dy; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c936e8ea13so54785a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729116381; x=1729721181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVn1K517MAjCXR8P0mvWMgPXqBdZpbwDnil5HsjO5Jg=;
        b=bFn/q6Dyr52mw+UeMGlMgUmQiuBnA7Gdos7EgCjhI3i561k6SmCkt4xa6GQYSn7h0A
         MNc8psRNZYwtNm0UkuU7l//pPhDEdOQ3sSB5gLO9LgXYyTxP8JCoHHSkEG8G40Ufwr6f
         ThjjgVFd+lzSPfzApan8cY+CtOTmwg7AljnGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729116381; x=1729721181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVn1K517MAjCXR8P0mvWMgPXqBdZpbwDnil5HsjO5Jg=;
        b=CNts06H4ZFNWWTH2Seno+lHkt202u3vrNYL+TOcxzK39Nefe0MEPVQBlCNt25Gfzl5
         cCYowIz7gQUnPBytc873HX5M0oFAFfHU6t/FR/VsQC3pmP203wi+j69MvN3flLXGR0MJ
         cwqU7MtJWtiQOKyDDs7qxUaLttI9kg6KweYxwRWTbG2aW6chRh6P8PgqkurG45srExVj
         eF6afgnKKMNuEqyuNJUKOKFeBNWfdfuxMaNedIjM2i2ZmltXJ/Znirrfb3wtsPxVpTw5
         wftYrgp56ytAbqq6Bmh4/NIGgV4iOCyhl7DEF5rFVEjpAE+8kw+dcTlbujdHuhFbfJlP
         2zMg==
X-Forwarded-Encrypted: i=1; AJvYcCXBt5ktWcdUd+M0CnRemSVPpB5fcWRAzsQJZdKnkO74JVxiogj3hHbBZsPcWRHyuz28v+WACp5x3TO5fdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhrQxjwt4XgKwVJVqsfmPq9AQGA2sAQwD+FzOFvWGTIVLZ2LsV
	5pCwRrtpWvEw2+PVxZ4su0J7PGTeIoHMczRSwbPu/aKGWjZWYkN4c4UitsNw6TrzfS7T/BfueT0
	7BG087zacldn5MojpoNlglaOv393+wRw8KWmG
X-Google-Smtp-Source: AGHT+IFux0KGOB5OrxvTmpIOCJi7nqCbOOzCsZCtqUl4EdsEpk7mHjMU3PyF91Eca1JTkFWm3Ub8BbwsnyYuHKor+CM=
X-Received: by 2002:a05:6402:35c3:b0:5c8:8381:c2a0 with SMTP id
 4fb4d7f45d1cf-5c9a5e39d63mr247360a12.2.1729116380681; Wed, 16 Oct 2024
 15:06:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014215022.68530-1-jeffxu@google.com> <20241014215022.68530-2-jeffxu@google.com>
 <202410161424.FA6DBA7D91@keescook>
In-Reply-To: <202410161424.FA6DBA7D91@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 16 Oct 2024 15:06:06 -0700
Message-ID: <CABi2SkXKWGuvttUWHH+CL-MnKDvF=o6i2nGz55r+-6WvSJex5Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] exec: seal system mappings
To: Kees Cook <kees@kernel.org>
Cc: akpm@linux-foundation.org, jannh@google.com, torvalds@linux-foundation.org, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, ojeda@kernel.org, adobriyan@gmail.com, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, 
	Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 
	hch@lst.de, peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, Liam.Howlett@oracle.com, mhocko@suse.com, 
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, enh@google.com, 
	rientjes@google.com, groeck@chromium.org, lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 2:26=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> (I don't think this needs "RFC" any more)
>
> On Mon, Oct 14, 2024 at 09:50:20PM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Seal vdso, vvar, sigpage, uprobes and vsyscall.
> >
> > Those mappings are readonly or executable only, sealing can protect
> > them from ever changing during the life time of the process. For
> > complete descriptions of memory sealing, please see mseal.rst [1].
> >
> > System mappings such as vdso, vvar, and sigpage (for arm) are
> > generated by the kernel during program initialization. These mappings
> > are designated as non-writable, and sealing them will prevent them
> > from ever becoming writeable.
> >
> > Unlike the aforementioned mappings, the uprobe mapping is not
> > established during program startup. However, its lifetime is the same
> > as the process's lifetime [2], thus sealable.
> >
> > The vdso, vvar, sigpage, and uprobe mappings all invoke the
> > _install_special_mapping() function. As no other mappings utilize this
> > function, it is logical to incorporate sealing logic within
> > _install_special_mapping(). This approach avoids the necessity of
> > modifying code across various architecture-specific implementations.
> >
> > The vsyscall mapping, which has its own initialization function, is
> > sealed in the XONLY case, it seems to be the most common and secure
> > case of using vsyscall.
> >
> > It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
> > alter the mapping of vdso, vvar, and sigpage during restore
> > operations. Consequently, this feature cannot be universally enabled
> > across all systems. To address this, a kernel configuration option has
> > been introduced to enable or disable this functionality. Note, uprobe
> > is always sealed and not controlled by this kernel configuration.
> >
> > [1] Documentation/userspace-api/mseal.rst
> > [2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkR=
kL-NrCZxYAyg@mail.gmail.com/
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  .../admin-guide/kernel-parameters.txt         | 10 ++++
> >  arch/x86/entry/vsyscall/vsyscall_64.c         |  9 +++-
> >  fs/exec.c                                     | 53 +++++++++++++++++++
> >  include/linux/fs.h                            |  1 +
> >  kernel/events/uprobes.c                       |  2 +-
> >  mm/mmap.c                                     |  1 +
> >  security/Kconfig                              | 26 +++++++++
> >  7 files changed, 99 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index e7bfe1bde49e..02e5eb23d76f 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1538,6 +1538,16 @@
> >                       Permit 'security.evm' to be updated regardless of
> >                       current integrity status.
> >
> > +     exec.seal_system_mappings =3D [KNL]
> > +                     Format: { never | always }
> > +                     Seal system mappings: vdso, vvar, sigpage, uprobe=
s,
> > +                     vsyscall.
> > +                     This overwrites KCONFIG CONFIG_SEAL_SYSTEM_MAPPIN=
GS_*
> > +                     - 'never':  never seal system mappings.
> > +                     - 'always': always seal system mappings.
> > +                     If not specified or invalid, default is the KCONF=
IG value.
> > +                     This option has no effect if CONFIG_64BIT=3Dn
> > +
>
> Any reason for "always"/"never" instead of the more traditional y/n
> enabled/disabled, etc?
>
Yes. I like to leave room for  future extension, in case someone ever
needs a prctl for pre-process opt-in, e.g.
Format:{never|prctl|always}

> Otherwise, this all makes sense to me.
>
> --
> Kees Cook

