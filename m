Return-Path: <linux-kernel+bounces-255556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 507C3934235
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF851C20F1D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4900E183074;
	Wed, 17 Jul 2024 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VEGEwBL3"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E140212E75
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721240678; cv=none; b=Ggcz0VnmijbPa0xwHDac0bs80WA/boPpZp3fVFgxSjiuGNxgLTgNFhoB7CyAdVELogLc+rYH89Gc4lISzaosjsFotljg7JgtXCrL2DyHEkjYM36zQNnCJCHcFByxL37J6F+qu1Z3ux3ulMkmR2vDnVJdmXS+ATN8ceEVJnLc7gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721240678; c=relaxed/simple;
	bh=p488mQambiaGvyNpDa2noXTG7M+0vQEH/mp/lBzE0us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ill2tNI/R3vISy5818saF7kBRDJzxlM0+FmLStd4Dz4jR1jRTaSdzS0s3Pbd86AZFIGCNty/QrXG0Gb4kzyGhGjWgvX6MNQFjS7yo+KdgLV7nK/VC6XsuYPZe9v4zp6N3pHgjQI05yTIlHpi7hR7uLs71z7xpaJE0on6ol0UzjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VEGEwBL3; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso6538276.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721240676; x=1721845476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMJjm2pZ+DsvMud7srr2XuUYDRXABLVy/3Jc46rHkUw=;
        b=VEGEwBL34Q+VzxBgI4mhFOohjObPzy0SMIQshZvInz6pc4CrhnDZ8Kd7rMN9mTT9lK
         gFJ9Wyt+T+6zG9HM5J9As+OHvVY+c8rAcnZm8buSv5kX5ALwO4yf3oKdlvs4G3/MeBm9
         dVVncOHq1LayyWeqj3sgIfQjdLiCnGx9C9gGrMTwn6YI1suNIIlNNZtAsSa1C0DmwOJf
         wRC/FA+FS68n4x7kSz1sRSYERkj9R0r60u8b0prJak56Ez/UpgwTqiramoLXhTGPURUm
         SknhuZru+uOC6l06UckNvmWrEbyjXKccyvxqUww/hLjnbEGOD1ndvHWK7ZU/8JUWDYoN
         3dVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721240676; x=1721845476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMJjm2pZ+DsvMud7srr2XuUYDRXABLVy/3Jc46rHkUw=;
        b=w2uP0owv18JZ9QDME0V3So4ZBgLMuAFtMlofQzWgbBNNONk8nKR5KkNK32/KUS7uUp
         7OVnIqhkuiPbOAstpeSsH0DarbZ7CHdI6J+aEWr/TKnMuwroAyLNwTL0PvJWMYsWt4Nl
         U44m9o7KsArNfG8EKoICpUP7oEw8lOq1MX3iUate5+MwD5cDxLX8G9yG9kN03dRauCrM
         aHeNqMOXxfx2tKvA7PFeR9KpaZVbPhvoRYCfhAxgFxYQYeJf4IQNIWmIj7T4adXIglHV
         1/Sc+eUzi8KBIHuw77YQ69A94FiPhQPJ1YUyk5TxqnNB/+9hG2fYcJ2dXpicdSSayWya
         x9mA==
X-Forwarded-Encrypted: i=1; AJvYcCVfYIUy51uZvw+MRzE5XtKT41TSbvEjJqCYXF3d1bUdKXlHhcQt6prLRsOH1urlD7FzAnjGBQMQoxnoPKscZINKUKWrMOFu1mjJ1qD5
X-Gm-Message-State: AOJu0YzEoSk2ASWMbqva1d0O5R4dosRHU476FvwAN+zIXjwCvaIUJBrp
	tFFVFsQxdp/pvJppADHrTToEmgQe8+rMFG843FzmejEMD2wRQLoc72qVgVR5sqFmf7t4HvNmJRX
	+ncUg2TyLqKU6FnpnLWXBfuWrQEBZlgZtM4T/
X-Google-Smtp-Source: AGHT+IHaGgUTh8zHuGL3Sp7GT1Pb+jqBZz4bQYJnQQgmRrsGK/qpfFglBTy5nUzChaux1YuFNB5zoEi6ac5f8yr1mCM=
X-Received: by 2002:a05:6902:1883:b0:dfa:ebf2:51ab with SMTP id
 3f1490d57ef6-e05ed7360f6mr3328176276.16.1721240675406; Wed, 17 Jul 2024
 11:24:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717011631.2150066-1-surenb@google.com> <20240717011631.2150066-2-surenb@google.com>
 <3ac089e1-7a30-42ef-a11a-d4d080e06c69@suse.cz> <CAJuCfpEg0UT_J0YazcLZ1dzPXXeXubae9-ZhfHWShsBAq-beHA@mail.gmail.com>
