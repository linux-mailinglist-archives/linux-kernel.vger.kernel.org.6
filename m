Return-Path: <linux-kernel+bounces-400450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 718339C0DAD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8D01C22BF6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97AF215033;
	Thu,  7 Nov 2024 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1/WxCxNi"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAEF17C96
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731003598; cv=none; b=qd3mSt9AOupja0iQFOkk3L2+nHT+R00vDDWLBAvrhIu/gGGbYkZj4QghgyK1yIjs9PAwhiUhr6lQq5y8lAnoIDpS3+eeZ+ZoU+7xavFczwXd0oS1+tOLs4WUilpxC/v9XpbQ0bQReyz3OqZjVUFKVWHAV/csKN01yCGtscESHhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731003598; c=relaxed/simple;
	bh=ppJEcMrCmJjS+8+ozqVcFOZV5x/nRlliY4El7V2p3WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZIrwuEO246ZVHLadOQVAcTS8o4YEsXkFcKRZGm24xkS/Ja898mCqG+osN2Xis9ZYz9vD0nZYCSURW9EFLQj27IsMosN43BASyfrl6WqZhm7E1QWQk5b9dm7FUQncKGDZM2PlQVV5o6neKOX6APnlEVDTSwhjLY6AF3sQYYSduI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1/WxCxNi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20ca4877690so8145ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 10:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731003596; x=1731608396; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B/nvikkDHyHRq4rl0vvmKSqUlcdZfn6V+3QzWHiFBR8=;
        b=1/WxCxNi6coZzbSz+k1jszWEommzU3RLa4eqcGhZ7PI8ozzKDISb5xyjtF5AUY8I6N
         yl2gsHL6c63iA8jMj7S1byTIX6bPBaUcEOcuTGMxF6RLnxpTL/iknrIJLC6m8H4LGgOU
         0TR6oxO274s6hK42GpJWlhj6pu71aywB72RW6ShFqW5kMnpGv1R5D8HypMMgs2G0f4Of
         wLQDFlGe3UoKQfnmXODZ/8IIBuFAp1yq6In13p9USxC78zphCu2XuhQ3DR3LJ0/GQI75
         tji9UIOwEet0X/iqSbCHEgeQ9H7lqtn5dfUfezLqy71kjFWXQhdEnB+KLRYiJRi9s+JT
         waBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731003596; x=1731608396;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/nvikkDHyHRq4rl0vvmKSqUlcdZfn6V+3QzWHiFBR8=;
        b=msgzR60Z0x95o0iiky0gFiPMGoQSWIRS4q5+TMK/2H/hDbD4iUw5sz0DIrYdsUe4u4
         hWi6+Tn9Tq0/4J38yVzC6d8OAMA8v1VucLv1aY2pYbr/VIFt/2XPXR1OEERejfSLfezr
         vFlvzLWF8WelGblI59Lyw/tlsgj8DPPAlQsyJriOpDL/GAWziwnqUmFxup8G6/suDZ2r
         hdJZQ4b/GlwJTMkTDRys1LUXEI+UF5zGbH5yq0TfO5UF51jQuSjSLLcnKlgVW4ae55oK
         MT7XWkwH+txj7BD9nF416H8LX0+E9aLggZ4t2snLnaG8V+Nf82DNDU3X5zYlQGKqsEo8
         Q9Gg==
X-Forwarded-Encrypted: i=1; AJvYcCU1IWYILXd2Bzt8ZLZ6D7Ji/cppXRgpn3rmbGsatp27Ok+SHKKORgZ/YB68WdjzyW2HJpNKLE4i8WYn6YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO5R61X6eIl0svOJ0upwQuO4VH/ODog/p8Re5HaOrZ7xm/vzCP
	a+rvOA4cDAoiOwLcPHPlR7sPcAMo2xvFjtkfXiB7QhN2QNHLE0EdnbMssUjAkA==
X-Gm-Gg: ASbGncurvNxomNze8caiHqldQcLZC/2oAQu7oDETMVnkmLtwxUw6UX+LCjEDaaU8es1
	qfJI+0GFlaSXqnBsAEOBuxczSzhVuhNVVZbLfUOrwi+Buk6TfMIpdZXabIOOLGQT9BSBB13rm24
	LZoKYvu6qCZ03lp306fKsBdciMXFmtp/FWajxYMNH3b7wyTMEK910HBeHjKJARBNfwJ9gScw8+N
	BAvLQjOhFC3zExeipEDBoJ/vjM+r0acOhwzvuFTByGxCptrAwVrCDYapCIfVua0fva27ZJZ3CT8
	9L2GBgn8xS7PFDc=
