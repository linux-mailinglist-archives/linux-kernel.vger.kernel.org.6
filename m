Return-Path: <linux-kernel+bounces-249324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3E892EA0A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC912856AF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1E71607B7;
	Thu, 11 Jul 2024 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LrqaeHYG"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3466515ECE6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706174; cv=none; b=uIoPgFpLjH61PkEceTJMB7Q7HOs2LTu4MCWoWXRqgA8TiZbUMSkNxdHRl9rDVnjlMvOSlTyIsQLf1T27Q8beo/2yTwR468fEFNfV2IXGh96GM0Zv+ai0aVga9T5I3W+WIfo6RVdqqmm2gLXGuOy87T7MqMULBILKFDkxqxDiEqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706174; c=relaxed/simple;
	bh=dSJz3wgsOhXykIynBdcFU1pclFWJ6/TuglMyzc9Bh5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6x18zuJJQKAGFKnZlMjDH4lQndKrM21ugbD+dFPcPp8fd9rmOf0gFz6ySEw/1vRLPXerWNCXdPHHama0ygm5n0g5suNcR6RNHwSrcKBExhmOrwMwUv3M7BrUFEoaLdlUK2RMgtFilwADImEwCNlt6wzJExmODUY5lj5jAe2lFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LrqaeHYG; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dfef5980a69so950587276.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 06:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720706172; x=1721310972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFTrnAbyX8vf3QQjlC5h5C0zllrIIeWFeKDzU5Qbf8s=;
        b=LrqaeHYGX/GqTdIedUDkpqeOuT4r40UFv5Uwr1UuXeuE2c26jfCaDO55hlHfVZcUzM
         eos98G2QMilfiX2qluNpkTpOU455r0xq4fIThvtTPGkIBedFk/zs83mqITaAipMxrBUq
         vpHddngEDVu4zEevLTYQkxcXLp8RLJP3pgHV1sZ32aCq0K9aBVcazLLbRU4rv1Fz4/Rw
         JEngbxEj5ubIwP1rn+eDKO0YFgealkZkhvlyAs6BFXMWuVPq88/JZlT7pK3MinJz/dtB
         bPL4QF94QAyjRalFoVN4TOmLGsrJewn/uVUgY26I/EGE1fXUCHeUDhYKMU3wWGihiZgw
         drcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720706172; x=1721310972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFTrnAbyX8vf3QQjlC5h5C0zllrIIeWFeKDzU5Qbf8s=;
        b=Ydnyobna9SyXl64woZQQpW/+O9RYGyH7UoQ78rehhFCtkVjb6Zi4RGwzViu2fX3Y2q
         DNkHtF46ZqW0OLYHlUf7L6iVPofaGRSowhTB7evDEcUZri9ATeOoBikCpUNdnxN49zuR
         24cRopP1XiNLtg7QOWSD0TP2NTjowq05MThz0VAGer6SKGJ+j2Os/4Xpx5gEQ36tAEXV
         efYxRpPOo9Vv8bJV7Dd6J5rmd95c5+nOfI9+xXC8neO7iJBCBzTQ1RQXyvjms2NzbzaE
         bXbtp3HnmEHqj07mct3NuC2JgxghaQCHjCJp47txezsPAArcXidahdN6JhgKdOsky7ki
         A6qA==
X-Forwarded-Encrypted: i=1; AJvYcCXQdxDCHy2L/poP+jz8JW52SSEHi+xj+IjVynl+rMaOfwbVnS/6+W69asm0VyIeykAWUBs2dEht9yU1efa9ZNg64EQOklySvZgzp8yI
X-Gm-Message-State: AOJu0Yza/WdjhYhcKtv7sIWJvmT8MRw7Ol4aYbCDlSZ3dg0ssUllQ3lV
	Yv1iy2Bm6VoaJjwp532L6/pPOL0eKsG7eaxDV9nXHgU80L7Ommk40YavBBAkKGoRBtD0VVg9Ldc
	sYtDa94fBOWX+yyzuZE8ffqWVXiCDccheSngd
X-Google-Smtp-Source: AGHT+IEzi2i3Lqz/5TdUvZHvPNb77C6MfS8NebUNLgPcBjgz6y6o+pM85oFGLgCJRIc8PuJgLqURHYqx/2OM1Q5xKhU=
X-Received: by 2002:a25:b2a1:0:b0:e02:8ab0:c940 with SMTP id
 3f1490d57ef6-e041b1e9795mr9335860276.47.1720706171781; Thu, 11 Jul 2024
 06:56:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710025418.394321-1-sxwjean@me.com> <Zo36BTqhzGkukyT_@casper.infradead.org>
 <20240710150154.GA1684801@thelio-3990X> <CAJuCfpFUawbMXf34YpUv_hrEvwOFX=CvPmyTS3CBOSZtC=c6Tg@mail.gmail.com>
 <4b533d6c-b2f3-49eb-a7fb-807af482def8@suse.cz>
