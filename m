Return-Path: <linux-kernel+bounces-400556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F19C99C0F2A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2126D1C244E4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3300217F37;
	Thu,  7 Nov 2024 19:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uJpWna98"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB390197552
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 19:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008445; cv=none; b=R9kgtEfuBmXhoT4vFBFPgHFO1jn0ZOAb5UW1h3PhmoldUluEiYLzTOPqdB/IVP3+sCUp1L3XSNSXrmmZh2x1riPLklVIs+pPpPEgKjjrwL4j+50ypU5VSw04VtCxxtjumdBeHc+N/L+ejvsvRd41hrYoZbJk9krtQUkOVfKuWr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008445; c=relaxed/simple;
	bh=AnTmRrjA61MDTCB8wCQ3eZKcNr4gws5COVKHuXE/58Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPmtrNrDC4xEThiBuJPdk82hPhhn62rZuU6mI5lUNCPdoRnbvVL6uiA6SYTjGivDCzol1x+rnqdSnl2yH4zmNy4q4APsXE4GMtuTaIkuPluqr7XfkwZD2INmzmc0GcRO3DEsTV7xTyMywzXSv1o8pf5RzcMrHi9ny+8EtOOFS9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uJpWna98; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c87b0332cso31925ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 11:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731008443; x=1731613243; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9WW2M/zrPiixk4hko3fb3umsjN/5n31gu9wf2EYkVyM=;
        b=uJpWna98dZ0ifYAyk0BLeEE2CzaqYTgKz6E+nKhXG2hHRhQXwa/c5jPyxK3j0IvGnl
         fkvpeOi2TLIPH5mpK2KgunDmibaNz3MOTF9dmolfwGdEFOOYo5zj5xKw7uzfzFPT4il9
         PU8LtytQ7VQDiwaQJX4/wKqkThc2/KFVjMLGmwN2BXRYxlzOkp0Z5Wa2FqGqwUWooM7N
         jQinI1v9Fi16R+mrz8c+WS0a6iVEgqp4uOMR4NFl82hoA3UsMlZhr/9SJiI7DAVoBRZi
         LEqSbQz6hPupSMaEvje9sTLw2JZcZVPAh3nG05IfH/fvz4qfCHgNFV1oN05krpVQjZSG
         DiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731008443; x=1731613243;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9WW2M/zrPiixk4hko3fb3umsjN/5n31gu9wf2EYkVyM=;
        b=OLNmTIzgL6wZ+CayLyJlWlC+tJIMjmA4MgS/mFp9E7ui/U6TfH5m2YjLAM2x4TbTPd
         ymt8wRb8+MR9JmV4C18JhQRDpNxuMNhoFH+NFWOrrm5tcJOdn/OvbWgXHEJb/4mMPB6m
         2c2VrHLqiggBJoOrkXGaTVtTAYCfP6UNy7zntmp1aUD+2EL0qqoFVJLjgE0alTghtnjN
         rKprPBSG7PVzoN48fDKh5JCLEyjBy6eLmMjLJYWzpz6MoLOb0Q4ziQt9246gBErjKmz0
         /KYNMps0uv2Am7iIFtd9yIx/mj5NNxqpo9azduzxDtv6qruIWqNzWcgQ9XfAtRlXmoRm
         BLYg==
X-Forwarded-Encrypted: i=1; AJvYcCV1+Kh3TWRYfiJYbKF1Ina8PxINRjWfbxYSiw8q+M+Bx60R9Fdd2q8c68sMJRAsT0fRbDzqDcKK1ECY988=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHMUootZkhDF/Wrzs+RDlmZ03kvnlFR5cemoUny3eo9f6dzITA
	6Gca/pSPa1PUz31uxKVKD9L272mcFB1j41us4WhzQ4yvE2pLmOpwOa2gh3M/fw==
X-Gm-Gg: ASbGnctxDacG3UEiIZlrLffkkOdonZvgMTy+FWr9V1BBsEuXF+QOIIOz6j7bxf2cIws
	zQHywsWtvNmu3HB9QDyUzDLEoCuz10xMsVyCJVsHL2OXw6Mu5ugeCCGnv0k9bPi+ck2106CV68/
	dzJWPoMn/tWEv38x/RWuEaxb6icAzYD2e6cZ2bJ5L0Fqi8XCHro2som26dFCqHY7J0GMl69JgUo
	iWPL66NI8n78HEnOZsro1dvRoAwRWiVIlJuoRIiEnkgmZdew9jJrAYFI/odX1N5d9seU2d3Pmic
	jTA8RR0LRA0ilD0=
X-Google-Smtp-Source: AGHT+IGcgVZMgZnGOAogHgVjHlUi4I/gqmaNw35XjRAZqfqeFMn9BPSB2S23GRNQgwdSLIwlv2vyyw==
X-Received: by 2002:a17:902:e751:b0:206:b7b2:4876 with SMTP id d9443c01a7336-211749a4515mr4224165ad.20.1731008442734;
        Thu, 07 Nov 2024 11:40:42 -0800 (PST)
Received: from google.com (180.145.227.35.bc.googleusercontent.com. [35.227.145.180])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a56a30sm2068079b3a.188.2024.11.07.11.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 11:40:42 -0800 (PST)
Date: Thu, 7 Nov 2024 19:40:38 +0000
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
Message-ID: <Zy0Xth2yU9Bqg_an@google.com>
References: <20241107040239.2847143-1-cmllamas@google.com>
 <20241107040239.2847143-9-cmllamas@google.com>
 <CAJuCfpHM8J0S4dXhxmVuFSTUV0czg1CTFpf_C=k7M57T9qh-VQ@mail.gmail.com>
 <Zyz--bjvkVXngc5U@google.com>
 <CAJuCfpHAsgDgqjWmxqwGPxs_i184mrzMSAUZ9fj9PN8eJcGdvQ@mail.gmail.com>
 <Zy0EyMVq0xEdyKNt@google.com>
 <CAJuCfpF2ZyEPfV_rTsftnc=XKCiwGG2-mL67Bt6o3tEBWn+KwQ@mail.gmail.com>
 <CAJuCfpF7Q-uD+Tdyoar_djw+LwckgAbH1uZOABqoRe2=gpGN-Q@mail.gmail.com>
 <Zy0WBH45qgzIZrke@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zy0WBH45qgzIZrke@google.com>

