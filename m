Return-Path: <linux-kernel+bounces-407114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F5E9C690B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52BF2B23DDC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9135D17DE15;
	Wed, 13 Nov 2024 06:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yRoyaR0M"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C2F17C7D4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731477853; cv=none; b=U0p5OjSsw4L4r9KnpNPZQvamde4D3XSd/2OyjUODpACYeR1LbC0K0E37QSPPI9+iYfB5rooomz0k3YfNu90vVbo+syxIY+lYrZi0+M5bgcOXs6FX3tPsl4Ywf4ZbahhuoTg2iX/UnVNx1z6Fd/6bKyxRzdWQ8QDSYLhWHTruxL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731477853; c=relaxed/simple;
	bh=tkTrcrgQGR2r3+1USAH6qNDDRRqy2ByWWf6VKThfFFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0KvMsWb0NdJ4Q5rh1zm/UyfQ5m5t556BzlzJWAClSDGj+bph65YCdppqr9HdLt7hjTbkYlULeD7xmdmkfGQOEfZ4ObScVcGZGfhQCc+ajigq7/CFfueGIEAZuKkLrqUcIUlYtFVMjDZ5iGnvPbYzLPU3shT8afgOowj13IB9tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yRoyaR0M; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-460a8d1a9b7so118321cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 22:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731477850; x=1732082650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkTrcrgQGR2r3+1USAH6qNDDRRqy2ByWWf6VKThfFFY=;
        b=yRoyaR0MhhtLEnGJS37DtP7mKmNMnKKwezC8JUhdbm0hATFdKSgNAF0XobvrCNSfci
         DF7syZjevrOfdtXPP4Rxu41XSa6vWjrpEg2Q4jXpXkOzDvQWzETktC5PoxMDzKc2F3EY
         fy7rjsvljDCcC6IWhIY0+iQUWchOFEYeiTRvCVHBzvUW8u2Ad8iIA+LHwA29ZHJxgIDj
         zVyfaAj2DOA4MnkC8F+UhUfhl8xv1wCJ8nTpkx2dmemZOue0yYDfjHx3r+ZFLKhrd7IW
         K2JoJUzTkJYZ1AAR9smAl/ma9Edr7hK3GF291eHfULwwSgaERpvgGZVXgJs5Y2zJjT/0
         OERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731477850; x=1732082650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkTrcrgQGR2r3+1USAH6qNDDRRqy2ByWWf6VKThfFFY=;
        b=dz/8rXKFX8GaZtdPRkt3SNUYw/ExNX7TEnbBk2I6pUO5copHuIcVcLlDHSjizBchHh
         DWGiEj4XStcNBwVNFl4sP3sc+xhZCml1fMR4jKXJkIHNDL8QIRTJBmIwgbjY1bT3pkSW
         lJYDEgKPOBwCQXU8bNS+wqkp/8Gcm2JYpGYcgTnqWkC8yLCXOvBv6nw78ruaudUKbCTT
         cD3Y8gI/63BD7n4PuPg5MwciUnU8vhlaFQhcIiUukCY9cgTjLGujvuRqgtJ0zTurrKzJ
         Ux3fjtb7W7QEXu+yA1/vyW6PBjSXTK4zjR5fl8qCAlZ5za5mNR7T5HX2ZhiUPBKgbyQo
         vtYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd1Yimije95L/XmyAJOqfXyDG+hKMsHQ+eRWhVfwsRb1GC4RYnL4kTOdWX5xcHgca9/IPqRpQUD6z9fwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/6G82rHkI3oayqrjbhrBrHmZXscwyQqwiTXCbahc/yVRA6A6S
	G4rOBEAHpJse/wmEKAuxruQfigVrI8sbyn2pGmjfeZw5dF650svwu7EF7EB6oJhLd4pbWrfvw9F
	Cvm16INhxxjW3vtKjiP+d8db/rTFedvyF90Od
X-Gm-Gg: ASbGncuNgMrSWf3j6nVLX1BGg1Ln4o9oVXGRXGLhEINXe2m0AYd7Y3Ed/6rIQuh1jTC
	jm7YpUVuss7G8bSMWUp4ZaVqUiOgJ/2Q=
X-Google-Smtp-Source: AGHT+IHKadlPmr+WXI5vY40br0m0Jt+QE2K6y2TCMnr8S1pAbzEcnz6vIgPjIxOgjAUHu8gesnDyQ/X4px+cah5Jxeg=
X-Received: by 2002:a05:622a:144b:b0:462:b6c6:8246 with SMTP id
 d75a77b69052e-4634bc104c6mr2313241cf.14.1731477850037; Tue, 12 Nov 2024
 22:04:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112194635.444146-1-surenb@google.com> <20241112194635.444146-5-surenb@google.com>
 <CAJuCfpFd2_7q6pi1=G9B0VW5ynCWhkkDDA3PU293FPtT_CcBQA@mail.gmail.com> <6d0c5c2d-2963-489a-2376-8edaeb064de3@google.com>
In-Reply-To: <6d0c5c2d-2963-489a-2376-8edaeb064de3@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 12 Nov 2024 22:03:58 -0800
Message-ID: <CAJuCfpEG7hhh+mHbZe_9duk2kbFvv_NeGfBqw0JBxiHK-9yWxQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm: make vma cache SLAB_TYPESAFE_BY_RCU
To: Hugh Dickins <hughd@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 9:08=E2=80=AFPM Hugh Dickins <hughd@google.com> wro=
te:
>
> On Tue, 12 Nov 2024, Suren Baghdasaryan wrote:
> >
> > Thinking about this some more, I don't think this works. I'm relying
> > on vma_start_read() to stabilize the vma, however the lock I'm taking
> > is part of the vma which can be reused from under us. So, the lock I'm
> > taking might be reinitialized after I take the lock...
> > I need to figure out a way to stabilize the vma in some other manner
> > before taking this lock.
>
> (I'm not paying attention and following the patches, I just happened
> to notice this remark: forgive me if I'm out of context and have
> misunderstood, but hope this might help:)
>
> But this is exactly the problem SLAB_TYPESAFE_BY_RCU was invented for.
> You just have to be careful that the locks are initialized only when the
> slab is first created (allocated from buddy), not reinitialized whenever
> a new object is allocated from that slab.

Hi Hugh!
I'm looking into SLAB_TYPESAFE_BY_RCU implementation and trying to
figure out if initializing the lock in the ctor() of the cache as
mentioned in the comment here:
https://elixir.bootlin.com/linux/v6.12-rc7/source/include/linux/slab.h#L127
would help my case. I assume that's what you are hinting here?

>
> Hugh

