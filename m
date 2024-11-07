Return-Path: <linux-kernel+bounces-400423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7091E9C0D5B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F344A1F2330D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDA2216437;
	Thu,  7 Nov 2024 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VMKzNfBs"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF3E6F31E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731002112; cv=none; b=F8PLCmlZX1Ti8PZJxA6Jd7tFNiyoB4mAGVU12/rzPhfi0WzrEgq7AKVQ16N4t/gKcvZf3aTNK2YaJXxNdciiMfduNmxD8kaULAMNGNWmT42F165yMaWshPLmfwx8LdXWgK15E+EB0FDB00Xd/snXFNNZKNJpNjj674GHNpMoO6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731002112; c=relaxed/simple;
	bh=8db81/m0vLqt4vySblVakWDotiLiL0olpm0GSvuNflM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5rNqv8OQUR/evRhoEmLmk+wf50W3dn6SHCiX9K7VCZeKz/JHiB0S3mDrtBKSl6zbr+kyl9ykS1vn2i64dvPSoWI35WHPfEqytrhFT77OwlFEjvTe1DzJi2KujPYoumCyqP3DubrQL9qwxxQb0Ni+sXrxgyZIeIa/GVS93stYok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VMKzNfBs; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20ca03687fdso5365ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 09:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731002110; x=1731606910; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dJHgafTTSymPFCusCnWEYe5qEDoW+B6VotswhjHazGg=;
        b=VMKzNfBsirlI7vv9S7cK0ttfAfjwHOBPgo3+13x0q559DJ+7xA3+EfyxhjXh4cg1YY
         QHroaOCrGdKvi73aQXJSLgKJDH5q3aczY3MVnsHO8EunjzTETKyR7muY320wZr9E7VPX
         Ut+B5ZunH8WKxl5LNnroke0WdOnW/olceQdBzMeNuQF2ViEE1SCe2HC+F4/S9LgrGmeX
         O2hXjBM5bTcpwEcH3KLFKdQCGuH2db4bP1RPiEz9vscFnUULmgf7bgj9UXm2/69RDOeJ
         dgwnZUYjVajPDTMS1WvRqBoKQ4LDK+8JuXQU536kdE6o5eswLsbQk5SMmO2HITEY2fl2
         /Lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731002110; x=1731606910;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJHgafTTSymPFCusCnWEYe5qEDoW+B6VotswhjHazGg=;
        b=GG/p/tM23HG5xeIwWUU7D08jra6QWq9VYC+Y98p9oJwDn9ohqREqbiDzLm4YdgY84o
         ieyBTct2MN6PSsfAxRl2DvpeFxblCzk/wh3LSleVixSMZA1OFdtCPD1yRM3mzm+6wCuz
         ExrLdWsWybolsEuIEUb6baWEES420uqvbxi8RrLQrOtTLGFv2fJ8Dw6sxrFGTLWJNnXo
         IaRSv0aR5zxDRrM7dD8AG9lbCoe3X1hT5xT0FuS5PHF159Ap1L/pykRDd96o2Zypog5E
         eo7cyKoZHhtX3KQViYJXJNYRUftgnAw3X0TlxCzAPzvvV70WB80IqQTM5dQTlPVR1v6S
         amSg==
X-Forwarded-Encrypted: i=1; AJvYcCV1m/MpWnDcxMv3z14eD7Tcvhf+ZAHo6N/yfsj4ARijeoxljUNT0JDRNNE7dYqXSpRmYbn6OuASmtU8EOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2PnGQ1i+Ln1BpRzaDLMjtIeDTxBFFsvsv5zI2YXrynWRljKTD
	ipyaU+fR0vMAUreAEOexRFBJcfc5X0wy5TXMkew7LJS+mPcLknVHdlvj58KSAQ==
X-Gm-Gg: ASbGncvd9QSTFXpvRt920vzlVEmJkZzT2itCoHCr04mOI30GRnqaXSvuRfx2Kj5sVCm
	XjM9CeWo0NNjTj9n0MQfSOMkeOYLtfsFU9NjKqI7iL6t7ijW+nQWxjjWsidFd0MuMjA8UgVDbng
	f8uFHtWK3CapLgP58zIra2uqHl4Rim5qr89kMbICBKJ3nM/bxu5lKq03olJ+b9Me85CTR7beuT7
	LJZzb15uENLPSh3LhBRyWH4dZRgyIIpNU4xLRw5is8r1cPxY5NBuN/kjrWKRwZFFSSRDmK0Skf3
	MmllI/gFciONEf8=
X-Google-Smtp-Source: AGHT+IEwHCmXVHkeaE5JPk/rEq0ydaXosJUZOI5AIRZj1675wi3CssCyNpQwugXaB/QL3rt5+Whn5g==
X-Received: by 2002:a17:903:22ce:b0:20b:a2b8:1850 with SMTP id d9443c01a7336-211749884a0mr3883955ad.15.1731002110143;
        Thu, 07 Nov 2024 09:55:10 -0800 (PST)
