Return-Path: <linux-kernel+bounces-302118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D31DB95FA0E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EFE1F24208
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35940199930;
	Mon, 26 Aug 2024 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8R80XJe"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B491990C9
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702107; cv=none; b=UmBF8tvCXD+kPVXx/oLWqETsZYZcxRjZrioOgdGAr3zkzHq3874VLY4NKFG0k3iHzMHvx6Tfsv/aZstgfLbOIoGNl2CtCHEJCIC9gah2Rz3eJTK+TEp5tM5ziu+0eaV3NM79y4sferpztRvxm5QUzJqOjC1TFT/T08x0VeZSSX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702107; c=relaxed/simple;
	bh=hydJfuulIWs+Ffz/O8diV1QB1Pft+WBZZ32M8ZJo1a4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSbpY9WRUax+IfEIujMNGG2Lc9mkA/bef78MI02hxElOq1cgsILZH6/f4ry/Q1PZyHPKaImcu7zAXfHq7qfj5Wg8jnaRFCZFFZ52G5Ieq/fxTKLuKA2vdAPceiEFjfUQFP/kJalgqNBVKCCmyNhh3bwZkCy72Or36lEz2BSpMvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8R80XJe; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4fce23b0e32so1594278e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724702105; x=1725306905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lvqcUUG2VACthL4mM2/GjAp0wLyM/ulL6auuz/aKWo=;
        b=R8R80XJe2V8zrRoxrddIoR/1J15aP20UTyMRpYpX80qdpFdxYx3Z9NQGq7Jyc7hJii
         nHT9//hpbOsGnX2TVUFnYl0YSOaSvSg1veX/fGNtpKXFZY7dlZh8NN97qpeZ5FYKOPAF
         oQhmzMFRQDXBEddANSez//jLvuqSqL4GK1c9vOtcAl95y81kOtN6QhwyZDn08zNaDDCh
         oM1AWetoJ0m1OqOo9Eq/zQzVa9nqeWYjCD2OgkG5Gz2ctpsTYbSLYw2rcCebYNX7uV8/
         1fJiy1V9SyP/7hsOaHr3GQkHkUtSaDphd3lQXBMc/+WDg6JAV8SL8s+0GZ4e/oiMzNbU
         rJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724702105; x=1725306905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lvqcUUG2VACthL4mM2/GjAp0wLyM/ulL6auuz/aKWo=;
        b=EyUUOa4PARvQ8OlkiZj7jL7zAN+A73qIgOEkU4yvGbV9rIKQOM+bee/zS/UBbdLTgx
         2zPjeyFPXPTz5I0kPBRGZPyEq9KBtvvov9KBrEMOpBRexL3GYsGNhjaj5cu0cKf7tSWj
         0WS0yUm+jdnDI1Xw28ZjiD7juWOvEDW3wyHDy1PxlhT5ppd71/OHPR1b2eyaRLO+gRap
         3Wl2UfsgMgj++Hxa7DGkrezqVLOW7XQfM5RaZxv06BoyShVzkNV5EfySB/MUHDOssBSw
         MSxGvgYq+IJqN8BHWto8aqpmmlibCSM6lEAKk05MFonS5GglXijB+eY/9MQ+XBWSeftF
         EC3A==
X-Forwarded-Encrypted: i=1; AJvYcCWi1LaYfIQJX4GmrV15Txi5P/BbI/iThnyezMukWY0ZlEFQWyUp7IskdiwNPSNTQeg3IxOhcklKQU1A+MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJgc43ds/tltIcQaP0q9JxKqq7aJoe91fNO2VF18UKkp6tNrmy
	YYyoDYJ1D+i91cwjjSSctD17u0PVki1lSaKFsHaP+Fp9s4DIOsE68bE/mf/G6QKle76KBc1eyc5
	Wfx00yG9/URvZTtWtOS+S/IChhSy6+DSB0MI=
X-Google-Smtp-Source: AGHT+IHwPN+032XqzmoIu+B1HBK8b/v//3b8UQegfRNZi7W6W0C5NE/aG85RhBHq2CFB5Xx6WoFJlkXqCXAO0y87GOg=
X-Received: by 2002:a05:6122:2919:b0:4eb:12da:14c7 with SMTP id
 71dfb90a1353d-4fed5daef35mr977467e0c.6.1724702104613; Mon, 26 Aug 2024
 12:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f29f64e29c08427b95e3df30a5770056@honor.com> <ZsXho27uAbQ5rEgS@tiehlicka>
 <CAGsJ_4zgQ0MBV-yucc0-7BcDgjMMdCUDWK330mrd7SS4ej6Q8Q@mail.gmail.com>
 <CAJuCfpE7qsbFPseGzcBp27uNDhwtKLypKiPnqebE5=T8WDTyEQ@mail.gmail.com> <CA+EESO7BuywqjM9pk3KbgdfsYJerpU1-5d9AN20mBjA6e_97UQ@mail.gmail.com>
