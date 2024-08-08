Return-Path: <linux-kernel+bounces-279337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5417494BC02
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B917FB24D81
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3924518B47A;
	Thu,  8 Aug 2024 11:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XVN2urqM"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A7E18B469
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 11:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723115381; cv=none; b=hzpRF4zLcWUuqErssDPiwf4kq6TQxJLVVtLptNvAoC4WN0a4ielIiNm6LW2YdxIU1lEPRw3MXZZ5NPkkIftyFG5intqCItX1hbAboBrwNd4zxmHwixvcroaJ77W/xZV+WqtXoHzjN/sVtUl+LF36prBYyV2GP+w4U20wLDBzxEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723115381; c=relaxed/simple;
	bh=IqREpNz2czTLdFvatHVsNu8CiTFdhUryn9i0FvgsMqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8pmfpDMJ3tEfINbGHNPUHpPnJC6D6nuB3uaOxgXimrsrzwlh2qFiOHXIm5lxNhdyf/dmTJ/z9OIICitEj2TlwChki0bCAlUaAcuJNIc7jJH+w5kz+4DhUtUnLTxBn82XVyuRHXbq5kiKmTzuvIpHxT2h0f/jp1/F7sz8nU/HcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XVN2urqM; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cf98ba0559so665860a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 04:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723115379; x=1723720179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqREpNz2czTLdFvatHVsNu8CiTFdhUryn9i0FvgsMqU=;
        b=XVN2urqM/vESzPVyQYcyqCw6zupfXkM4bYVK7YV7fLr913xem+S5XgMUj6ydAX3eBe
         NlNi61YjOP+pfbFW0egIvH7Bs6120QJFXk4dyXnfHuZql+VBMX9UBFUACG0SbPrtQMh+
         tbh7WQpOZRAAXxtzUfB38wZk+5LrjKUvJnAGo/JoTaYV3HXVRwfLEV+6bD71MZd36F7k
         N6oKxE/WOtWE5XUdaFzWx+fLHOq4gkjlAHJbwCyt3pMGMybejdXwf1FowoUZhG8iVsrS
         tXE612PJH3bZd7YKCU5WZwliMHIVDpSZHRBJlRfWcmn8WNdQa6a9VkizcdwI8i1tqwVU
         Mpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723115379; x=1723720179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqREpNz2czTLdFvatHVsNu8CiTFdhUryn9i0FvgsMqU=;
        b=oDzJUSfI4By6XRAy0oOMzqSkXpOpM1D0muERWBLKVLOY5d4MpjcgoJjUkpp8sH4Vur
         xzd6K0rSXiyDyPZQm7sS6YiNs8Jmqut3RAOvDdAhJyVKzI5C3Bp5iVpzqWRX1HVEssmp
         B+Ze05oIEGsFHBNVnF+qnvZfJehvW3Ln+Qeco6nKIylQ0nu7l3ytH6oVWQeLUnTSgPBY
         snnUDFJ0nuplLnoMiTB2i3Z+8l2mui7EX5W2TZI9zxwlQcBAtshJrl3qbi+QXDAUGZqO
         SGLHTbBgbcEdSs+6lShHP2CEKIW5SjglzyKrSn8YS5TEMMN+MUPCNRU2gXspFonOZRrE
         CC7A==
X-Forwarded-Encrypted: i=1; AJvYcCVq1E8sVnhyYRiHCkAdKafycFr+izeEjFxl0w0jZUo0MGrR/r7AHq1M1l0a9wD/iuPncdVC+FCwBT/d6sU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx/hZBnVxB2zH63oFAZoMX1+QiHcz+j6gYrf5c5VS9G80o3ZYN
	3tkifbesW+hW5PMmYBkW+wZY2MQ/3/fzLZqfDiWoG3pBBM0A7QZdoViSPMfPTu4ChxWFgNR9A9O
	lno15D85vg55CzxRKnzJDEiO36J6TjgIjPDcv
X-Google-Smtp-Source: AGHT+IF1qBmPDPJg8OZVzV3ty1jXdjjg3Q9zRacN4Dxr2BvK/Rx+IyX9zIk1QFp239xb0EcMSZr9bHA2Raf4mQJz6hY=
X-Received: by 2002:a17:90a:ce02:b0:2c8:946f:5fe7 with SMTP id
 98e67ed59e1d1-2d1c33b63c1mr1551127a91.17.1723115378810; Thu, 08 Aug 2024
 04:09:38 -0700 (PDT)
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
 <CACGkMEvsMQS-5Oy7rTyA5a2u1xYRf0beBHbZ16geHJCZTE0jLw@mail.gmail.com>
 <CACycT3sfUhz1PjK3Q=pA7GEm7=fsL0XT16ccwCQ2m2LF+TTD7Q@mail.gmail.com> <CACGkMEu+RrD2JdO=F9BySwhVY5uPr6kKWWdkcdG4XX6GN5b=Bg@mail.gmail.com>