Received: from google.com (180.145.227.35.bc.googleusercontent.com. [35.227.145.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e42b68sm14910765ad.148.2024.11.07.09.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 09:55:09 -0800 (PST)
Date: Thu, 7 Nov 2024 17:55:05 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Barry Song <v-songbaohua@oppo.com>, Hillf Danton <hdanton@sina.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: Re: [PATCH v2 8/8] binder: use per-vma lock in page installation
Message-ID: <Zyz--bjvkVXngc5U@google.com>
References: <20241107040239.2847143-1-cmllamas@google.com>
 <20241107040239.2847143-9-cmllamas@google.com>
 <CAJuCfpHM8J0S4dXhxmVuFSTUV0czg1CTFpf_C=k7M57T9qh-VQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHM8J0S4dXhxmVuFSTUV0czg1CTFpf_C=k7M57T9qh-VQ@mail.gmail.com>

On Thu, Nov 07, 2024 at 08:16:39AM -0800, Suren Baghdasaryan wrote:
> On Wed, Nov 6, 2024 at 8:03 PM Carlos Llamas <cmllamas@google.com> wrote:
> >
> > Use per-vma locking for concurrent page installations, this minimizes
> > contention with unrelated vmas improving performance. The mmap_lock is
> > still acquired when needed though, e.g. before get_user_pages_remote().
> >
> > Many thanks to Barry Song who posted a similar approach [1].
> >
> > Link: https://lore.kernel.org/all/20240902225009.34576-1-21cnbao@gmail.com/ [1]
> > Cc: Nhat Pham <nphamcs@gmail.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Barry Song <v-songbaohua@oppo.com>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Hillf Danton <hdanton@sina.com>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > ---
> >  drivers/android/binder_alloc.c | 85 +++++++++++++++++++++++-----------
> >  1 file changed, 57 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> > index 814435a2601a..debfa541e01b 100644
> > --- a/drivers/android/binder_alloc.c
> > +++ b/drivers/android/binder_alloc.c
> > @@ -233,6 +233,56 @@ static inline bool binder_alloc_is_mapped(struct binder_alloc *alloc)
> >         return smp_load_acquire(&alloc->mapped);
> >  }
> >
> > +static struct page *binder_page_lookup(struct mm_struct *mm,
> 
> Maybe pass "struct binder_alloc" in both binder_page_lookup() and
> binder_page_insert()?

I'm not sure this is worth it though. Yeah, it would match with
binder_page_insert() nicely, but also there is no usage for alloc in
binder_page_lookup(). It's only purpose would be to access the mm:

  static struct page *binder_page_lookup(struct binder_alloc *alloc,
  					 unsigned long addr)
  {
  	struct mm_struct *mm = alloc->mm;

If you think this is cleaner I really don't mind adding it for v3.

> I like how previous code stabilized mm with mmget_not_zero() once vs
> now binder_page_lookup() and binder_page_insert() have to mmget/mmput
> individually. Not a big deal but looked cleaner.

Sure, I can factor this out (the way it was in v1).

> 
> > +                                      unsigned long addr)
> > +{
> > +       struct page *page;
> > +       long ret;
> > +
> > +       if (!mmget_not_zero(mm))
> > +               return NULL;
> > +
> > +       mmap_read_lock(mm);
> > +       ret = get_user_pages_remote(mm, addr, 1, 0, &page, NULL);
> > +       mmap_read_unlock(mm);
> > +       mmput_async(mm);
> > +
> > +       return ret > 0 ? page : NULL;
> > +}
> > +
> > +static int binder_page_insert(struct binder_alloc *alloc,
> > +                             unsigned long addr,
> > +                             struct page *page)
> > +{
> > +       struct mm_struct *mm = alloc->mm;
> > +       struct vm_area_struct *vma;
> > +       int ret = -ESRCH;
> > +
> > +       if (!mmget_not_zero(mm))
> > +               return -ESRCH;
> > +
> > +       /* attempt per-vma lock first */
> > +       vma = lock_vma_under_rcu(mm, addr);
> > +       if (!vma)
> > +               goto lock_mmap;
> > +
> > +       if (binder_alloc_is_mapped(alloc))
> 
> I don't think you need this check here. lock_vma_under_rcu() ensures
> that the VMA was not detached from the tree after locking the VMA, so
> if you got a VMA it's in the tree and it can't be removed (because
> it's locked). remove_vma()->vma_close()->vma->vm_ops->close() is
> called after VMA gets detached from the tree and that won't happen
> while VMA is locked. So, if lock_vma_under_rcu() returns a VMA,
> binder_alloc_is_mapped() has to always return true. A WARN_ON() check
> here to ensure that might be a better option.

Yes we are guaranteed to have _a_ non-isolated vma. However, the check
validates that it's the _expected_ vma. IIUC, our vma could have been
unmapped (clearing alloc->mapped) and a _new_ unrelated vma could have
gotten the same address space assigned?

The binder_alloc_is_mapped() checks if the vma belongs to binder. This
reminds me, I should also check this for get_user_pages_remote().

> 
> > +               ret = vm_insert_page(vma, addr, page);
> > +       vma_end_read(vma);
> > +       goto done;
> 
> I think the code would be more readable without these jumps:
> 
>         vma = lock_vma_under_rcu(mm, addr);
>         if (vma) {
>                if (!WARN_ON(!binder_alloc_is_mapped(alloc)))
>                        ret = vm_insert_page(vma, addr, page);
>                vma_end_read(vma);
>         } else {
>                /* fall back to mmap_lock */
>                mmap_read_lock(mm);
>                vma = vma_lookup(mm, addr);
>                if (vma && binder_alloc_is_mapped(alloc))
>                        ret = vm_insert_page(vma, addr, page);
>                mmap_read_unlock(mm);
>         }
>         mmput_async(mm);
>         return ret;

Ok. I'm thinking with mmput_async() being factored out, I'll add an
early return. e.g.:

	vma = lock_vma_under_rcu(mm, addr);
	if (vma) {
		if (binder_alloc_is_mapped(alloc))
			ret = vm_insert_page(vma, addr, page);
		vma_end_read(vma);
		return ret;
	}

	/* fall back to mmap_lock */
	 mmap_read_lock(mm);
	 [...]


Thanks,
Carlos Llamas

