Return-Path: <linux-kernel+bounces-255450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB0C9340DA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E041C215AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781361822CE;
	Wed, 17 Jul 2024 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qNAVwqFq"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B3F8F6D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235409; cv=none; b=oarB3d9q/gjp4hdxxi+U1w6iDUP7b6VZZhOniaNiDsiL2WicoyfXcaUdBKXe63yLhUL05l9aXkcHPi9R5vcvuE8zzT2ddf4q7PNJC15fiPBuBwSbACsswDz03GAE5t7mGqzroTFUG6jpX6SBP9+Lb52UFo+3+ITBcLnI3hYBY10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235409; c=relaxed/simple;
	bh=VWBlGCMMfnzdBEG1nXOCixSN2NIjpu7D5lsH+/28jvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIZh4bViYYgx0cdDHt/+rXliEswsnIcX28HtmvKAzz7OeexVWTfn869Ik9P4ZhJQfrKRwPAb2SMc8aXKmvJiUNI/sLZMvUX6+v24moX3kQHpmiGL/8ymw3NNCaoc56CCeTygyg4UDkSX+A0pXVwyVVN91IlOHvni7OQ7uuPnyFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qNAVwqFq; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e05f4c63de6so6478276.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721235407; x=1721840207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i12G5VJh/goLi96BaqvcVsnUNHX/Q+GQ2O62pkYYJ8w=;
        b=qNAVwqFqhW/dBHr89JFg5RHLCi64PFQpdjM+qAoorzvd6FeUrym7RNt2erOrk8t/Jf
         XrDff3GjJ4RBJWQ57q/ud3CuKwM4PUEicoDj054HtXoapl0ReCQMMz9imbHl9zWXQ0KC
         cSLxhn0bHLdR+q72E76rob88m6Vf3zL5n/BAyAgQr1lsI7nMbORAVM4IbnbJ02Rl3tRh
         Ec8cfvynZM1jAaW+mH12bdvEhKLMMNwTyh6DgdP7okO4s4Z/wEZgawnhJ5TdYAKvY51Z
         2bBPBcX52RslTOUia8KdCMIpndU5Rg8tI0aqncRpY93/TBlxkld+tL2rl8YdKDQxJ5KL
         pOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721235407; x=1721840207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i12G5VJh/goLi96BaqvcVsnUNHX/Q+GQ2O62pkYYJ8w=;
        b=RVwKJRAZrk+kIBPJUZq9/FId+Cf0bsBko01FmmO8lnzO+s2cWfDWsLMcn46++lB9dr
         wJdU7MmWHyxCb9naK/3FxKsINTTrS78JsBBPJbWvSJG+QiDAp/YTNzcIm4dwvXDvx7RH
         q8EOeqTLsdPccubRf8uEF+swHofkKmim/OfmRKehM3Xup84SZ6oIOXZ5lInHziyFmji5
         aQDzm0gVESFjfO6dJstM4AkHaLAl04w+bK3iMXsqyDa9w3FC8B7lOpvcwfCuomZlQiVJ
         +s3Uvxm1skm69myQ3h6e/qGd1+o8/qQI1d3AbmbLGgeqiEJzM/wtM9fvPXpNdF44hHmy
         0s2A==
X-Forwarded-Encrypted: i=1; AJvYcCXxxagVvPyb+HkNe07BKTMr04Ap0/Aa7k5sSEX1STf3sjbVRFKsy9gqzliiL8zKvr/MADP10avqiduYhf6B1EaaQfu3eMpfsC3b6ihG
X-Gm-Message-State: AOJu0YywNc4UhdrkQAU1LtbLY7EEeCTdrFnAWEtTJcIXSvUHUsNW3Enh
	ZcJFHqAu6/D2PIr27dCrXI9U0Rk5WbSobue5BUWQ3nx8T6bCewoXjB1G/1kPHXob5F2hzib2KZx
	xbfcjdk1mx0G2bYutyW03r/RGLUG/4CN8Jlrn
X-Google-Smtp-Source: AGHT+IEmx8OrtXRUak6/SiGNEY+kGmjwd8ndsOjMSJQDmChtuL8gBVr9FQvJUijQRToVxds28QJGFrFCMN/ARF5T+7U=
X-Received: by 2002:a05:6902:1006:b0:e03:4253:2d77 with SMTP id
 3f1490d57ef6-e05fe7a52eamr37614276.0.1721235406711; Wed, 17 Jul 2024 09:56:46
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717011631.2150066-1-surenb@google.com> <20240717011631.2150066-2-surenb@google.com>
 <3ac089e1-7a30-42ef-a11a-d4d080e06c69@suse.cz>