In-Reply-To: <CACGkMEu+RrD2JdO=F9BySwhVY5uPr6kKWWdkcdG4XX6GN5b=Bg@mail.gmail.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Thu, 8 Aug 2024 19:09:26 +0800
Message-ID: <CACycT3u-v+XkWzSPq39Mk9sdQftuNZvZqZyzDvhTecH3uyuk8w@mail.gmail.com>
Subject: Re: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Jason Wang <jasowang@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel <linux-kernel@vger.kernel.org>, 21cnbao@gmail.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 1:50=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Wed, Aug 7, 2024 at 2:54=E2=80=AFPM Yongji Xie <xieyongji@bytedance.co=
m> wrote:
> >
> > On Wed, Aug 7, 2024 at 12:38=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Wed, Aug 7, 2024 at 11:13=E2=80=AFAM Yongji Xie <xieyongji@bytedan=
ce.com> wrote:
> > > >
> > > > On Wed, Aug 7, 2024 at 10:39=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Tue, Aug 6, 2024 at 11:10=E2=80=AFAM Yongji Xie <xieyongji@byt=
edance.com> wrote:
> > > > > >
> > > > > > On Tue, Aug 6, 2024 at 10:28=E2=80=AFAM Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Aug 5, 2024 at 6:42=E2=80=AFPM Yongji Xie <xieyongji@=
bytedance.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Aug 5, 2024 at 4:24=E2=80=AFPM Jason Wang <jasowang=
@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowa=
ng@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Barry said [1]:
> > > > > > > > > >
> > > > > > > > > > """
> > > > > > > > > > mm doesn't support non-blockable __GFP_NOFAIL allocatio=
n. Because
> > > > > > > > > > __GFP_NOFAIL without direct reclamation may just result=
 in a busy
> > > > > > > > > > loop within non-sleepable contexts.
> > > > > > > > > > ""=E2=80=9C
> > > > > > > > > >
> > > > > > > > > > Unfortuantely, we do that under read lock. A possible w=
ay to fix that
> > > > > > > > > > is to move the pages allocation out of the lock into th=
e caller, but
> > > > > > > > > > having to allocate a huge number of pages and auxiliary=
 page array
> > > > > > > > > > seems to be problematic as well per Tetsuon [2]:
> > > > > > > > > >
> > > > > > > > > > """
> > > > > > > > > > You should implement proper error handling instead of u=
sing
> > > > > > > > > > __GFP_NOFAIL if count can become large.
> > > > > > > > > > """
> > > > > > > > > >
> > > > > > > >
> > > > > > > > I think the problem is it's hard to do the error handling i=
n
> > > > > > > > fops->release() currently.
> > > > > > >
> > > > > > > vduse_dev_dereg_umem() should be the same, it's very hard to =
allow it to fail.
> > > > > > >
> > > > > > > >
> > > > > > > > So can we temporarily hold the user page refcount, and rele=
ase it when
> > > > > > > > vduse_dev_open()/vduse_domain_release() is executed. The ke=
rnel page
> > > > > > > > allocation and memcpy can be done in vduse_dev_open() which=
 allows
> > > > > > > > some error handling.
> > > > > > >
> > > > > > > Just to make sure I understand this, the free is probably not=
 the big
> > > > > > > issue but the allocation itself.
> > > > > > >
> > > > > >
> > > > > > Yes, so defer the allocation might be a solution.
> > > > >
> > > > > Would you mind posting a patch for this?
> > > > >
> > > > > >
> > > > > > > And if we do the memcpy() in open(), it seems to be a subtle =
userspace
> > > > > > > noticeable change? (Or I don't get how copying in vduse_dev_o=
pen() can
> > > > > > > help here).
> > > > > > >
> > > > > >
> > > > > > Maybe we don't need to do the copy in open(). We can hold the u=
ser
> > > > > > page refcount until the inflight I/O is completed. That means t=
he
> > > > > > allocation of new kernel pages can be done in
> > > > > > vduse_domain_map_bounce_page() and the release of old user page=
s can
> > > > > > be done in vduse_domain_unmap_bounce_page().
> > > > >
> > > > > This seems to be a subtle userspace noticeable behaviour?
> > > > >
> > > >
> > > > Yes, userspace needs to ensure that it does not reuse the old user
> > > > pages for other purposes before vduse_dev_dereg_umem() returns
> > > > successfully. The vduse_dev_dereg_umem() will only return successfu=
lly
> > > > when there is no inflight I/O which means we don't need to allocate
> > > > extra kernel pages to store data. If we can't accept this, then you=
r
> > > > current patch might be the most suitable.
> > >
> > > It might be better to not break.
> > >
> > > Actually during my testing, the read_lock in the do_bounce path slows
> > > down the performance. Remove read_lock or use rcu_read_lock() to give
> > > 20% improvement of PPS.
> > >
> >
> > Looks like rcu_read_lock() should be OK here.
>
> The tricky part is that we may still end up behaviour changes (or lose
> some of the synchronization between kernel and bounce pages):
>
> RCU allows the read to be executed in parallel with the writer. So
> bouncing could be done in parallel with
> vduse_domain_add_user_bounce_pages(), there would be a race in two
> memcpy.
>

Hmm...this is a problem. We may still need some userspace noticeable
behaviour, e.g. only allowing reg_umem/dereg_umem when the device is
not started.

Thanks,
Yongji