X-Google-Smtp-Source: AGHT+IE4ouXeI6caG3ltrIwCjvOn/kZGnc1W0oPheErXK3+GihDhszcXHD6xguNqOzpNNiMEb4QzqQ==
X-Received: by 2002:a17:903:1c3:b0:20c:eb70:6a5b with SMTP id d9443c01a7336-21174986645mr3930375ad.14.1731003595939;
        Thu, 07 Nov 2024 10:19:55 -0800 (PST)
Received: from google.com (180.145.227.35.bc.googleusercontent.com. [35.227.145.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e85764sm14904345ad.275.2024.11.07.10.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 10:19:55 -0800 (PST)
Date: Thu, 7 Nov 2024 18:19:52 +0000
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
Message-ID: <Zy0EyMVq0xEdyKNt@google.com>
References: <20241107040239.2847143-1-cmllamas@google.com>
 <20241107040239.2847143-9-cmllamas@google.com>
 <CAJuCfpHM8J0S4dXhxmVuFSTUV0czg1CTFpf_C=k7M57T9qh-VQ@mail.gmail.com>
 <Zyz--bjvkVXngc5U@google.com>
 <CAJuCfpHAsgDgqjWmxqwGPxs_i184mrzMSAUZ9fj9PN8eJcGdvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHAsgDgqjWmxqwGPxs_i184mrzMSAUZ9fj9PN8eJcGdvQ@mail.gmail.com>

On Thu, Nov 07, 2024 at 10:04:23AM -0800, Suren Baghdasaryan wrote:
> On Thu, Nov 7, 2024 at 9:55 AM Carlos Llamas <cmllamas@google.com> wrote:
> > On Thu, Nov 07, 2024 at 08:16:39AM -0800, Suren Baghdasaryan wrote:
> > > On Wed, Nov 6, 2024 at 8:03 PM Carlos Llamas <cmllamas@google.com> wrote:
> > > > +static int binder_page_insert(struct binder_alloc *alloc,
> > > > +                             unsigned long addr,
> > > > +                             struct page *page)
> > > > +{
> > > > +       struct mm_struct *mm = alloc->mm;
> > > > +       struct vm_area_struct *vma;
> > > > +       int ret = -ESRCH;
> > > > +
> > > > +       if (!mmget_not_zero(mm))
> > > > +               return -ESRCH;
> > > > +
> > > > +       /* attempt per-vma lock first */
> > > > +       vma = lock_vma_under_rcu(mm, addr);
> > > > +       if (!vma)
> > > > +               goto lock_mmap;
> > > > +
> > > > +       if (binder_alloc_is_mapped(alloc))
> > >
> > > I don't think you need this check here. lock_vma_under_rcu() ensures
> > > that the VMA was not detached from the tree after locking the VMA, so
> > > if you got a VMA it's in the tree and it can't be removed (because
> > > it's locked). remove_vma()->vma_close()->vma->vm_ops->close() is
> > > called after VMA gets detached from the tree and that won't happen
> > > while VMA is locked. So, if lock_vma_under_rcu() returns a VMA,
> > > binder_alloc_is_mapped() has to always return true. A WARN_ON() check
> > > here to ensure that might be a better option.
> >
> > Yes we are guaranteed to have _a_ non-isolated vma. However, the check
> > validates that it's the _expected_ vma. IIUC, our vma could have been
> > unmapped (clearing alloc->mapped) and a _new_ unrelated vma could have
> > gotten the same address space assigned?
> 
> No, this should never happen. lock_vma_under_rcu() specifically checks
> the address range *after* it locks the VMA:
> https://elixir.bootlin.com/linux/v6.11.6/source/mm/memory.c#L6026

The scenario I'm describing is the following:

Proc A				Proc B
				mmap(addr, binder_fd)
binder_page_insert()
mmget_not_zero()
				munmap(addr)
				alloc->mapped = false;
				[...]
				// mmap other vma but same addr
				mmap(addr, other_fd)

vma = lock_vma_under_rcu()

Isn't there a chance for the vma that Proc A receives is an unrelated
vma that was placed in the same address range?

