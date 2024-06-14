Return-Path: <linux-kernel+bounces-215418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C43CC909276
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 20:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A17F1F21ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980571474B1;
	Fri, 14 Jun 2024 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rw+wpOwv"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BC619E7D3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 18:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718390521; cv=none; b=mmHpE40KFi2jXli99WLB946HVMTrmD9W5LiLqiWiC5ZrzM17SPPSRpeq+lPfcE0L51/QPE9IICqitYwMQLNfvyHQ2y+/xMg6/i8ozI+cRI0yCq8z71eBqooSFWJ/8TD6ZmvUO3QpjOgyVm10fY+sZHHi/Q8xdxglBCmQzRhhr8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718390521; c=relaxed/simple;
	bh=smhGVoNScnHd2z7vMT22m6DH6aKiAwPtLS5rY7FZD6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbYZzGZc3C2Gnsdv7ej9PCbBjUgy0SFRPI+I0wEz4gYR9VG2kc8HepfBLJlkxFaxg5oy/ZV/Lce/0iEUw5+ImfWSn/EhJVg2Ilzc+rR4KoyPO86kIY92McUCX/W20LH8sBF3ZHZ5OWbpU/Nh2hVWGcxwYF3L9S4m6SMKzqzcDMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rw+wpOwv; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec17eb4493so12607761fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 11:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718390518; x=1718995318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uj57t1ODMW2OcVRkdwrT3HO4yZE9XuGW/qj+IY0Y/Ko=;
        b=rw+wpOwvRn+Dhy7CereSzDsFTqJoIzTOgnNoyaxuuLdu74LbQ/FB3F7/GzOZI4qO2o
         kRC+DXk4LTM8r5tchrsxu7jsNFicMD2LkAhNC/2pDtlPHDE4vccJ1igRm806eSqaq9JO
         ePrCZqNBTqKbKNUnBeH2B4HHZzLCaIM9YJO8lqotN9u7yP7RRbLljePRIDreAh8qbJgs
         ndBWWMTX5TlFJfxNcs7Fsq4BkMAz0Vzz7+gCKTPATpt4tNQ6QjvKjWStziWR5u3JEucw
         ZCwPoDngN65oriiB4cWNU3C7cJgmBDnJDm14APoO0YfdGRiZTD6sRePTZ6uikzm4eZyr
         Irxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718390518; x=1718995318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uj57t1ODMW2OcVRkdwrT3HO4yZE9XuGW/qj+IY0Y/Ko=;
        b=taxwxbklWCsasduw3JauDGanzWyNj6oIJz/cgGw+HKmXlpTkKRZ9eZu+R1u2fX365Z
         zlb/cQikdrhBZICJcQWeYBZdOvU47eT7e6ntEs1AWYhriBvcPoyUQDzcSqCW+vAmzwrw
         iwbaP7pM3QVh2Nouo9r0jKttatMtu3rN46Sh6cr/ocTmv84EErgV1AqVw4rHDZbRIqyh
         fatsvidx7DBY5IuaAzCfLjzBWqM8e+hyqEZJzLAx/Y3fzCGzJ1ZibOVy3ya4foXqvYyD
         2pjubI8AsL05qb4KYmou881XBc9jgzDx4xhR3ObDIMlSzzSAFeW8JJZe7KKXWLiehz9E
         UHkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPLKoYphbl41LkWtOH/i1PXb86Ix7uuBlZzUW2og1C4wV+OU3RjGJs2FhFYs9eC0zaIHPg1zfq64Zu651ZmMkRLpyS9FgTsC4tK/wm
X-Gm-Message-State: AOJu0Yw9AP7j4u1pgL17V/SCiW9IVNYuHvE3yDEMi2vmgUY1xpJR5uZT
	p2JaKtOB4ctI2Y70G+YAHJ6rEgOPRe8mTQxZLn+bSzcgopUGqYnNxiFjzRwY604E6Zi5jy9qZe7
	6oTGutgCKKhf3bx+c8liYdM5Nq9IfVmQR7Y4Q
X-Google-Smtp-Source: AGHT+IFzCV2gPA0qaN2e8B6qjxroL2HsxN6qG52djyO/eLkThaU6zDeJHIOz6lk6qq7yEJ8jNwjWoXlE0b8yTETozrA=
X-Received: by 2002:a2e:a443:0:b0:2ec:1973:2b89 with SMTP id
 38308e7fff4ca-2ec19732c1amr18483151fa.30.1718390518143; Fri, 14 Jun 2024
 11:41:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614100902.3469724-1-usamaarif642@gmail.com>
 <20240614100902.3469724-2-usamaarif642@gmail.com> <b5952ee4-3b86-40ff-a3de-8a08f09557bd@linux.dev>
In-Reply-To: <b5952ee4-3b86-40ff-a3de-8a08f09557bd@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 14 Jun 2024 11:41:21 -0700
Message-ID: <CAJD7tkY6rxiB1oR+ykWFqx6JV=xsM-maPtu1rtthJZY_z1h5MQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] mm: store zero pages to be swapped out in a bitmap
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, david@redhat.com, ying.huang@intel.com, 
	hughd@google.com, willy@infradead.org, nphamcs@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 5:06=E2=80=AFAM Chengming Zhou <chengming.zhou@linu=
x.dev> wrote:
>
> On 2024/6/14 18:07, Usama Arif wrote:
> > Approximately 10-20% of pages to be swapped out are zero pages [1].
> > Rather than reading/writing these pages to flash resulting
> > in increased I/O and flash wear, a bitmap can be used to mark these
> > pages as zero at write time, and the pages can be filled at
> > read time if the bit corresponding to the page is set.
> > With this patch, NVMe writes in Meta server fleet decreased
> > by almost 10% with conventional swap setup (zswap disabled).
> >
> > [1] https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d=
03d1344dde9fce0@epcms5p1/
> >
> > Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>
> Looks good to me, only some small nits below.
>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
>
> > ---
> >  include/linux/swap.h |   1 +
> >  mm/page_io.c         | 113 ++++++++++++++++++++++++++++++++++++++++++-
> >  mm/swapfile.c        |  15 ++++++
> >  3 files changed, 128 insertions(+), 1 deletion(-)
> >
> [...]
> > +
> > +static void swap_zeromap_folio_set(struct folio *folio)
> > +{
> > +     struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> > +     swp_entry_t entry;
> > +     unsigned int i;
> > +
> > +     for (i =3D 0; i < folio_nr_pages(folio); i++) {
> > +             entry =3D page_swap_entry(folio_page(folio, i));
>
> It seems simpler to use:
>
> swp_entry_t entry =3D folio->swap;
>
> for (i =3D 0; i < folio_nr_pages(folio); i++, entry.val++)

I was actually thinking we could introduce folio_swap_entry(folio, i)
after the series. Multiple callers of page_swap_entry() have a folio
already. It would save some compound_head() calls.

Alternatively, for this patch we can introduce
zeromap_update_range(zeromap, offset, size, value). Then we can use it
in swap_zeromap_folio_set/cear() as well as swap_range_free(). It
would also be a good place to park the comment about using atomic
operations (set_bit() and clear_bit()).