In-Reply-To: <3ac089e1-7a30-42ef-a11a-d4d080e06c69@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Jul 2024 09:56:33 -0700
Message-ID: <CAJuCfpEg0UT_J0YazcLZ1dzPXXeXubae9-ZhfHWShsBAq-beHA@mail.gmail.com>
Subject: Re: [PATCH 2/2] alloc_tag: outline and export {get|put}_page_tag_ref()
 used by modules
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, hch@infradead.org, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 2:30=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 7/17/24 3:16 AM, Suren Baghdasaryan wrote:
> > Outline and export get_page_tag_ref() and put_page_tag_ref() so that
> > modules can use them without exporting page_ext_get() and page_ext_put(=
).
> >
> > Fixes: dcfe378c81f7 ("lib: introduce support for page allocation taggin=
g")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202407080044.DWMC9N9I-lkp=
@intel.com/
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Better than exporting page_ext but still seems like suboptimal level to m=
e.
> You have various inline functions that use get/put_page_tag_ref and now w=
ill
> call into them both. IMHO outlining those (and leaving only the static ke=
y
> check inline) is the better way.
>
> As for the report that triggered this, AFAICS it was due to
> free_reserved_page() so it could be enough to only outline that memalloc
> profiling part there and leave the rest as that seems to be used only fro=
m
> core code and no modules.

Doh! I didn't realize that's the only place these functions are used
directly but looks like you are right. Outlining free_reserved_page()
is definitely a much better solution with less performance impact.
I'll post a replacement patch shortly.
Thanks Vlastimil!

>
> > ---
> >  include/linux/pgalloc_tag.h | 23 +++--------------------
> >  lib/alloc_tag.c             | 23 +++++++++++++++++++++++
> >  2 files changed, 26 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
> > index 9cacadbd61f8..3c6ab717bd57 100644
> > --- a/include/linux/pgalloc_tag.h
> > +++ b/include/linux/pgalloc_tag.h
> > @@ -13,6 +13,9 @@
> >
> >  extern struct page_ext_operations page_alloc_tagging_ops;
> >
> > +union codetag_ref *get_page_tag_ref(struct page *page);
> > +void put_page_tag_ref(union codetag_ref *ref);
> > +
> >  static inline union codetag_ref *codetag_ref_from_page_ext(struct page=
_ext *page_ext)
> >  {
> >       return (void *)page_ext + page_alloc_tagging_ops.offset;
> > @@ -23,26 +26,6 @@ static inline struct page_ext *page_ext_from_codetag=
_ref(union codetag_ref *ref)
> >       return (void *)ref - page_alloc_tagging_ops.offset;
> >  }
> >
> > -/* Should be called only if mem_alloc_profiling_enabled() */
> > -static inline union codetag_ref *get_page_tag_ref(struct page *page)
> > -{
> > -     if (page) {
> > -             struct page_ext *page_ext =3D page_ext_get(page);
> > -
> > -             if (page_ext)
> > -                     return codetag_ref_from_page_ext(page_ext);
> > -     }
> > -     return NULL;
> > -}
> > -
> > -static inline void put_page_tag_ref(union codetag_ref *ref)
> > -{
> > -     if (WARN_ON(!ref))
> > -             return;
> > -
> > -     page_ext_put(page_ext_from_codetag_ref(ref));
> > -}
> > -
> >  static inline void pgalloc_tag_add(struct page *page, struct task_stru=
ct *task,
> >                                  unsigned int nr)
> >  {
> > diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> > index 832f79a32b3e..5271cc070901 100644
> > --- a/lib/alloc_tag.c
> > +++ b/lib/alloc_tag.c
> > @@ -4,6 +4,7 @@
> >  #include <linux/gfp.h>
> >  #include <linux/module.h>
> >  #include <linux/page_ext.h>
> > +#include <linux/pgalloc_tag.h>
> >  #include <linux/proc_fs.h>
> >  #include <linux/seq_buf.h>
> >  #include <linux/seq_file.h>
> > @@ -22,6 +23,28 @@ struct allocinfo_private {
> >       bool print_header;
> >  };
> >
> > +/* Should be called only if mem_alloc_profiling_enabled() */
> > +union codetag_ref *get_page_tag_ref(struct page *page)
> > +{
> > +     if (page) {
> > +             struct page_ext *page_ext =3D page_ext_get(page);
> > +
> > +             if (page_ext)
> > +                     return codetag_ref_from_page_ext(page_ext);
> > +     }
> > +     return NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(get_page_tag_ref);
> > +
> > +void put_page_tag_ref(union codetag_ref *ref)
> > +{
> > +     if (WARN_ON(!ref))
> > +             return;
> > +
> > +     page_ext_put(page_ext_from_codetag_ref(ref));
> > +}
> > +EXPORT_SYMBOL_GPL(put_page_tag_ref);
> > +
> >  static void *allocinfo_start(struct seq_file *m, loff_t *pos)
> >  {
> >       struct allocinfo_private *priv;
>

