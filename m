Return-Path: <linux-kernel+bounces-278906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF8594B658
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5A41F24A90
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 05:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AA5183CB3;
	Thu,  8 Aug 2024 05:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VsMX9Ee4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF6D183088
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 05:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723096219; cv=none; b=pxLD/zNtSQ9s0XrTpLPlr8O3KpvAiH7iZtjwqnpHGgG7d7ZoaU2jjt7SY0CmVSfvMrFmUWMpcDCmrUDVu3TQh05iMEqpLxo738PnSnSaL3wobV4+u3zTfLpUaQFRt9sxEVpTWaSA8OdhDIfzaEA2tHmeqPomSGVme/3XZNHudlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723096219; c=relaxed/simple;
	bh=Pg9Pklu5VzsvFghGCLFVT2C0BydEWsW2uYBy6aHw3OQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJ+5TuKL3QJC9lZBZsg4aLY7Z1wQPbPJ8TJcOheXzj4G9C6VWyhcE69Xy1OckqNNebpMx03AIwctUJFJv7d+LpvsB0eCxh1oYnzbF5fHON3FEc0JdnVC7xbX5g54u+cbtkmyxYZrXG2PDO59vTByFT1EkD0z3YE/Q1u4J5IHeDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VsMX9Ee4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723096216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pg9Pklu5VzsvFghGCLFVT2C0BydEWsW2uYBy6aHw3OQ=;
	b=VsMX9Ee4r2tH//O789ykCwU/PpjcC1NIhE+PUPqC9ylt5r6T+11D4RYKOleu26uAAbqGSw
	sGnegcwBhCgfdEyuhdOquH7K9cyZhNoFgAMhTPUkR1Qrffs1Mp9FZU/qwCVRoVKift59Wf
	ll23H2q5ZcK91cIyT6EavcTb9WB8qv4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-6xtc4g9KPCqGsese8qUOaQ-1; Thu, 08 Aug 2024 01:50:14 -0400
X-MC-Unique: 6xtc4g9KPCqGsese8qUOaQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2cb600e1169so787450a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 22:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723096213; x=1723701013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pg9Pklu5VzsvFghGCLFVT2C0BydEWsW2uYBy6aHw3OQ=;
        b=OlN71NcG0NU1U9eNB6V4fgBOK4v69mIo6TkszybvTgVDJ7q2kw+G+VFPJJjzQKkscX
         OPK3b5euej18GXxC+2hNkZsW+6eEbO6+cKPvIgF1VCDmS8YmJOOK9hihnaA36RmP16BZ
         lHvmNG/htipgGAqBBbnclqcN5VYoOEXYbNO51Poc9dbygmF9Y5pNudNehzv+tTHwt0ro
         D8l45z2wBD/r/eA0VMsd6MeDh0BreV1nd+C52MPopfKd0BnhbXpNReICWKR8N/6qo3xT
         pCZUTeYkVAJdSUmoDsZYKNBZ/UxECnJO9YAiP5G4tI42tj8uusPrGp/1cd7ootDaPJaJ
         l+1g==
X-Forwarded-Encrypted: i=1; AJvYcCX197V3P7PXsKZr1Jk4OGqaAJXC5Ak3bPV7RuThyi06f7+ehUj5NZYinfSbwfwCnIysd442YD5ZFVH64eItRICCq3vAoixqaoJ+la7f
X-Gm-Message-State: AOJu0Ywz40fBxsBpI7T62BYYufQHE4EKW+Ioy7vNGB4008Qjiw/BMjXd
	ZXtK1NPuj33v6ALuDXjcBVIefDAH5WM8XZKb8V7OGg8u623I1BooEc4BVKIktklzoSdxlMft3Tu
	cCFcLGO6AHKffhEHiPen9RJ5kcjbtrr0MBeDjOe0CHLTxOclYF8iazdzGEenM914H5hh5hdHFx3
	ItJ6hWg13peeYeAnQP3yr9+hpABchDY9t53j5m
X-Received: by 2002:a17:90b:3b4f:b0:2c8:da73:af7d with SMTP id 98e67ed59e1d1-2d1c33713demr987723a91.3.1723096213391;
        Wed, 07 Aug 2024 22:50:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsgNo9KC+RiGUCac0XYO0CORLUxqP0wo89LUOw0I10wxw1/gr6Lvm0darkYBW3yVmLkkRspEACB2XpF9vmrCg=
X-Received: by 2002:a17:90b:3b4f:b0:2c8:da73:af7d with SMTP id
 98e67ed59e1d1-2d1c33713demr987704a91.3.1723096212807; Wed, 07 Aug 2024
 22:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com> <CACGkMEvNyB_+fHV5aAeCQhebA8aF8+9hnjkjeEzt5bgrVgqw5Q@mail.gmail.com>
 <CACycT3sz-OOKKcmH=FgD7gp_Bhi9=nwnkTn0VgRhQBxS2Dp4qw@mail.gmail.com>
 <CACGkMEs4YWr5zu0_nVCvqLSFBG9U_A_mw+7AdkMwrPo_6X-gOA@mail.gmail.com>
 <CACycT3vYF3nwZ3k5_8G=Zok9c4qRjCcGLVQ7+RfSpK=5PToMuA@mail.gmail.com>
 <CACGkMEue9RU+MMgOC0t4Yuk5wRHfTdnJeZZs38g2h+gyZv+3VQ@mail.gmail.com>
 <CACycT3sHT-izwAKzxAWPbqGFgyf82WxkHHOrp1SjWa+HE01mCg@mail.gmail.com>
 <CACGkMEvsMQS-5Oy7rTyA5a2u1xYRf0beBHbZ16geHJCZTE0jLw@mail.gmail.com> <CACycT3sfUhz1PjK3Q=pA7GEm7=fsL0XT16ccwCQ2m2LF+TTD7Q@mail.gmail.com>