On Thu, Nov 07, 2024 at 07:33:24PM +0000, Carlos Llamas wrote:
> On Thu, Nov 07, 2024 at 10:52:30AM -0800, Suren Baghdasaryan wrote:
> > On Thu, Nov 7, 2024 at 10:27 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Thu, Nov 7, 2024 at 10:19 AM Carlos Llamas <cmllamas@google.com> wrote:
> > > >
> > > > On Thu, Nov 07, 2024 at 10:04:23AM -0800, Suren Baghdasaryan wrote:
> > > > > On Thu, Nov 7, 2024 at 9:55 AM Carlos Llamas <cmllamas@google.com> wrote:
> > > > > > On Thu, Nov 07, 2024 at 08:16:39AM -0800, Suren Baghdasaryan wrote:
> > > > > > > On Wed, Nov 6, 2024 at 8:03 PM Carlos Llamas <cmllamas@google.com> wrote:
> > > > > > > > +static int binder_page_insert(struct binder_alloc *alloc,
> > > > > > > > +                             unsigned long addr,
> > > > > > > > +                             struct page *page)
> > > > > > > > +{
> > > > > > > > +       struct mm_struct *mm = alloc->mm;
> > > > > > > > +       struct vm_area_struct *vma;
> > > > > > > > +       int ret = -ESRCH;
> > > > > > > > +
> > > > > > > > +       if (!mmget_not_zero(mm))
> > > > > > > > +               return -ESRCH;
> > > > > > > > +
> > > > > > > > +       /* attempt per-vma lock first */
> > > > > > > > +       vma = lock_vma_under_rcu(mm, addr);
> > > > > > > > +       if (!vma)
> > > > > > > > +               goto lock_mmap;
> > > > > > > > +
> > > > > > > > +       if (binder_alloc_is_mapped(alloc))
> > > > > > >
> > > > > > > I don't think you need this check here. lock_vma_under_rcu() ensures
> > > > > > > that the VMA was not detached from the tree after locking the VMA, so
> > > > > > > if you got a VMA it's in the tree and it can't be removed (because
> > > > > > > it's locked). remove_vma()->vma_close()->vma->vm_ops->close() is
> > > > > > > called after VMA gets detached from the tree and that won't happen
> > > > > > > while VMA is locked. So, if lock_vma_under_rcu() returns a VMA,
> > > > > > > binder_alloc_is_mapped() has to always return true. A WARN_ON() check
> > > > > > > here to ensure that might be a better option.
> > > > > >
> > > > > > Yes we are guaranteed to have _a_ non-isolated vma. However, the check
> > > > > > validates that it's the _expected_ vma. IIUC, our vma could have been
> > > > > > unmapped (clearing alloc->mapped) and a _new_ unrelated vma could have
> > > > > > gotten the same address space assigned?
> > > > >
> > > > > No, this should never happen. lock_vma_under_rcu() specifically checks
> > > > > the address range *after* it locks the VMA:
> > > > > https://elixir.bootlin.com/linux/v6.11.6/source/mm/memory.c#L6026
> > > >
> > > > The scenario I'm describing is the following:
> > > >
> > > > Proc A                          Proc B
> > > >                                 mmap(addr, binder_fd)
> > > > binder_page_insert()
> > > > mmget_not_zero()
> > > >                                 munmap(addr)
> > > >                                 alloc->mapped = false;
> > > >                                 [...]
> > > >                                 // mmap other vma but same addr
> > > >                                 mmap(addr, other_fd)
> > > >
> > > > vma = lock_vma_under_rcu()
> > > >
> > > > Isn't there a chance for the vma that Proc A receives is an unrelated
> > > > vma that was placed in the same address range?
> > >
> > > Ah, I see now. The VMA is a valid one and at the address we specified
> > > but it does not belong to the binder. Yes, then you do need this
> > > check.
> > 
> > Is this scenario possible?:
> > 
> >  Proc A                          Proc B
> >                                  mmap(addr, binder_fd)
> >  binder_page_insert()
> >  mmget_not_zero()
> >                                  munmap(addr)
> >                                  alloc->mapped = false;
> >                                  [...]
> >                                  // mmap other vma but same addr
> >                                  mmap(addr, other_fd)
> >                                  mmap(other_addr, binder_fd)
> >  vma = lock_vma_under_rcu(addr)
> > 
> > If so, I think your binder_alloc_is_mapped() check will return true
> > but the binder area is mapped at a different other_addr. To avoid that
> > I think you can check that "addr" still belongs to [alloc->vm_start,
> > alloc->buffer_size] after you obtained and locked the VMA.
> 
> Wait, I thought that vm_ops->close() was called with the mmap_lock in
> exclusive mode. This is where binder clears the alloc->mapped. If this
> is not the case (was it ever?), then I'd definitely need to fix this.

On a second though, we don't need the mmap_sem in exclusive mode. When
we acquire the vma through lock_vma_under_rcu() we guarantee it's not
isolated and if our alloc->mapped is set, that means it has not been
unmapped either. So we are good to proceed.

--
Carlos Llamas

