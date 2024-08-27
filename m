Return-Path: <linux-kernel+bounces-302410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A55F295FDE8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 02:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BEC8283507
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D44E3232;
	Tue, 27 Aug 2024 00:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xdrw/z8y"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552432F22
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 00:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724717541; cv=none; b=GINM7TWoEAjhdnGdpBakWoFgtMOtd42lBKohWjTyD6cIgdAsDv/1/MLaSxfxKRBrGe3GaTqwQlM0Bf/lagtzVqwDR5fVQKACzi791P18IGiuIZjtyE/t804rFHCJFOVPA+JwfBMuHzsGHSdNilZN0iMNhOBKsyAnSES26+xiqEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724717541; c=relaxed/simple;
	bh=bKlG9oPSRv8dK5bHmwS3CJMcC1PaAtCR3wSanEHETSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSDeILUSCcGBmykxJ83QEJhZfxWVxhEdaW7QG34zsC6FOcT2rg81PP6Rv+khXk1i4gcocDOWnoHEZx6sHUvH28nxyyf/B6/pJhWnPoA0FXPVLSYRIEu7rqdbfWy9gY+5bv15v+5fgKcnuJbGiBPly0MJ/la6mldpT65oeXXFah4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xdrw/z8y; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-201fed75b38so49385ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 17:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724717539; x=1725322339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRGRwWPjttcmijXoKbPDYcfgfMfeDSyIylvYYsmrs9A=;
        b=Xdrw/z8yZdq2CnNgShkC061kresPzpIydAn4gY2r1RUN3UQ2wI1YGYvwtoyE6dlfhL
         IpEsLx5VLxm5TFuBvH5spPu9a7qgemkM1RCLwDoJxyC2UwsowyPp1oKOF6XwjLC3TPgi
         pg6lkXzwo6F5IqahQcBU+XbweUlrZEukXMn0swVTX/V3oyVkDokFdAQ3DpqNHVJa7u3j
         ym7qarjZZK66gvcWQ4sA4RA50yJB3AitxuOHpWzkuG+NEQRnt1cTU3LQlSBcNSAij+4i
         c8ztvkvzauoW9YqISOx82YxrrmnzyHoaS4rhb+11QxKTkw5UoyU8muj8ZePiX2Msia1t
         uESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724717539; x=1725322339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRGRwWPjttcmijXoKbPDYcfgfMfeDSyIylvYYsmrs9A=;
        b=eAus20ZxC6mdOB4IJkZfgFnP2w+vRQXKxptIEnJfg0yYY/sr59ltYDbCpobWT6LFjK
         vTE64BhxsQiaEGgWy0bx0cnIXIVUUAHkqVho6JiAawRC7jWo8Q4ThHAo5TEebDbhS3uI
         928cyItlgZtfCw4H1iFRHdv80YrAaGmY/wV4aj6pNJAsuRRY8SLfo7LFr4OEsZvokANj
         o+o12tSoSqXlepENrfjkW9eJz2JKjrFJhe5PgwyVqpEVLIfz5NWTFn5LL0Nldw6jNiVe
         1/Y1BVvV18sRE1jxyH8spJuabbnYHbQLN8Ya0kldyPiqA7BYg9FS3zcXZ77xK0zYlIPy
         DvhA==
X-Forwarded-Encrypted: i=1; AJvYcCVSyMXs2UTPDoRIqNuRRXsIiEXmJkI6RWNHDAGEzIchq+mLogy9rxrqVfq5CFPEVpHmiqy8r25h1MvoPdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw7bXwqYLo35eou+dw6FvEEOXnct/hvz5Jxefi3dIUi2KykPFz
	b07D5+0QX/JkXjD4+BfhhjBtLTrOV4Qo1FuTJLMBy9Ho2nRjdiXjvq5TL4EEogLwEvpuZEH+uVP
	fuLaShv1xMcu7rkP6Mm62mDhArol2p5XB7nwX
X-Google-Smtp-Source: AGHT+IGznodxybhICLFyTDC60nAH6himwX8JRO9ziRWkiLzOyjSxsARmEkZbV137GLRdfgM2JznV2kVTKrUNVUoaS/8=
X-Received: by 2002:a17:902:d346:b0:201:e2db:7bd1 with SMTP id
 d9443c01a7336-204e4fb64c3mr702385ad.19.1724717538983; Mon, 26 Aug 2024
 17:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f29f64e29c08427b95e3df30a5770056@honor.com> <ZsXho27uAbQ5rEgS@tiehlicka>
 <CAGsJ_4zgQ0MBV-yucc0-7BcDgjMMdCUDWK330mrd7SS4ej6Q8Q@mail.gmail.com>
 <CAJuCfpE7qsbFPseGzcBp27uNDhwtKLypKiPnqebE5=T8WDTyEQ@mail.gmail.com>
 <CA+EESO7BuywqjM9pk3KbgdfsYJerpU1-5d9AN20mBjA6e_97UQ@mail.gmail.com> <CAGsJ_4zAf7LuJNOrUSG=kvFQf5Px1mYLMvCyF=q31uwghGY-wA@mail.gmail.com>
