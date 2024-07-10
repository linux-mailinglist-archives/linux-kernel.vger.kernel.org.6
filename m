Return-Path: <linux-kernel+bounces-247861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16FD92D5B6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1990AB213C4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6A6194AD3;
	Wed, 10 Jul 2024 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yP6a7e/3"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2741D1922C0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627589; cv=none; b=VDlOfgSkJZYD2Ua3dzZQZr7eDZRHwmklGmnRz4NWS+k8sRbUHsoH231SgA4pABgtJwnljG57bi3izfNv1q47dW+vMKkkQdoibrnfq/XTdqVBccUZIQZlCIApTMbca+8jdNNij6sMp/teXvJ4fgH4pGnh+jaklfk+OTjqdFjbm1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627589; c=relaxed/simple;
	bh=6BKqweq9mcfgoolbjQ/B3nozBIjBZsz6QirlRGRgiIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KD4pkExsC0wYzlu04RlasthewAYN2vj7MvgwLkaj1hnphGc5td1wsHW7e5Hkm9yFUXVQcFUNyVjLR2pxNWaOJpQz8MSggUOdmD25FK9Lw/e0qYOqmqv8EelZvXkRoY9G3Cm7CIqliJmu9D4y2C8EXfM2HOoqJVgQLYVALbVOML4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yP6a7e/3; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6325b04c275so61545507b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720627587; x=1721232387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlF5Rn3ADWw5/OD0itHw0bD7+qNVXupDZOEmt04jgJ8=;
        b=yP6a7e/3f3q0CPpxD1xO7cmglqhzfwTTVAWwO9s0po416ouXVwVcwSpQTLO6T2GybO
         dNjjlYJnv/vYyD3LVdkfYhT9yGiOPC9pPU1RiYl3oW33Ysaan1sxsZoKKYODX2LwHGci
         fa8L0pCUfHk0Z90xOi7z/wPmqiDbwKnaV1HnM/b3QEw9X7QQ9fWSVFpj9YiUrARcoXxX
         VyDnOZH0UsZtRJt/7/MxuZLMdnlFrC1k3iXHtp0SV42AqCmNXvYTLlOOQehMwAfEZ1es
         BHOyQJ51ru0uwyDhZxS3wnoL/ikqFc5GtT9jAWGuA1k9LZGAnPDWl3onC+0YkRg9wCK8
         HKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720627587; x=1721232387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlF5Rn3ADWw5/OD0itHw0bD7+qNVXupDZOEmt04jgJ8=;
        b=KXcSQ3Pm/5KhgMilRLmKSoyVwgXsjEoS91Vt0G9zOiiIwJMadoP/1eiNkiIDXse3kX
         w9lX3iVUJHEuWwUKhIjsqeMYEOaL3jXe5oxqxTWFiSwFt6+uPB1gZhGdMvbeZh5+f2tP
         +qxxgZu+xy9NZYwZEfqCpJ3ogzwrZ6Kt7EU6zy1WOLTAxplgwjce4BZVGpFe5qnskYy3
         9YUR0EQ3gevBqyXB7NGbjVAQq7oN5FW9McTx5xPEfk518sv4taLaPyQ2N0zxLViEZQm6
         Z83py3UbbfvaUHAFRrIfplRjh4MnJDojtNeZqL6UxIViobrzM1WY9XItuGIfUsx+nouG
         Bcnw==
X-Forwarded-Encrypted: i=1; AJvYcCUR1xlRqNy7NrbCTRTycltW9QbXHgP8AROoFntDOfM7Pixfg+eKg2glzdfXSs7Pl4nRS6eYsySnX28O8qp/PUpc/tWbepsXDU06pdRJ
X-Gm-Message-State: AOJu0Yw8w6K67WKO9lH0B3TdZj2BSckwyz3j/e9w1SQgaeop6Q1RfhvK
	1i2brS796Zrt1kC6p+qImWVuDAqk8GA7q8zYLKwO9L0czjCv+9pGcLo2biLE0qL7IEokLaa9dpx
	8tIZ/j4lDvx2gCAULl8BCsr3EOJUdPJ1aN5je
X-Google-Smtp-Source: AGHT+IH6BAu3tEa7bMrRM+yyA+9N9JUHSbvvBrnpdQl+cK4blUIFsPDTKGfLnvg/2h7lsnhKsZCrOpwdf76FpytT15A=
X-Received: by 2002:a81:ae25:0:b0:64b:7bf3:cf93 with SMTP id
 00721157ae682-658f0bc6224mr67409727b3.35.1720627586768; Wed, 10 Jul 2024
 09:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-8-Liam.Howlett@oracle.com> <0699b053-607c-4230-8fbd-e7515fd8454d@lucifer.local>
In-Reply-To: <0699b053-607c-4230-8fbd-e7515fd8454d@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 10 Jul 2024 09:06:13 -0700
Message-ID: <CAJuCfpFRW10sVig0fWf2R8eqy3RiC9HPZXwLK-uA5GVjE-=Tfw@mail.gmail.com>
Subject: Re: [PATCH v3 07/16] mm/mmap: Extract validate_mm() from vma_complete()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 12:35=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Jul 04, 2024 at 02:27:09PM GMT, Liam R. Howlett wrote:
> > vma_complete() will need to be called during an unsafe time to call
> > validate_mm().  Extract the call in all places now so that only one
> > location can be modified in the next change.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  mm/mmap.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 2a1a49f98fa3..8d9be791997a 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -646,7 +646,6 @@ static inline void vma_complete(struct vma_prepare =
*vp,
> >       }
> >       if (vp->insert && vp->file)
> >               uprobe_mmap(vp->insert);
> > -     validate_mm(mm);
> >  }
> >
> >  /*
> > @@ -734,6 +733,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
> >       vma_iter_store(vmi, vma);
> >
> >       vma_complete(&vp, vmi, vma->vm_mm);
> > +     validate_mm(vma->vm_mm);
> >       return 0;
> >
> >  nomem:
> > @@ -775,6 +775,7 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
> >       vma_iter_clear(vmi);
> >       vma_set_range(vma, start, end, pgoff);
> >       vma_complete(&vp, vmi, vma->vm_mm);
> > +     validate_mm(vma->vm_mm);
> >       return 0;
> >  }
> >
> > @@ -1103,6 +1104,7 @@ static struct vm_area_struct
> >       }
> >
> >       vma_complete(&vp, vmi, mm);
> > +     validate_mm(mm);
> >       khugepaged_enter_vma(res, vm_flags);
> >       return res;
> >
> > @@ -2481,6 +2483,7 @@ static int __split_vma(struct vma_iterator *vmi, =
struct vm_area_struct *vma,
> >
> >       /* vma_complete stores the new vma */
> >       vma_complete(&vp, vmi, vma->vm_mm);
> > +     validate_mm(vma->vm_mm);
> >
> >       /* Success. */
> >       if (new_below)
> > @@ -3353,6 +3356,7 @@ static int do_brk_flags(struct vma_iterator *vmi,=
 struct vm_area_struct *vma,
> >               vma_iter_store(vmi, vma);
> >
> >               vma_complete(&vp, vmi, mm);
> > +             validate_mm(mm);
> >               khugepaged_enter_vma(vma, flags);
> >               goto out;
> >       }
> > --
> > 2.43.0
> >
> >
>
> LGTM
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

