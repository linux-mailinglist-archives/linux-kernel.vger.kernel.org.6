Return-Path: <linux-kernel+bounces-248276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD39F92DB22
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF0228212C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E775135A65;
	Wed, 10 Jul 2024 21:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R20Dmnon"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431DC132113
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 21:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720647660; cv=none; b=OF/xslSmeAfkpYO0q7c0XQUiOLxKhChZZ3t5t0k49baeEsUEkD2OCBXsc80pOZAEyxsHZd6N0IUBYWKLz6XEdSzawiZ+jd8YjAFyqRBwlJcFmHIDvvi5OK6b9k9JiD0wmvSa+gWdjbOYd2WCbxSHgwgYhhgH28zYbrLC//nSBBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720647660; c=relaxed/simple;
	bh=x0c0iBYcvD/rDFCSBzWak3CbeopcLqST+3WdVzu/Ge4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ux3Y0Y/qzAoMizk1k+TJn3WNpXGSp63AM5JhDIItw0k60OSMw6UrUn3eTVaF2ApnIkFqsWK3q2JoiruWvi9MCukRWAXK8KZwnq7i+A+QLuqLYM1XT9CKVvIkCLVC0Oedn8wo9iPMIM1/JeqJDGMnBKyTfR0ZmCtPYyEis7gfZQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R20Dmnon; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-64f4fb6ce65so2109487b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720647657; x=1721252457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XBOBObJaAEK1M46KNmNvsVNBPngWj8fU0d2YVNpK0Q=;
        b=R20DmnonUXP+jXM+XstitCObCeAYS606ppgXJ16/LpN/fBO1Tij5MBl+aW20BgrV9o
         k043Qvs37PK2Px5iImuJvEmiS+0lz09U2cv+2EXvboEOh+8U3jUr6huxq3ycxg+oJmdt
         ST80mcktOxldDALUI73l4Sz6Tbo1x5YW2l7/f4reL2Nb0wG67sYmssJtCUyQHSlTg8GS
         O8v1oPx5vbp5+GtnvSY+tdthP6GAs/EkzlckOLEvaoQwlZ1USNak0Aa6cq0PvARgsLEe
         EPX7JkfqPTbj6yP8mDZ0QdUX8a4MH7uF9Doon0oNhPVB0vLxZnoXO3xmBMr/ZTWcJ+R7
         fxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720647657; x=1721252457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XBOBObJaAEK1M46KNmNvsVNBPngWj8fU0d2YVNpK0Q=;
        b=NBz0dV1GYzTzl9JHtbSKzHdhcI1Ejmio0DFNQ3L3tRJUMQFaPKixLgouKsa9deMmGg
         KYoNBPOG8no8DjPfN7MFVnAr9igunBRVUgDUKCH4HM33HfGVIhz09DLVweTPclud8BJT
         ThU/XGJNGNQfRKtVn9qswtEycrd/jw+AUnzfGS7CDm0CJ/kXyN4sOhT58YBJz6TXMdHZ
         +c3gIomjQ73dlJGx3Jz54P1FHRgsI0dJT0U+bwLq4IZt5ReCilCuPhsAhbm60kVLVWxO
         ln5UsGzSBmrSGMptUrKh+6GOLRmxP9TJMi0Uoc3vlAMJuGb4Vr2ts/XGtTyewRCvCDTX
         uQHw==
X-Forwarded-Encrypted: i=1; AJvYcCV84XCdzwWrsq++0VzGdEk7FQfls7D/FM/hZqMyHb0szw2VQGLK1Q6tk87MYzG6ANqr/K4gyEmnhks/UFC8mG4/UVFuTRdSJayoZvw7
X-Gm-Message-State: AOJu0YykaXRLYhsY4py+fpTWOAtMNqfYcj+Usothgydds2443YQa5U7H
	mcIQ0PbsQVKB/S8euqxIi6Yf0SMaDDC4hqVYPDa3YS52bjxHU8RaRLFp1UwioZebp5gSHPA2HbS
	hQqjltRbjwPvQCKaAM6D0BsYo44f1yEAuXNXC