In-Reply-To: <CA+EESO7BuywqjM9pk3KbgdfsYJerpU1-5d9AN20mBjA6e_97UQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 27 Aug 2024 07:54:53 +1200
Message-ID: <CAGsJ_4zAf7LuJNOrUSG=kvFQf5Px1mYLMvCyF=q31uwghGY-wA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: add lazyfree folio to lru tail
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Nicolas Geoffray <ngeoffray@google.com>, 
	Michal Hocko <mhocko@suse.com>, gaoxu <gaoxu2@honor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shaohua Li <shli@fb.com>, 
	yipengxiang <yipengxiang@honor.com>, fengbaopeng <fengbaopeng@honor.com>, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 4:37=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.co=
m> wrote:
>
> Thanks Suren for looping in
>
> On Fri, Aug 23, 2024 at 4:39=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Wed, Aug 21, 2024 at 2:47=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > On Wed, Aug 21, 2024 at 8:46=E2=80=AFPM Michal Hocko <mhocko@suse.com=
> wrote:
> > > >
> > > > On Fri 16-08-24 07:48:01, gaoxu wrote:
> > > > > Replace lruvec_add_folio with lruvec_add_folio_tail in the lru_la=
zyfree_fn:
> > > > > 1. The lazy-free folio is added to the LRU_INACTIVE_FILE list. If=
 it's
> > > > >    moved to the LRU tail, it allows for faster release lazy-free =
folio and
> > > > >    reduces the impact on file refault.
> > > >
> > > > This has been discussed when MADV_FREE was introduced. The question=
 was
> > > > whether this memory has a lower priority than other inactive memory=
 that
> > > > has been marked that way longer ago. Also consider several MADV_FRE=
E
> > > > users should they be LIFO from the reclaim POV?
>
> Thinking from the user's perspective, it seems to me that FIFO within
> MADV_FREE'ed pages makes more sense. As a user I expect the longer a
> MADV_FREE'ed page hasn't been touched, the chances are higher that it
> may not be around anymore.
> > >

Hi Lokesh,
Thanks!

> > > The priority of this memory compared to other inactive memory that ha=
s been
> > > marked for a longer time likely depends on the user's expectations - =
How soon
> > > do users expect MADV_FREE to be reclaimed compared with old file foli=
os.
> > >
> > > art guys moved to MADV_FREE from MADV_DONTNEED without any
> > > useful performance data and reason in the changelog:
> > > https://android-review.googlesource.com/c/platform/art/+/2633132
> > >
> > > Since art is the Android Java heap, it can be quite large. This incre=
ases the
> > > likelihood of packing the file LRU and reduces the chances of reclaim=
ing
> > > anonymous memory, which could result in more file re-faults while hel=
ping
> > > anonymous folio persist longer in memory.
>
> Individual heaps of android apps are not big, and even in there we
> don't call MADV_FREE on the entire heap.

How do you define "Individual heaps of android apps", do you know the usual
total_size for a phone with memory pressure by running multiple apps and ho=
w
much for each app?

> > >
> > > I am really curious why art guys have moved to MADV_FREE if we have
> > > an approach to reach them.
>
> Honestly, it makes little sense as a user that calling MADV_FREE on an
> anonymous mapping will impact file LRU. That was never the intention
> with our ART change.
>

This is just how MADV_FREE is implemented in the kernel, this kind of lazyf=
ree
anon folios are moved to file but *NOT* anon LRU.

> From our perspective, once a set of pages are MADV_FREE'ed, they are
> like a page-cache. It gives an opportunity, without hurting memory
> use, to avoid overhead of page-faults, which happen frequently after
> GC is done on running apps.
>
> IMHO, within LRU_INACTIVE_FILE, MADV_FREE'ed pages should be
> prioritized for reclamation over file ones.

This is exactly what this patch is doing, putting lazyfree anon folios
to the tail of file LRU so that they can be reclaimed earlier than file
folios. But the question is: is the requirement "MADV_FREE'ed pages
should be prioritized for reclamation over file ones" universally true for
all other non-Android users?

> >
> > Adding Lokesh.
> > Lokesh, could you please comment on the reasoning behind the above
> > mentioned change?
>
> Adding Nicolas as well, in case he wants to add something.
> >
> > >
> > > >
> > > > --
> > > > Michal Hocko
> > > > SUSE Labs
> > > >
> > >

Thanks
Barry