In-Reply-To: <CAGsJ_4zAf7LuJNOrUSG=kvFQf5Px1mYLMvCyF=q31uwghGY-wA@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Mon, 26 Aug 2024 17:12:07 -0700
Message-ID: <CA+EESO4MsRxMcTA-_g55rtLE0QTfB3=E53eW8+MSfncwmDx5OQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: add lazyfree folio to lru tail
To: Barry Song <21cnbao@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Nicolas Geoffray <ngeoffray@google.com>, 
	Michal Hocko <mhocko@suse.com>, gaoxu <gaoxu2@honor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shaohua Li <shli@fb.com>, 
	yipengxiang <yipengxiang@honor.com>, fengbaopeng <fengbaopeng@honor.com>, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 12:55=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Tue, Aug 27, 2024 at 4:37=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.=
com> wrote:
> >
> > Thanks Suren for looping in
> >
> > On Fri, Aug 23, 2024 at 4:39=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Wed, Aug 21, 2024 at 2:47=E2=80=AFPM Barry Song <21cnbao@gmail.com=
> wrote:
> > > >
> > > > On Wed, Aug 21, 2024 at 8:46=E2=80=AFPM Michal Hocko <mhocko@suse.c=
om> wrote:
> > > > >
> > > > > On Fri 16-08-24 07:48:01, gaoxu wrote:
> > > > > > Replace lruvec_add_folio with lruvec_add_folio_tail in the lru_=
lazyfree_fn:
> > > > > > 1. The lazy-free folio is added to the LRU_INACTIVE_FILE list. =
If it's
> > > > > >    moved to the LRU tail, it allows for faster release lazy-fre=
e folio and
> > > > > >    reduces the impact on file refault.
> > > > >
> > > > > This has been discussed when MADV_FREE was introduced. The questi=
on was
> > > > > whether this memory has a lower priority than other inactive memo=
ry that
> > > > > has been marked that way longer ago. Also consider several MADV_F=
REE
> > > > > users should they be LIFO from the reclaim POV?
> >
> > Thinking from the user's perspective, it seems to me that FIFO within
> > MADV_FREE'ed pages makes more sense. As a user I expect the longer a
> > MADV_FREE'ed page hasn't been touched, the chances are higher that it
> > may not be around anymore.
> > > >
>
> Hi Lokesh,
> Thanks!
>
> > > > The priority of this memory compared to other inactive memory that =
has been
> > > > marked for a longer time likely depends on the user's expectations =
- How soon
> > > > do users expect MADV_FREE to be reclaimed compared with old file fo=
lios.
> > > >
> > > > art guys moved to MADV_FREE from MADV_DONTNEED without any
> > > > useful performance data and reason in the changelog:
> > > > https://android-review.googlesource.com/c/platform/art/+/2633132
> > > >
> > > > Since art is the Android Java heap, it can be quite large. This inc=
reases the
> > > > likelihood of packing the file LRU and reduces the chances of recla=
iming
> > > > anonymous memory, which could result in more file re-faults while h=
elping
> > > > anonymous folio persist longer in memory.
> >
> > Individual heaps of android apps are not big, and even in there we
> > don't call MADV_FREE on the entire heap.
>
> How do you define "Individual heaps of android apps", do you know the usu=
al
> total_size for a phone with memory pressure by running multiple apps and =
how
> much for each app?
>
Every app is a separate process and therefore has its own private ART
heap. Those numbers that you are asking vary drastically. But here's
what I can tell you:

Max heap size for an app is 512MB typically. But it is rarely entirely
used. Typical heap usage is 50MB to 250MB. But as I said, not all of
it is MADV_FREE'ed. Only those pages which are freed after GC
compaction are.
> > > >
> > > > I am really curious why art guys have moved to MADV_FREE if we have
> > > > an approach to reach them.
> >
> > Honestly, it makes little sense as a user that calling MADV_FREE on an
> > anonymous mapping will impact file LRU. That was never the intention
> > with our ART change.
> >
>
> This is just how MADV_FREE is implemented in the kernel, this kind of laz=
yfree
> anon folios are moved to file but *NOT* anon LRU.
>
> > From our perspective, once a set of pages are MADV_FREE'ed, they are
> > like a page-cache. It gives an opportunity, without hurting memory
> > use, to avoid overhead of page-faults, which happen frequently after
> > GC is done on running apps.
> >
> > IMHO, within LRU_INACTIVE_FILE, MADV_FREE'ed pages should be
> > prioritized for reclamation over file ones.
>
> This is exactly what this patch is doing, putting lazyfree anon folios
> to the tail of file LRU so that they can be reclaimed earlier than file
> folios. But the question is: is the requirement "MADV_FREE'ed pages
> should be prioritized for reclamation over file ones" universally true fo=
r
> all other non-Android users?
>
That's definitely an important question to get answered. But putting
my users hat on again, by explicitly MADV_FREE'ing we ask for that
behavior. IMHO, MADV_FREE'ed pages should be the first ones to be
reclaimed on memory pressure.
> > >
> > > Adding Lokesh.
> > > Lokesh, could you please comment on the reasoning behind the above
> > > mentioned change?
> >
> > Adding Nicolas as well, in case he wants to add something.
> > >
> > > >
> > > > >
> > > > > --
> > > > > Michal Hocko
> > > > > SUSE Labs
> > > > >
> > > >
>
> Thanks
> Barry