X-Google-Smtp-Source: AGHT+IE9LwO7snLlHt6fREw7Kb3flbhkA09QJ9tqIVaUo48iiu8//3dVR54mhZCPewECzH/0QpeEaLObv4Du7/1Ag88=
X-Received: by 2002:a05:690c:c0b:b0:64a:4728:ef4 with SMTP id
 00721157ae682-658f09c2d41mr82527977b3.47.1720647656845; Wed, 10 Jul 2024
 14:40:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710025418.394321-1-sxwjean@me.com> <Zo36BTqhzGkukyT_@casper.infradead.org>
 <20240710150154.GA1684801@thelio-3990X>
In-Reply-To: <20240710150154.GA1684801@thelio-3990X>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 10 Jul 2024 14:40:45 -0700
Message-ID: <CAJuCfpFUawbMXf34YpUv_hrEvwOFX=CvPmyTS3CBOSZtC=c6Tg@mail.gmail.com>
Subject: Re: [PATCH] mm/slub: quiet the clang warning with -Wunused-function enabled
To: Nathan Chancellor <nathan@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, sxwjean@me.com, vbabka@suse.cz, cl@linux.co, 
	penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, 
	akpm@linux-foundation.org, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, 
	xiongwei.song@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, llvm@lists.linux.dev, 
	Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 8:02=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Wed, Jul 10, 2024 at 04:03:33AM +0100, Matthew Wilcox wrote:
> > On Wed, Jul 10, 2024 at 10:54:18AM +0800, sxwjean@me.com wrote:
> > > From: Xiongwei Song <xiongwei.song@linux.dev>
> > >
> > > The only user of prepare_slab_obj_exts_hook() is
> > > alloc_tagging_slab_alloc_hook(), which can build with
> > > CONFIG_MEM_ALLOC_PROFILING enabled. So, the warning was triggerred
> > > when disabling CONFIG_MEM_ALLOC_PROFILING. Let's add "__maybe_unused"
> > > for prepare_slab_obj_exts_hook().
> >
> > Perhaps instead clang can be fixed to match gcc's behaviour?
>
> Clang only differs from GCC on warning for unused static inline functions=
 in .c
> files, not .h files. The kernel already handles this in
> include/linux/compiler_types.h but it disables this workaround for W=3D1 =
to catch
> unused functions like this as a result of commit 6863f5643dd7 ("kbuild: a=
llow
> Clang to find unused static inline functions for W=3D1 build"):
>
> /*
>  * GCC does not warn about unused static inline functions for -Wunused-fu=
nction.
>  * Suppress the warning in clang as well by using __maybe_unused, but ena=
ble it
>  * for W=3D1 build. This will allow clang to find unused functions. Remov=
e the
>  * __inline_maybe_unused entirely after fixing most of -Wunused-function =
warnings.
>  */
> #ifdef KBUILD_EXTRA_WARN1
> #define __inline_maybe_unused
> #else
> #define __inline_maybe_unused __maybe_unused
> #endif
>
> So I don't really think there is much for clang to do here and I think ha=
ving
> the ability to find unused static inline functions in .c files is useful =
(you
> might disagree, perhaps a revert could still be discussed). I guess
> IS_ENABLED() can't be used there, so it seems like either taking this pat=
ch,
> ignoring the warning, or refactoring the code in some other way are the o=
nly
> options I see.

I think this is the consequence of the recent refactoring I've done in
https://lore.kernel.org/all/20240704135941.1145038-1-surenb@google.com/.
There should be a cleaner way to fix this. I'll post it later today or
tomorrow morning.
Thanks,
Suren.

>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202407050845.zNONqauD-l=
kp@intel.com/
> > > Signed-off-by: Xiongwei Song <xiongwei.song@linux.dev>
> > > ---
> > >  mm/slub.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index ce39544acf7c..2e26f20759c0 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -2027,7 +2027,7 @@ static inline bool need_slab_obj_ext(void)
> > >     return false;
> > >  }
> > >
> > > -static inline struct slabobj_ext *
> > > +static inline struct slabobj_ext * __maybe_unused
> > >  prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *=
p)
> > >  {
> > >     struct slab *slab;
> > > @@ -2068,7 +2068,7 @@ static inline bool need_slab_obj_ext(void)
> > >     return false;
> > >  }
> > >
> > > -static inline struct slabobj_ext *
> > > +static inline struct slabobj_ext * __maybe_unused
> > >  prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *=
p)
> > >  {
> > >     return NULL;
> > > --
> > > 2.34.1
> > >
> > >

