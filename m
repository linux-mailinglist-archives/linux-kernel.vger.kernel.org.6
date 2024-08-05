Return-Path: <linux-kernel+bounces-275251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19273948262
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF141C21C9F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A24216BE10;
	Mon,  5 Aug 2024 19:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g5DqTO4P"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2D916B391
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 19:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722886722; cv=none; b=uFNPpt/rDKkHHVo/ugZRiyExz/8wzA9nwHnuI9mOigma2H0v4hKiIVoO70HQgVkoFdzwT/I3I08FU1mfYY3W4xhd00SCxZ9a6T1YdD52n9+nZ2mPDVSDX5G4SOhMxeEoNe4vL9goP/ffDQcItkQUAC56cM/yhXXAq0g3pi7GE+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722886722; c=relaxed/simple;
	bh=c5jQCeWyHX0pjMU/idg7/nAZxHs69Nv+EOqEv9HtygQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHpk+igfVhliWSWPDnYdbAOavTA7omvky+Ak2aoLE1dra1jy+mpoPokjf2NNROvQ3McET8DoiwLYD0RP2jQWDm/aYuGd+1oDqvFiBue41oKx9uWJtEafp7eXTMSQGDSJ00VJpvmucp1ffvjzCrzi0rRpeMFNVPc/LfCzHSIfG6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g5DqTO4P; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so452a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 12:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722886719; x=1723491519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGFLA8u5kVy9wXjCmZIlQqKbRlxt+hHLnh+5Z8PTNyQ=;
        b=g5DqTO4PBumrNxOdkUZGxHGe954CjPxLnPNsphDYaAbnCmu0MJvqm83Mq0tAmhK2lZ
         tSr5TygH11oDOzKmlDAfXyXDtJZnt0SN7GXnzFWrOdIywtnPRK++kOsjhm0v2ve0vmek
         IolofjeJefit6d1wyljgGk3PfmvNuSYvra92E//fcviWe9j6iVgEfqdVDWCDbTUUCrN5
         28VWIp3DYx3EHkKdu8nbhg1/DV0vufo3qJe1T/sNfo/FiqAdsangpDUj5/LW0s/uKrkM
         dtNQN9xk3jnreiai9cR2FbK0XNAM4feKmbrebX4PMoR2A6c6iC8RTQGofSf+UQcKNRu3
         WKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722886719; x=1723491519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGFLA8u5kVy9wXjCmZIlQqKbRlxt+hHLnh+5Z8PTNyQ=;
        b=Jt9UdgQ/hHc4xG/CFrB5pa97rn2NXyI95eowmuVvUmuB+xyAo0EJ4ocb8PmBBvvIji
         C3jHWYIsB0vh0fNsVvgAu0IiW0PzQIIe95rLvi6zeQOxMB++VSvAchk0ZH96Iq90DHxX
         BTdCm4ZR5RA+Z5fGsaSTgXFkjqZKf8cShIeQJLgRUSg1HhJrv5KAv10SpMfrBoyn8yom
         id7mY38nEV1l5g/VgdNkkGI0cWBM2lxzXKGom+EfrBlVoDOi5rkxIVLrl9Ry3v60JDBd
         GGFfJrh/Nlf42GQ26TtNiMMwb80juCYe/l0/WQytBbg1y12s1HN7DW8ahH7uhfeyxeEB
         jrjg==
X-Forwarded-Encrypted: i=1; AJvYcCWJlBx4GhU2S0bIangf883NyLWLTBmdgioENHE0gyWDwMaR0zv+imoGAyaEJUbyMkv3Hv+LrTQzDOt6XU6+BhDQ+lduCsCH1aXpIXLf
X-Gm-Message-State: AOJu0YzEVN0EyovVZMXymsMaEfUlT7HIWdK0yjTzYP9PHvNQ1Wua8+v/
	9pbr2lYBiuueTlIIuC5O0HraSlYO9Rqa5gLmGo6DCwxQrhbnP5IH/OCI5OlAebiZJXGNBV35jR4
	Q6BEfM2uATqleQMMifu8kfaDZKHpcb1Yvyzj+
X-Google-Smtp-Source: AGHT+IGmnVv7No8+G2Cs5AvUBwMA5qb7rdRi/0cz257O9aMxeMc8HSPoAnLiEuwYAJwbFjE867spVvmZ03q036DH4uc=
X-Received: by 2002:a05:6402:40c5:b0:57d:436b:68d6 with SMTP id
 4fb4d7f45d1cf-5bb98397eecmr19552a12.7.1722886718833; Mon, 05 Aug 2024
 12:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408041602.caa0372-oliver.sang@intel.com> <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
 <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
 <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com> <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com>
In-Reply-To: <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Mon, 5 Aug 2024 12:37:59 -0700
Message-ID: <CALmYWFuCvphvLQOuQHBbFq0G8Ekyze=q45Tt4dATOt-GhO2RGg@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Pedro Falcato <pedro.falcato@gmail.com>, 
	kernel test robot <oliver.sang@intel.com>, Jeff Xu <jeffxu@chromium.org>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Dave Hansen <dave.hansen@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <groeck@chromium.org>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Amer Al Shanawany <amer.shanawany@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	linux-api@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 12:01=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 5 Aug 2024 at 11:11, Jeff Xu <jeffxu@google.com> wrote:
> >
> > One thing that you can't walk around is that can_modify_mm must be
> > called prior to arch_unmap, that means in-place check for the munmap
> > is not possible.
>
> Actually, we should move 'arch_unmap()'.
>
I think you meant "remove"

> There is only one user of it, and it's pretty pointless.
>
> (Ok, there are two users - x86 also has an 'arch_unmap()', but it's empty=
).
>
> The reason I say that the current user of arch_unmap() is pointless is
> because this is what the powerpc user does:
>
>   static inline void arch_unmap(struct mm_struct *mm,
>                                 unsigned long start, unsigned long end)
>   {
>         unsigned long vdso_base =3D (unsigned long)mm->context.vdso;
>
>         if (start <=3D vdso_base && vdso_base < end)
>                 mm->context.vdso =3D NULL;
>   }
>
> and that would make sense if we didn't have an actual 'vma' that
> matched the vdso. But we do.
>
> I think this code may predate the whole "create a vma for the vdso"
> code. Or maybe it was just always confused.
>
Agree it is best to remove.

> Anyway, what the code *should* do is that we should just have a
> ->close() function for special mappings, and call that in
> special_mapping_close().
>
I'm curious, why does ppc need to unmap vdso ? ( other archs don't
have unmap logic.)

vdso has .remap, iiuc, that is for CHECKPOINT_RESTORE feature, i.e.
during restore, vdso might get relocated after taking from dump. [1]
IIUC, vdso mapping doesn't change during the lifetime of the process.
Or does it in some user cases ?

[1] https://lore.kernel.org/linux-mm/20161101172214.2938-1-dsafonov@virtuoz=
zo.com/


> This is an ENTIRELY UNTESTED patch that gets rid of this horrendous wart.
>
> Michael / Nick / Christophe? Note that I didn't even compile-test this
> on x86-64, much less on powerpc.
>
> So please consider this a "maybe something like this" patch, but that
> 'arch_unmap()' really is pretty nasty.
>
> Oh, and there was a bug in the error path of the powerpc vdso setup
> code anyway. The patch fixes that too, although considering the
> entirely untested nature of it, the "fixes" is laughably optimistic.
>
>                  Linus

