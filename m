Return-Path: <linux-kernel+bounces-277144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18C1949D30
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB43A1C22741
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767331DFCB;
	Wed,  7 Aug 2024 00:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGo106OG"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF441D6AA
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 00:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722992378; cv=none; b=ZjCr9IOR05PklXq4pxkNfYL3QRXP1lC2bngRR+r1CACRFKw668AorGVYMEGdaktWFU2PWMSB8pxen7EcqDgpJH7aOWTcpWAe0THaFGY8YG3DFKm+QfR519lTVna/Sa5AAZAXDJXWTfoiAGzH8c1ehWBFFGCIR0woT9CTNie0YmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722992378; c=relaxed/simple;
	bh=FvTOEaHCCGZc3N0PQP4b/zypbNy5ImZuOXaJGzNfxbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnMFGRY8FhhNKgjzjKBDXKlLbz2uokjQPKNh/VDX3D+HRhnQKRxUirxTpHPapKjcJXqD7FligP4Rn3Mw9EJowqrSU31YYX+QifyAnLlDMNEJRqLkQgaQ0nfzLjDcgQ7tn2tbcdeyRRnx8PQmlwqP39vb3inxqDmkkbIS/amCr/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGo106OG; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4f51981b1beso404199e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 17:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722992376; x=1723597176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/zWL29hdyvEzV7Dx3NpHGM7LwvWGJZsiABUiodDO/I=;
        b=WGo106OGrlU15inRGZFs568o1kRiH7iZwI2usH/9lRbg4z3EFQy6rNao3f/BRnQ+Uf
         /ZRFOXDildRoaHZInUG7GZYa5B01JIhMOQVWskCOWNz7IrjnIhF5XeYyfpsgBUF4YZsL
         6LSh41aoopcZVbxBMILc0IYwgwHuQ2lEeh+FhA0G+RHc0m5991sjOvgjNC8VFCNpQBzz
         0IrxRoMBfhyPsRdPAmcAJYlfBf70izktT1ViRtL3edjIElpgQ6xupqx6tKCO6JPSJP4B
         oj1ugRFPBzdQi7wHvB0C5AaP3FuW7wwJR46tu3F/rh4CIudfoYx9/X70G28hKIt8n+bC
         PRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722992376; x=1723597176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/zWL29hdyvEzV7Dx3NpHGM7LwvWGJZsiABUiodDO/I=;
        b=p31FLYNwfrf8V1C69rJURciLRaEGOM1dnNXR2H8nVJkajGlOQ9F6SzwBt/LEdnUHBL
         JxzmcI+y4XMGd5SOrFXh/LvBqWW7/3EsOgDEjOZbLgVyU6ZY66Ab+HbBS/7fDfS+uP2V
         FIG1v/Tlj7ztDAY/Zt7PA8HfwUrs+CXAPORVQrzg3QObM6e77EfDSDfBHLw/a4sE6sDG
         7UPNJbZD/2ABO71MhgRaWk8ANECddK8wrW+cPo59PCHkxP61tnWONk8ml1mjSdeyv7mR
         HZorhOCzxDia2P4dqhkV/HagS8rUXErp+US1wzGEBtoAXwIxuBkMVmqLt6aH8G3D6yDw
         64lw==
X-Forwarded-Encrypted: i=1; AJvYcCXTKKcJcRDdd3p2SiFsSKkF3ZGpsgh5fjy6bUbhghXWcqPWLu38MNwryJS+B5553e0Tz/fvd81NPAhyUEi7+3IDVhom4igP7vJB+sBm
X-Gm-Message-State: AOJu0Yxw424aSr4OXJoHxeMKunEvi3L91WF2OupYeO6bYZ+Me74SVyeT
	YmTkOwGMb+YV25OvplpGK8GbGDGoV9yMbnQx98u0/0ajM1oYrs9M3nJndyVu+HC94VnTJFPcZG4
	CHQtWKh2nY1Onne6ipqpC8gSEjJU+5cKJ
X-Google-Smtp-Source: AGHT+IG+im5Z1hpppl6N7bXZ0ufd4i86G3mO6JzNNCH3r/og6om1ROH1GSn5lwc2b3C6fx3MKB/EcY1rSTUo31vbjp4=
X-Received: by 2002:a05:6122:78e:b0:4ed:145:348f with SMTP id
 71dfb90a1353d-4f8a001ec65mr21675347e0c.12.1722992375898; Tue, 06 Aug 2024
 17:59:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806212808.1885309-1-pedro.falcato@gmail.com>
 <20240806212808.1885309-5-pedro.falcato@gmail.com> <CALmYWFu_cnS1nHcQxVmjp=a+SdsACi+4YWWvfDGTB=pj=fmS3A@mail.gmail.com>
In-Reply-To: <CALmYWFu_cnS1nHcQxVmjp=a+SdsACi+4YWWvfDGTB=pj=fmS3A@mail.gmail.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Wed, 7 Aug 2024 01:59:24 +0100
Message-ID: <CAKbZUD2hCWoFb4s8ZbGfa7-ejTXbRjMg0wswuo-A2Y8wyomL8A@mail.gmail.com>
Subject: Re: [PATCH 4/7] mm/mremap: Replace can_modify_mm with can_modify_vma
To: Jeff Xu <jeffxu@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 12:09=E2=80=AFAM Jeff Xu <jeffxu@google.com> wrote:
>
> On Tue, Aug 6, 2024 at 2:28=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail=
.com> wrote:
> >
> > Delegate all can_modify checks to the proper places. Unmap checks are
> > done in do_unmap (et al).
> >
> > This patch allows for mremap partial failure in certain cases (for
> > instance, when destination VMAs aren't sealed, but the source VMA is).
> > It shouldn't be too troublesome, as you'd need to go out of your way to
> > do illegal operations on a VMA.
> >
> > Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> > ---
> >  mm/mremap.c | 33 +++++++--------------------------
> >  1 file changed, 7 insertions(+), 26 deletions(-)
> >
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index e7ae140fc64..8af877d7bb0 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -676,6 +676,9 @@ static unsigned long move_vma(struct vm_area_struct=
 *vma,
> >         if (unlikely(flags & MREMAP_DONTUNMAP))
> >                 to_account =3D new_len;
> >
> > +       if (!can_modify_vma(vma))
> > +               return -EPERM;
> > +
> I m not 100% sure, but I suspect you don't need this check? Is
> vma_to_resize already checking the src address ?

Hmm, yes, good point.

>
> PS. Is it possible to consolidate all the related changes (except the
> fix for madvise) to a single commit ?

The patch set is organized logically, in simple clear steps. As a
maintainer, I would prefer to review something like this vs a big
confusing patch that touches many things at once.
Of course if the maintainers think this is too coarse (it's not
exactly a large patch set, just moves a lot of code back and forth),
I'm happy to merge these into larger chunks.

>  It would be easier to look for dependency, e.g. the remap depends on mun=
map().

All patches depend on the previous (and a single patch would make it
harder to see these dependencies). The kernel should build and the
selftests should pass for every patch in the set.

>
> Also selftest is helpful to prove the correctness of the change. (And
> I can also test it)

I have run selftests, and it is.

--=20
Pedro

