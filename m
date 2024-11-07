Return-Path: <linux-kernel+bounces-400544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DCA9C0F03
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82EB1F224F7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDAF198840;
	Thu,  7 Nov 2024 19:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eF1s9YsV"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B93194AD6
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008010; cv=none; b=dVah9r5XqU+uQT9RwU+qAivwCGn8Bt+7Xu+ejeloWKVND08aQ6bBZC9BMx/YPX9um2IBsfPWWa2a5+eS6Xr1eUjMJ4WNBRWsMaN/I2CAZZrKPGfN94MtoDcqBhbiLbMxTe8Qxnl07Xn8k2O2b4Lobdezk2x4YJQyuHW9g9uwgXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008010; c=relaxed/simple;
	bh=lUIOpA1UspKpNJlPQt8Dv4F3PTGWRoRG0HjQIgfm2NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFNpTlh7WoShZ+RaAppWaqqcCkckbL8t1UvjYboxg3gHmDJDxiA9RrJnd+4CJu3rAU9MNwbmXZgAU6fPI4y5xz6WZ1qzXOTgcs+tJFVll7/BYplpizdNNHh1pCczLRoitJecB+HuRm0Q7dCMSmzeb2KSuFWP2rYteVrT8XzV2TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eF1s9YsV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c8ac50b79so24565ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 11:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731008008; x=1731612808; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7C0ZaLyEOUDK55dm5LD1obwWrZuros8rIMUX6jIuwVM=;
        b=eF1s9YsVdklEzp7OkrNvRz3a4ol108wjoS2+WwS0JdYI1hxfdilTgp5kJ6Rtmoq8In
         I99wjaa+naD5fQdb+e/MZdY2CrsBq3PS6JOVdBQpYlaMoWHjZP9LtOvfRzh5RoJUS2n6
         mQ19poaWIweG54QRlWBg/8LoCtiudnQq6M0wiRl3ih5jYMcP0LBPf48R7ANvgB+zvEFQ
         bB4CnoyVBuNeP0EO7+NbcPAoniTpLIs3dr2/fouZjPRGNR0CBc2IYhzQoKGvWpeHjp8y
         VQQq4l14fQudOX6XKZM9RXoCOlGdRRt49zTro7b7wevPSnu2T8nEl+WC/LEG67Am9d2+
         bLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731008008; x=1731612808;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7C0ZaLyEOUDK55dm5LD1obwWrZuros8rIMUX6jIuwVM=;
        b=PENyuh3nWdCvwteQQow3SWdI54WUdgPY94kegYCefkI7Cadws6+Kv7UuIP+xjjMuaT
         hv89mjku8EPoorfQ8/sZgwkNuNz7ZiLG38UKJGA0ZeJPCNbBREaR07rwMIvYRiWFoAfR
         pz9T1WFRi2aFfTmRp3AKuHq7Fz8Yz9gxNA0vF9IABecgGVcbD+ku78fFt4m5/5L12MrZ
         wjsVKe7XXIQP0uusAr6E9/Pt8XIxZ1Q87kZZIyprtYBN9GTiJ7QoQJbp1+y4cnT8me3Y
         yLEzPaAbxpQqd23syi5mIwx21QodQZBVXnvc107lmdq15PYuuPCMNrZ4d25IFz5gT6TS
         5iLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgJ6IlSLyFZkPX7udo1lSftkEBoglpzv+EGiwfStUwRkXCLvR44VVIcc9+JVKKgf03aYdBRisvB/n3HaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFWck03xlt8mL8EsXEbvZwoVjRWS2ZeQVfNx0cyb8p0UZRtoJn
	y6vlJ8HkZKQNjmRhAenD9IcwyTgZmggQg1IP3xAWqI9yagQI7L/xLIiUioGXJg==
X-Gm-Gg: ASbGncvwVZ6zwyK+KThiNpYIh0jFQCkhZSbeTf9XC43wODG/b9MPxOwAZIOvZotpMr4
	JlRpdVNufhgI20uUpUMx0RSeLUohcm1XAGleUwSPOU1buXqWRHEvTbMdXcl5K2Mm/+tZelkvhOu
	JJcilkP0qSfIbUXgTIlO6jPpNXCfQhqA9w+Dur3+XCTodEyqq7mcrCuoBtZ4RY8MRzIwTwdkQ0s
	rxpFZ2yWypu+tgNTaDnaVookyGpzDRqoD1G14FIltrEME19pZRyTgHfRT+28NEVQpu5OOJLCC9/
	3tezG5N2HB8PimU=
X-Google-Smtp-Source: AGHT+IEfw9oIdfPaNEHDXHgNy/QltlxiHXYug/9KHfmYigTLOe1dDJLzhr52/5taEAwGerCMXPFTsg==
X-Received: by 2002:a17:902:f685:b0:20c:e262:2570 with SMTP id d9443c01a7336-21174933e90mr4272555ad.8.1731008008204;
        Thu, 07 Nov 2024 11:33:28 -0800 (PST)