In-Reply-To: <4b533d6c-b2f3-49eb-a7fb-807af482def8@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Jul 2024 06:56:00 -0700
Message-ID: <CAJuCfpGoSMvPWTjoKDiN+yMMfiwz7XFmv-i71nvK14uJbCPmRA@mail.gmail.com>
Subject: Re: [PATCH] mm/slub: quiet the clang warning with -Wunused-function enabled
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Nathan Chancellor <nathan@kernel.org>, Matthew Wilcox <willy@infradead.org>, sxwjean@me.com, cl@linux.co, 
	penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, 
	akpm@linux-foundation.org, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, 
	xiongwei.song@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, llvm@lists.linux.dev, 
	Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 12:43=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 7/10/24 11:40 PM, Suren Baghdasaryan wrote:
> > On Wed, Jul 10, 2024 at 8:02=E2=80=AFAM Nathan Chancellor <nathan@kerne=
l.org> wrote:
> >>
> >> On Wed, Jul 10, 2024 at 04:03:33AM +0100, Matthew Wilcox wrote:
> >> > On Wed, Jul 10, 2024 at 10:54:18AM +0800, sxwjean@me.com wrote:
> >> > > From: Xiongwei Song <xiongwei.song@linux.dev>
> >> > >
> >> > > The only user of prepare_slab_obj_exts_hook() is
> >> > > alloc_tagging_slab_alloc_hook(), which can build with
> >> > > CONFIG_MEM_ALLOC_PROFILING enabled. So, the warning was triggerred
> >> > > when disabling CONFIG_MEM_ALLOC_PROFILING. Let's add "__maybe_unus=
ed"
> >> > > for prepare_slab_obj_exts_hook().
> >> >
> >> > Perhaps instead clang can be fixed to match gcc's behaviour?
> >>
> >> Clang only differs from GCC on warning for unused static inline functi=
ons in .c
> >> files, not .h files. The kernel already handles this in
> >> include/linux/compiler_types.h but it disables this workaround for W=
=3D1 to catch
> >> unused functions like this as a result of commit 6863f5643dd7 ("kbuild=
: allow
> >> Clang to find unused static inline functions for W=3D1 build"):
> >>
> >> /*
> >>  * GCC does not warn about unused static inline functions for -Wunused=
-function.
> >>  * Suppress the warning in clang as well by using __maybe_unused, but =
enable it
> >>  * for W=3D1 build. This will allow clang to find unused functions. Re=
move the
> >>  * __inline_maybe_unused entirely after fixing most of -Wunused-functi=
on warnings.
> >>  */
> >> #ifdef KBUILD_EXTRA_WARN1
> >> #define __inline_maybe_unused
> >> #else
> >> #define __inline_maybe_unused __maybe_unused
> >> #endif
> >>
> >> So I don't really think there is much for clang to do here and I think=
 having
> >> the ability to find unused static inline functions in .c files is usef=
ul (you
> >> might disagree, perhaps a revert could still be discussed). I guess
> >> IS_ENABLED() can't be used there, so it seems like either taking this =
patch,
> >> ignoring the warning, or refactoring the code in some other way are th=
e only
> >> options I see.
> >
> > I think this is the consequence of the recent refactoring I've done in
> > https://lore.kernel.org/all/20240704135941.1145038-1-surenb@google.com/=
.
> > There should be a cleaner way to fix this. I'll post it later today or
> > tomorrow morning.
>
> Yeah looks like the non-empty prepare_slab_obj_exts_hook() could move to =
the
> #ifdef CONFIG_MEM_ALLOC_PROFILING section above
> alloc_tagging_slab_alloc_hook() and the empty one just removed.

Exactly my plan. I'll post a patch once I reach the office.

>
> > Thanks,
> > Suren.
> >
> >>
> >> > > Reported-by: kernel test robot <lkp@intel.com>
> >> > > Closes: https://lore.kernel.org/oe-kbuild-all/202407050845.zNONqau=
D-lkp@intel.com/
> >> > > Signed-off-by: Xiongwei Song <xiongwei.song@linux.dev>
> >> > > ---
> >> > >  mm/slub.c | 4 ++--
> >> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >> > >
> >> > > diff --git a/mm/slub.c b/mm/slub.c
> >> > > index ce39544acf7c..2e26f20759c0 100644
> >> > > --- a/mm/slub.c
> >> > > +++ b/mm/slub.c
> >> > > @@ -2027,7 +2027,7 @@ static inline bool need_slab_obj_ext(void)
> >> > >     return false;
> >> > >  }
> >> > >
> >> > > -static inline struct slabobj_ext *
> >> > > +static inline struct slabobj_ext * __maybe_unused
> >> > >  prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, voi=
d *p)
> >> > >  {
> >> > >     struct slab *slab;
> >> > > @@ -2068,7 +2068,7 @@ static inline bool need_slab_obj_ext(void)
> >> > >     return false;
> >> > >  }
> >> > >
> >> > > -static inline struct slabobj_ext *
> >> > > +static inline struct slabobj_ext * __maybe_unused
> >> > >  prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, voi=
d *p)
> >> > >  {
> >> > >     return NULL;
> >> > > --
> >> > > 2.34.1
> >> > >
> >> > >
>