In-Reply-To: <CAJuCfpEg0UT_J0YazcLZ1dzPXXeXubae9-ZhfHWShsBAq-beHA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Jul 2024 11:24:22 -0700
Message-ID: <CAJuCfpH-uyjkcdSq_dZVeOuYT0KS105nJr-n6W0M7XhR=U7hDw@mail.gmail.com>
Subject: Re: [PATCH 2/2] alloc_tag: outline and export {get|put}_page_tag_ref()
 used by modules
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, hch@infradead.org, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 9:56=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Jul 17, 2024 at 2:30=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> =
wrote:
> >
> > On 7/17/24 3:16 AM, Suren Baghdasaryan wrote:
> > > Outline and export get_page_tag_ref() and put_page_tag_ref() so that
> > > modules can use them without exporting page_ext_get() and page_ext_pu=
t().
> > >
> > > Fixes: dcfe378c81f7 ("lib: introduce support for page allocation tagg=
ing")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202407080044.DWMC9N9I-l=
kp@intel.com/
> > > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >
> > Better than exporting page_ext but still seems like suboptimal level to=
 me.
> > You have various inline functions that use get/put_page_tag_ref and now=
 will
> > call into them both. IMHO outlining those (and leaving only the static =
key
> > check inline) is the better way.
> >
> > As for the report that triggered this, AFAICS it was due to
> > free_reserved_page() so it could be enough to only outline that memallo=
c
> > profiling part there and leave the rest as that seems to be used only f=
rom
> > core code and no modules.
>
> Doh! I didn't realize that's the only place these functions are used
> directly but looks like you are right. Outlining free_reserved_page()
> is definitely a much better solution with less performance impact.
> I'll post a replacement patch shortly.
> Thanks Vlastimil!

v2 posted at [1]

As a reminder for Andrew, the patchset [1] should replace the older
patch [2] currently present in mm-unstable and mm-hotfixes-unstable.

[1] https://lore.kernel.org/all/20240717181239.2510054-2-surenb@google.com/
[2] ac5ca7954e4e ("alloc_tag: export memory allocation profiling
symbols used by modules")

Thanks,
Suren.

>
> >
> > > ---
> > >  include/linux/pgalloc_tag.h | 23 +++--------------------
> > >  lib/alloc_tag.c             | 23 +++++++++++++++++++++++
> > >  2 files changed, 26 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.=
h
> > > index 9cacadbd61f8..3c6ab717bd57 100644
> > > --- a/include/linux/pgalloc_tag.h
> > > +++ b/include/linux/pgalloc_tag.h
> > > @@ -13,6 +13,9 @@
> > >
> > >  extern struct page_ext_operations page_alloc_tagging_ops;
> > >
> > > +union codetag_ref *get_page_tag_ref(struct page *page);
> > > +void put_page_tag_ref(union codetag_ref *ref);
> > > +
> > >  static inline union codetag_ref *codetag_ref_from_page_ext(struct pa=
ge_ext *page_ext)
> > >  {
> > >       return (void *)page_ext + page_alloc_tagging_ops.offset;
> > > @@ -23,26 +26,6 @@ static inline struct page_ext *page_ext_from_codet=
ag_ref(union codetag_ref *ref)
> > >       return (void *)ref - page_alloc_tagging_ops.offset;
> > >  }
> > >
> > > -/* Should be called only if mem_alloc_profiling_enabled() */
> > > -static inline union codetag_ref *get_page_tag_ref(struct page *page)
> > > -{
> > > -     if (page) {
> > > -             struct page_ext *page_ext =3D page_ext_get(page);
> > > -
> > > -             if (page_ext)
> > > -                     return codetag_ref_from_page_ext(page_ext);
> > > -     }
> > > -     return NULL;
> > > -}
> > > -
> > > -static inline void put_page_tag_ref(union codetag_ref *ref)
> > > -{
> > > -     if (WARN_ON(!ref))
> > > -             return;
> > > -
> > > -     page_ext_put(page_ext_from_codetag_ref(ref));
> > > -}
> > > -
> > >  static inline void pgalloc_tag_add(struct page *page, struct task_st=
ruct *task,
> > >                                  unsigned int nr)
> > >  {
> > > diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> > > index 832f79a32b3e..5271cc070901 100644
> > > --- a/lib/alloc_tag.c
> > > +++ b/lib/alloc_tag.c
> > > @@ -4,6 +4,7 @@
> > >  #include <linux/gfp.h>
> > >  #include <linux/module.h>
> > >  #include <linux/page_ext.h>
> > > +#include <linux/pgalloc_tag.h>
> > >  #include <linux/proc_fs.h>
> > >  #include <linux/seq_buf.h>
> > >  #include <linux/seq_file.h>
> > > @@ -22,6 +23,28 @@ struct allocinfo_private {
> > >       bool print_header;
> > >  };
> > >
> > > +/* Should be called only if mem_alloc_profiling_enabled() */
> > > +union codetag_ref *get_page_tag_ref(struct page *page)
> > > +{
> > > +     if (page) {
> > > +             struct page_ext *page_ext =3D page_ext_get(page);
> > > +
> > > +             if (page_ext)
> > > +                     return codetag_ref_from_page_ext(page_ext);
> > > +     }
> > > +     return NULL;
> > > +}
> > > +EXPORT_SYMBOL_GPL(get_page_tag_ref);
> > > +
> > > +void put_page_tag_ref(union codetag_ref *ref)
> > > +{
> > > +     if (WARN_ON(!ref))
> > > +             return;
> > > +
> > > +     page_ext_put(page_ext_from_codetag_ref(ref));
> > > +}
> > > +EXPORT_SYMBOL_GPL(put_page_tag_ref);
> > > +
> > >  static void *allocinfo_start(struct seq_file *m, loff_t *pos)
> > >  {
> > >       struct allocinfo_private *priv;
> >

