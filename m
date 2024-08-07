Return-Path: <linux-kernel+bounces-277283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E184949EE1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 06:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26D828312A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 04:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A523191495;
	Wed,  7 Aug 2024 04:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMEZ00mq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0E415B561
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 04:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723005488; cv=none; b=HRJUACqKkLvANPEgEGxk1vJ1NbHQ7kGT2HaumI6Ll0SeTQqWy9TKxuwookOMJeM720WBO/qqowPotp+TVLajgQchNQnrCN8DqZ0n+PPsCzF0KWxLkXExvIBqBfTjV9zV8KPGhS+fgxPLgNcQ3L8nGdw73fwViy6dRtA62owjoDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723005488; c=relaxed/simple;
	bh=KTk7jZ7lYTXpfJXcUgVHfVoqgBIg4K0nO71lHrPFslQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWtcyfJRZE6lETVnBltA+eSsgro6AKUD52e1Wrq3odjnNkw30hTlAEaTdWzSw1rSpuuSieW973gD9ACUmOydV8qL459HMoHV3eKlkeZxCGCHIfGlbnF2VrfadpwUTNq/z/a56jnNf1L9ZjtMLrL9+RqI3QtgqwxCqUYB5k56e+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AMEZ00mq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723005485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTk7jZ7lYTXpfJXcUgVHfVoqgBIg4K0nO71lHrPFslQ=;
	b=AMEZ00mqvIQMe+eOPzdzc3C+6EKhFvhB8gDzsMo8ESqfJUCpHol0MDwDqkxm6pAIQKK/HI
	Wy31DKzDsRw1h0eCi0cFL0FrVTskAg4fxptZSq7C8eRFykyAfvSEaFPpYQ8VNP8gmRw2Tj
	3jV9HuiCFj7zYR6nDfftRRgcwFvaBmQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-xcC-uy6_MaSe4x9yJdBMEQ-1; Wed, 07 Aug 2024 00:38:03 -0400
X-MC-Unique: xcC-uy6_MaSe4x9yJdBMEQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cb6c5f9810so1701758a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 21:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723005483; x=1723610283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTk7jZ7lYTXpfJXcUgVHfVoqgBIg4K0nO71lHrPFslQ=;
        b=QeVjE7e1XpnuongIlWAfVugu9BOvl6BTb9ppAgz2WNTbSoSDRZJOZNdBH3O3n1m2v6
         CO9HrMmlDVujnx8PkRH/2rUCJMT9JVQkJkUNLvuDuhiAtx8cK87mEWrr3f24haHCINHM
         tauaXSSSpSZ2OMT2+YZUPxjdYL/TIDpf+TdumuGBHwe03xk/DWcbdFHoxDkhkU5ob0zg
         T6ClSXnUwV1UBVm5Gqnp5CrLU0pt6bAg6e/1KTN4TocmltNhwhqHb//id9EnIEEf3nyW
         nCEG/QOiQI1P7vpyInZUpr2WC5cc2Mmd1XYeYg/q4qALIQO6CTfQe/4Rihg2AxU9aQDM
         qqeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRYIPiRjLh2iG7LKqpOe3zW8yI34roWataIsFErbzDp+QEiEb1k0VhV2L9XZjOgkp4qb/9Z3OAAa+PONmTzi028ZKrmypbZLnZKdyZ
X-Gm-Message-State: AOJu0YxdLGadf1wmGqxovk4KRKokkumUxPtA2e0Jv1IOUvlnDcTaujPl
	mRFOjiav0VwewNOS9OBbNZPM53wIaRuN6Oz0nGztucUTohuHmqCVVeYNGbJoIKHhf2ZKKnbBcAd
	4V4MuR/7v/N4WlZ6AWTZyMAF81ZEBcE/2m+TL2EqmudOu2ualRoou8D2XnN+7nJa71+NdgKRYio
	B3VyTGB0K/sN03GAi0Q2pBX9hHIyWypec6sV6+
X-Received: by 2002:a17:90b:194c:b0:2c9:6f03:6fd6 with SMTP id 98e67ed59e1d1-2cff941b383mr16837661a91.17.1723005482661;
        Tue, 06 Aug 2024 21:38:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJWh0FV7XdQ58365EjWwj3Cvcl8CaSImWJu6gpWLZusJ2hCGX1Lyg8ktnpH9LNewdRCOQGEpYnQKc+Z6NQWBw=
