Return-Path: <linux-kernel+bounces-282678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B13794E74D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B5728300E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A88A153BE3;
	Mon, 12 Aug 2024 07:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cyg3kXY7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53D915351C
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723446000; cv=none; b=aPSeoI6onIs9fNzsDLkR9R+Uq6k7MBPdEacPIQdLke4eEPVK95x3Wj9bc7aVAoXdaqPXdgrFIIyqAyQjq+ph1VyKkFlRZA6b16U5s2TDoIcqlMURT20RbP/eDOlN5PxraPJk7XCKECawpAyltJVl64+FZb9vslXiAHX12O5+32k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723446000; c=relaxed/simple;
	bh=HnD7jw0Bt4ZgIPCQPfN1keNyfXuampWgJ5FBB2TKuvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6I9/i4Q6ni8MIzAPVFYzCMRdLBaD79zGOxvfWUBoA+/14jMvlXbGGQ18Ubvrz34fKcNpCqoZ2E2sdrAdDt+psm10+6On5FXDjntI5rEd1il5MDU0VfWLHuGcZLN4JdqNhcohViLyblft5kW5GAjQb8oF53VkinerKPqYmO1kH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cyg3kXY7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723445997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HnD7jw0Bt4ZgIPCQPfN1keNyfXuampWgJ5FBB2TKuvs=;
	b=Cyg3kXY74me3RNjCvk1YQvRzIgvbTd3LE26lx7A9nduB2kqwWo6qYYLKqUrkojgMcdlrhk
	FbGS0mgp+9qVsfApEIwkyh9iTHuwpYQoBu5tDZTPhgaaa9ATvWpETGJZfZy1RGm6lLf1us
	e0NIXA7zO0prSE9Fbq1zVEGLLTPgmi8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-b8_1BDfFMfeq8ul-UTVm-A-1; Mon, 12 Aug 2024 02:59:55 -0400
X-MC-Unique: b8_1BDfFMfeq8ul-UTVm-A-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cf1a80693cso4863129a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 23:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723445994; x=1724050794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnD7jw0Bt4ZgIPCQPfN1keNyfXuampWgJ5FBB2TKuvs=;
        b=iuQnyjASU11W044tsBKOn0X+UOFacugRZ01f5lVPRh8KSCcYmWKYm9f1BWyURm+pCQ
         8hHM0xPfPsYJcU2hhMQ+zR8frNMmWcCReMKJsmOfUXKx1fiXZfqJO4UipAyvb+PgLRyK
         rf5gwoy3kW8DMGflTT2m+J1rlOiGaqOjgIq8U3kO2pBExQSiDCNUT1vVBSkqDqJHmRDO
         cq4l4iv0dV5s8zVeTh3nq5GpNZHU4wxVCE+N/ccl1OzvjS5w9VLfaRQqAULyc5m4VUDf
         /hNMSarNTqw0VScWsp+8mJw3t8GsKP/Bb/2QizBn5lOUvXUMMpC7jVGB209EHp0MA/JK
         9GMw==
X-Forwarded-Encrypted: i=1; AJvYcCWS31WQ0lDrpm34FNuqD87+lP2rE80rVtxFMPJwkMeLsCJe3XAPKctP7eq1sYcbGcEwe+ebnJAM0hmEJzKMMyNVp6iZAPSzxSq71T7U
X-Gm-Message-State: AOJu0YxYjPGVJQU03AUxL+CMPNT+an+jv7Lh19YOnA1jbbC7kUdUTsQJ
	RWc8edXwxekH4t2bukE+WAkLCLASZNUwEPWjfty+4y9WAcNNrEEILmV82GIW8Olq8fJYRaIcH5b
	4MQrfrYF80nbTdjO27m/y7vhDaa/W7QAH7oui61IipTJhNfz33neUGWN/EsW3SJiQ4WpnA7uEbu
	4Ui/2n84bp4Jxq9enJlMBO+FeoFzY9UPuAIv53
X-Received: by 2002:a17:90a:a892:b0:2cd:2992:e8dc with SMTP id 98e67ed59e1d1-2d1e7f9c914mr9059824a91.5.1723445993954;
        Sun, 11 Aug 2024 23:59:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAqMEDFInM0ZXBXhl6GppTaPVIO/zb/2LVAUPlZcsu/vLFxI6LVLxnUbM00uBcPSaRznliuvG3zvK+Z/eoLcI=
X-Received: by 2002:a17:90a:a892:b0:2cd:2992:e8dc with SMTP id
 98e67ed59e1d1-2d1e7f9c914mr9059806a91.5.1723445993402; Sun, 11 Aug 2024
 23:59:53 -0700 (PDT)
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
 <CACycT3sfUhz1PjK3Q=pA7GEm7=fsL0XT16ccwCQ2m2LF+TTD7Q@mail.gmail.com>
 <CACGkMEu+RrD2JdO=F9BySwhVY5uPr6kKWWdkcdG4XX6GN5b=Bg@mail.gmail.com> <CACycT3u-v+XkWzSPq39Mk9sdQftuNZvZqZyzDvhTecH3uyuk8w@mail.gmail.com>
In-Reply-To: <CACycT3u-v+XkWzSPq39Mk9sdQftuNZvZqZyzDvhTecH3uyuk8w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 12 Aug 2024 14:59:42 +0800
Message-ID: <CACGkMEs1EG=1UJNJ9fuN3rpq0ruQE7imhRurq4o_7pjSgvApXQ@mail.gmail.com>
Subject: Re: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Yongji Xie <xieyongji@bytedance.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel <linux-kernel@vger.kernel.org>, 21cnbao@gmail.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 7:09=E2=80=AFPM Yongji Xie <xieyongji@bytedance.com>=
 wrote:
>
> On Thu, Aug 8, 2024 at 1:50=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Wed, Aug 7, 2024 at 2:54=E2=80=AFPM Yongji Xie <xieyongji@bytedance.=
com> wrote:
> > >
> > > On Wed, Aug 7, 2024 at 12:38=E2=80=AFPM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Wed, Aug 7, 2024 at 11:13=E2=80=AFAM Yongji Xie <xieyongji@byted=
ance.com> wrote:
> > > > >
> > > > > On Wed, Aug 7, 2024 at 10:39=E2=80=AFAM Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > >
> > > > > > On Tue, Aug 6, 2024 at 11:10=E2=80=AFAM Yongji Xie <xieyongji@b=
ytedance.com> wrote:
> > > > > > >
> > > > > > > On Tue, Aug 6, 2024 at 10:28=E2=80=AFAM Jason Wang <jasowang@=
redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Aug 5, 2024 at 6:42=E2=80=AFPM Yongji Xie <xieyongj=
i@bytedance.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Aug 5, 2024 at 4:24=E2=80=AFPM Jason Wang <jasowa=
ng@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jaso=
wang@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Barry said [1]:
> > > > > > > > > > >
> > > > > > > > > > > """
> > > > > > > > > > > mm doesn't support non-blockable __GFP_NOFAIL allocat=
ion. Because
> > > > > > > > > > > __GFP_NOFAIL without direct reclamation may just resu=
lt in a busy
> > > > > > > > > > > loop within non-sleepable contexts.
> > > > > > > > > > > ""=E2=80=9C
> > > > > > > > > > >
> > > > > > > > > > > Unfortuantely, we do that under read lock. A possible=
 way to fix that
> > > > > > > > > > > is to move the pages allocation out of the lock into =
the caller, but
> > > > > > > > > > > having to allocate a huge number of pages and auxilia=
ry page array
> > > > > > > > > > > seems to be problematic as well per Tetsuon [2]:
> > > > > > > > > > >
> > > > > > > > > > > """
> > > > > > > > > > > You should implement proper error handling instead of=
 using
> > > > > > > > > > > __GFP_NOFAIL if count can become large.
> > > > > > > > > > > """
> > > > > > > > > > >
> > > > > > > > >
> > > > > > > > > I think the problem is it's hard to do the error handling=
 in
> > > > > > > > > fops->release() currently.
> > > > > > > >
> > > > > > > > vduse_dev_dereg_umem() should be the same, it's very hard t=
o allow it to fail.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > So can we temporarily hold the user page refcount, and re=
lease it when
> > > > > > > > > vduse_dev_open()/vduse_domain_release() is executed. The =
kernel page
> > > > > > > > > allocation and memcpy can be done in vduse_dev_open() whi=
ch allows
> > > > > > > > > some error handling.
> > > > > > > >
> > > > > > > > Just to make sure I understand this, the free is probably n=
ot the big
> > > > > > > > issue but the allocation itself.
> > > > > > > >
> > > > > > >
> > > > > > > Yes, so defer the allocation might be a solution.
> > > > > >
> > > > > > Would you mind posting a patch for this?
> > > > > >
> > > > > > >
> > > > > > > > And if we do the memcpy() in open(), it seems to be a subtl=
e userspace
> > > > > > > > noticeable change? (Or I don't get how copying in vduse_dev=
_open() can
> > > > > > > > help here).
> > > > > > > >
> > > > > > >
> > > > > > > Maybe we don't need to do the copy in open(). We can hold the=
 user
> > > > > > > page refcount until the inflight I/O is completed. That means=
 the
> > > > > > > allocation of new kernel pages can be done in
> > > > > > > vduse_domain_map_bounce_page() and the release of old user pa=
ges can
> > > > > > > be done in vduse_domain_unmap_bounce_page().
> > > > > >
> > > > > > This seems to be a subtle userspace noticeable behaviour?
> > > > > >
> > > > >
> > > > > Yes, userspace needs to ensure that it does not reuse the old use=
r
> > > > > pages for other purposes before vduse_dev_dereg_umem() returns
> > > > > successfully. The vduse_dev_dereg_umem() will only return success=
fully
> > > > > when there is no inflight I/O which means we don't need to alloca=
te
> > > > > extra kernel pages to store data. If we can't accept this, then y=
our
> > > > > current patch might be the most suitable.
> > > >
> > > > It might be better to not break.
> > > >
> > > > Actually during my testing, the read_lock in the do_bounce path slo=
ws
> > > > down the performance. Remove read_lock or use rcu_read_lock() to gi=
ve
> > > > 20% improvement of PPS.
> > > >
> > >
> > > Looks like rcu_read_lock() should be OK here.
> >
> > The tricky part is that we may still end up behaviour changes (or lose
> > some of the synchronization between kernel and bounce pages):
> >
> > RCU allows the read to be executed in parallel with the writer. So
> > bouncing could be done in parallel with
> > vduse_domain_add_user_bounce_pages(), there would be a race in two
> > memcpy.
> >
>
> Hmm...this is a problem. We may still need some userspace noticeable
> behaviour, e.g. only allowing reg_umem/dereg_umem when the device is
> not started.

Exactly, maybe have a new userspace flag.

Thanks

>
> Thanks,
> Yongji
>