Received: from google.com (180.145.227.35.bc.googleusercontent.com. [35.227.145.180])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f5e7a70sm1831605a12.43.2024.11.07.11.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 11:33:27 -0800 (PST)
Date: Thu, 7 Nov 2024 19:33:24 +0000
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
Message-ID: <Zy0WBH45qgzIZrke@google.com>
References: <20241107040239.2847143-1-cmllamas@google.com>
 <20241107040239.2847143-9-cmllamas@google.com>
 <CAJuCfpHM8J0S4dXhxmVuFSTUV0czg1CTFpf_C=k7M57T9qh-VQ@mail.gmail.com>
 <Zyz--bjvkVXngc5U@google.com>
 <CAJuCfpHAsgDgqjWmxqwGPxs_i184mrzMSAUZ9fj9PN8eJcGdvQ@mail.gmail.com>
 <Zy0EyMVq0xEdyKNt@google.com>
 <CAJuCfpF2ZyEPfV_rTsftnc=XKCiwGG2-mL67Bt6o3tEBWn+KwQ@mail.gmail.com>
 <CAJuCfpF7Q-uD+Tdyoar_djw+LwckgAbH1uZOABqoRe2=gpGN-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpF7Q-uD+Tdyoar_djw+LwckgAbH1uZOABqoRe2=gpGN-Q@mail.gmail.com>

On Thu, Nov 07, 2024 at 10:52:30AM -0800, Suren Baghdasaryan wrote:
> On Thu, Nov 7, 2024 at 10:27 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Thu, Nov 7, 2024 at 10:19 AM Carlos Llamas <cmllamas@google.com> wrote:
> > >
> > > On Thu, Nov 07, 2024 at 10:04:23AM -0800, Suren Baghdasaryan wrote:
> > > > On Thu, Nov 7, 2024 at 9:55 AM Carlos Llamas <cmllamas@google.com> wrote:
> > > > > On Thu, Nov 07, 2024 at 08:16:39AM -0800, Suren Baghdasaryan wrote:
> > > > > > On Wed, Nov 6, 2024 at 8:03 PM Carlos Llamas <cmllamas@google.com> wrote:
> > > > > > > +static int binder_page_insert(struct binder_alloc *alloc,
> > > > > > > +                             unsigned long addr,
> > > > > > > +                             struct page *page)
> > > > > > > +{
> > > > > > > +       struct mm_struct *mm = alloc->mm;
> > > > > > > +       struct vm_area_struct *vma;
> > > > > > > +       int ret = -ESRCH;
> > > > > > > +
> > > > > > > +       if (!mmget_not_zero(mm))
> > > > > > > +               return -ESRCH;
> > > > > > > +
> > > > > > > +       /* attempt per-vma lock first */
> > > > > > > +       vma = lock_vma_under_rcu(mm, addr);
> > > > > > > +       if (!vma)
> > > > > > > +               goto lock_mmap;
> > > > > > > +
> > > > > > > +       if (binder_alloc_is_mapped(alloc))
> > > > > >
> > > > > > I don't think you need this check here. lock_vma_under_rcu() ensures
> > > > > > that the VMA was not detached from the tree after locking the VMA, so
> > > > > > if you got a VMA it's in the tree and it can't be removed (because
> > > > > > it's locked). remove_vma()->vma_close()->vma->vm_ops->close() is
> > > > > > called after VMA gets detached from the tree and that won't happen
> > > > > > while VMA is locked. So, if lock_vma_under_rcu() returns a VMA,
> > > > > > binder_alloc_is_mapped() has to always return true. A WARN_ON() check
> > > > > > here to ensure that might be a better option.
> > > > >
> > > > > Yes we are guaranteed to have _a_ non-isolated vma. However, the check
> > > > > validates that it's the _expected_ vma. IIUC, our vma could have been
> > > > > unmapped (clearing alloc->mapped) and a _new_ unrelated vma could have
> > > > > gotten the same address space assigned?
> > > >
> > > > No, this should never happen. lock_vma_under_rcu() specifically checks
> > > > the address range *after* it locks the VMA:
> > > > https://elixir.bootlin.com/linux/v6.11.6/source/mm/memory.c#L6026
> > >
> > > The scenario I'm describing is the following:
> > >
> > > Proc A                          Proc B
> > >                                 mmap(addr, binder_fd)
> > > binder_page_insert()
> > > mmget_not_zero()
> > >                                 munmap(addr)
> > >                                 alloc->mapped = false;
> > >                                 [...]
> > >                                 // mmap other vma but same addr
> > >                                 mmap(addr, other_fd)
> > >
> > > vma = lock_vma_under_rcu()
> > >
> > > Isn't there a chance for the vma that Proc A receives is an unrelated
> > > vma that was placed in the same address range?
> >
> > Ah, I see now. The VMA is a valid one and at the address we specified
> > but it does not belong to the binder. Yes, then you do need this
> > check.
> 
> Is this scenario possible?:
> 
>  Proc A                          Proc B
>                                  mmap(addr, binder_fd)
>  binder_page_insert()
>  mmget_not_zero()
>                                  munmap(addr)
>                                  alloc->mapped = false;
>                                  [...]
>                                  // mmap other vma but same addr
>                                  mmap(addr, other_fd)
>                                  mmap(other_addr, binder_fd)
>  vma = lock_vma_under_rcu(addr)
> 
> If so, I think your binder_alloc_is_mapped() check will return true
> but the binder area is mapped at a different other_addr. To avoid that
> I think you can check that "addr" still belongs to [alloc->vm_start,
> alloc->buffer_size] after you obtained and locked the VMA.

Wait, I thought that vm_ops->close() was called with the mmap_lock in
exclusive mode. This is where binder clears the alloc->mapped. If this
is not the case (was it ever?), then I'd definitely need to fix this.

I'll have a closer look.

Thanks,
Carlos Llamas