In-Reply-To: <CACycT3sfUhz1PjK3Q=pA7GEm7=fsL0XT16ccwCQ2m2LF+TTD7Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 8 Aug 2024 13:50:01 +0800
Message-ID: <CACGkMEu+RrD2JdO=F9BySwhVY5uPr6kKWWdkcdG4XX6GN5b=Bg@mail.gmail.com>
Subject: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Yongji Xie <xieyongji@bytedance.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel <linux-kernel@vger.kernel.org>, 21cnbao@gmail.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 2:54=E2=80=AFPM Yongji Xie <xieyongji@bytedance.com>=
 wrote:
>
> On Wed, Aug 7, 2024 at 12:38=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Aug 7, 2024 at 11:13=E2=80=AFAM Yongji Xie <xieyongji@bytedance=
.com> wrote:
> > >
> > > On Wed, Aug 7, 2024 at 10:39=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Tue, Aug 6, 2024 at 11:10=E2=80=AFAM Yongji Xie <xieyongji@byted=
ance.com> wrote:
> > > > >
> > > > > On Tue, Aug 6, 2024 at 10:28=E2=80=AFAM Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > >
> > > > > > On Mon, Aug 5, 2024 at 6:42=E2=80=AFPM Yongji Xie <xieyongji@by=
tedance.com> wrote:
> > > > > > >
> > > > > > > On Mon, Aug 5, 2024 at 4:24=E2=80=AFPM Jason Wang <jasowang@r=
edhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang=
@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > Barry said [1]:
> > > > > > > > >
> > > > > > > > > """
> > > > > > > > > mm doesn't support non-blockable __GFP_NOFAIL allocation.=
 Because
> > > > > > > > > __GFP_NOFAIL without direct reclamation may just result i=
n a busy
> > > > > > > > > loop within non-sleepable contexts.
> > > > > > > > > ""=E2=80=9C
> > > > > > > > >
> > > > > > > > > Unfortuantely, we do that under read lock. A possible way=
 to fix that
> > > > > > > > > is to move the pages allocation out of the lock into the =
caller, but
> > > > > > > > > having to allocate a huge number of pages and auxiliary p=
age array
> > > > > > > > > seems to be problematic as well per Tetsuon [2]:
> > > > > > > > >
> > > > > > > > > """
> > > > > > > > > You should implement proper error handling instead of usi=
ng
> > > > > > > > > __GFP_NOFAIL if count can become large.
> > > > > > > > > """
> > > > > > > > >
> > > > > > >
> > > > > > > I think the problem is it's hard to do the error handling in
> > > > > > > fops->release() currently.
> > > > > >
> > > > > > vduse_dev_dereg_umem() should be the same, it's very hard to al=
low it to fail.
> > > > > >
> > > > > > >
> > > > > > > So can we temporarily hold the user page refcount, and releas=
e it when
> > > > > > > vduse_dev_open()/vduse_domain_release() is executed. The kern=
el page
> > > > > > > allocation and memcpy can be done in vduse_dev_open() which a=
llows
> > > > > > > some error handling.
> > > > > >
> > > > > > Just to make sure I understand this, the free is probably not t=
he big
> > > > > > issue but the allocation itself.
> > > > > >
> > > > >
> > > > > Yes, so defer the allocation might be a solution.
> > > >
> > > > Would you mind posting a patch for this?
> > > >
> > > > >
> > > > > > And if we do the memcpy() in open(), it seems to be a subtle us=
erspace
> > > > > > noticeable change? (Or I don't get how copying in vduse_dev_ope=
n() can
> > > > > > help here).
> > > > > >
> > > > >
> > > > > Maybe we don't need to do the copy in open(). We can hold the use=
r
> > > > > page refcount until the inflight I/O is completed. That means the
> > > > > allocation of new kernel pages can be done in
> > > > > vduse_domain_map_bounce_page() and the release of old user pages =
can
> > > > > be done in vduse_domain_unmap_bounce_page().
> > > >
> > > > This seems to be a subtle userspace noticeable behaviour?
> > > >
> > >
> > > Yes, userspace needs to ensure that it does not reuse the old user
> > > pages for other purposes before vduse_dev_dereg_umem() returns
> > > successfully. The vduse_dev_dereg_umem() will only return successfull=
y
> > > when there is no inflight I/O which means we don't need to allocate
> > > extra kernel pages to store data. If we can't accept this, then your
> > > current patch might be the most suitable.
> >
> > It might be better to not break.
> >
> > Actually during my testing, the read_lock in the do_bounce path slows
> > down the performance. Remove read_lock or use rcu_read_lock() to give
> > 20% improvement of PPS.
> >
>
> Looks like rcu_read_lock() should be OK here.

The tricky part is that we may still end up behaviour changes (or lose
some of the synchronization between kernel and bounce pages):

RCU allows the read to be executed in parallel with the writer. So
bouncing could be done in parallel with
vduse_domain_add_user_bounce_pages(), there would be a race in two
memcpy.

Thanks

>
> Thanks,
> Yongji
>