X-Received: by 2002:a17:90b:194c:b0:2c9:6f03:6fd6 with SMTP id
 98e67ed59e1d1-2cff941b383mr16837642a91.17.1723005482207; Tue, 06 Aug 2024
 21:38:02 -0700 (PDT)
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
 <CACGkMEue9RU+MMgOC0t4Yuk5wRHfTdnJeZZs38g2h+gyZv+3VQ@mail.gmail.com> <CACycT3sHT-izwAKzxAWPbqGFgyf82WxkHHOrp1SjWa+HE01mCg@mail.gmail.com>
In-Reply-To: <CACycT3sHT-izwAKzxAWPbqGFgyf82WxkHHOrp1SjWa+HE01mCg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 7 Aug 2024 12:37:50 +0800
Message-ID: <CACGkMEvsMQS-5Oy7rTyA5a2u1xYRf0beBHbZ16geHJCZTE0jLw@mail.gmail.com>
Subject: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Yongji Xie <xieyongji@bytedance.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel <linux-kernel@vger.kernel.org>, 21cnbao@gmail.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 11:13=E2=80=AFAM Yongji Xie <xieyongji@bytedance.com=
> wrote:
>
> On Wed, Aug 7, 2024 at 10:39=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Tue, Aug 6, 2024 at 11:10=E2=80=AFAM Yongji Xie <xieyongji@bytedance=
.com> wrote:
> > >
> > > On Tue, Aug 6, 2024 at 10:28=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Mon, Aug 5, 2024 at 6:42=E2=80=AFPM Yongji Xie <xieyongji@byteda=
nce.com> wrote:
> > > > >
> > > > > On Mon, Aug 5, 2024 at 4:24=E2=80=AFPM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > > >
> > > > > > On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@red=
hat.com> wrote:
> > > > > > >
> > > > > > > Barry said [1]:
> > > > > > >
> > > > > > > """
> > > > > > > mm doesn't support non-blockable __GFP_NOFAIL allocation. Bec=
ause
> > > > > > > __GFP_NOFAIL without direct reclamation may just result in a =
busy
> > > > > > > loop within non-sleepable contexts.
> > > > > > > ""=E2=80=9C
> > > > > > >
> > > > > > > Unfortuantely, we do that under read lock. A possible way to =
fix that
> > > > > > > is to move the pages allocation out of the lock into the call=
er, but
> > > > > > > having to allocate a huge number of pages and auxiliary page =
array
> > > > > > > seems to be problematic as well per Tetsuon [2]:
> > > > > > >
> > > > > > > """
> > > > > > > You should implement proper error handling instead of using
> > > > > > > __GFP_NOFAIL if count can become large.
> > > > > > > """
> > > > > > >
> > > > >
> > > > > I think the problem is it's hard to do the error handling in
> > > > > fops->release() currently.
> > > >
> > > > vduse_dev_dereg_umem() should be the same, it's very hard to allow =
it to fail.
> > > >
> > > > >
> > > > > So can we temporarily hold the user page refcount, and release it=
 when
> > > > > vduse_dev_open()/vduse_domain_release() is executed. The kernel p=
age
> > > > > allocation and memcpy can be done in vduse_dev_open() which allow=
s
> > > > > some error handling.
> > > >
> > > > Just to make sure I understand this, the free is probably not the b=
ig
> > > > issue but the allocation itself.
> > > >
> > >
> > > Yes, so defer the allocation might be a solution.
> >
> > Would you mind posting a patch for this?
> >
> > >
> > > > And if we do the memcpy() in open(), it seems to be a subtle usersp=
ace
> > > > noticeable change? (Or I don't get how copying in vduse_dev_open() =
can
> > > > help here).
> > > >
> > >
> > > Maybe we don't need to do the copy in open(). We can hold the user
> > > page refcount until the inflight I/O is completed. That means the
> > > allocation of new kernel pages can be done in
> > > vduse_domain_map_bounce_page() and the release of old user pages can
> > > be done in vduse_domain_unmap_bounce_page().
> >
> > This seems to be a subtle userspace noticeable behaviour?
> >
>
> Yes, userspace needs to ensure that it does not reuse the old user
> pages for other purposes before vduse_dev_dereg_umem() returns
> successfully. The vduse_dev_dereg_umem() will only return successfully
> when there is no inflight I/O which means we don't need to allocate
> extra kernel pages to store data. If we can't accept this, then your
> current patch might be the most suitable.

It might be better to not break.

Actually during my testing, the read_lock in the do_bounce path slows
down the performance. Remove read_lock or use rcu_read_lock() to give
20% improvement of PPS.

I do want to get rid of it (e.g moving the copying some other where)
seems it meets the exact "issue" here which introduces some behaviour
change...

> I will test this patch
> first.
>

Great.

Thanks

> Thanks,
> Yongji
>


