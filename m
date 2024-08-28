Return-Path: <linux-kernel+bounces-304674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6234C962379
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF54281B19
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CA1161327;
	Wed, 28 Aug 2024 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFFc2T1K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB34154C14
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837621; cv=none; b=Q9b5Kbcuo3dNQtFVJYA29UdKKtxYFeo+Rz0GrKj5ZFH+NdBy4X58i6BiSYtUmpq4W/+eSMzezzGiQETJtN3dLANkpzavOO+B5uZ+oDEJ9HkBbIANI2G6upocaMrPO4M8IDZaz2UmPiJbJOmLscU1D4htquog22pyBA15yz8eG6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837621; c=relaxed/simple;
	bh=+n9XGtDtxdWnqHxyvsmdxD96dihzfjN3ukpEoNW+9QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+mlf7OkrZVU15V8HVNFUz0L5G0gabSxzLBFOwAy+FRZRFIA5KRE96QRGDPQQNjUzcc7YIjk6EN0nWhmdt2SgstgVM6kY2kZAU6O7gSPQ4UkwiPDjFEtzQ8MSdj88Dbpye3AmTcJoKIjDxoUGQQZJF83CsZ0BUmExOXhF0SSjdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bFFc2T1K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724837618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQ4oNDyVn9J8sj8wpWyPKSrzPW91AjXC5QSksehG4TY=;
	b=bFFc2T1KdHWm1onVuhz0ly/OSnBZRGqkMT6oqxqSqJb8F9qxQsPfsJ0AGmAChO0gAmwaIq
	ZerNJObvR8fLJ0PLOc9CCgt4ALyQqA+EpEh4NaLfayErOyskdcctzRq+y/dEK5M3rhPjbK
	fY5tNQZ/E8np/nCBc7edBGOxD7PGI90=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-6YxoNy-yN5StcTGS8DBwYA-1; Wed, 28 Aug 2024 05:33:36 -0400
X-MC-Unique: 6YxoNy-yN5StcTGS8DBwYA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f40231302cso52184171fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724837615; x=1725442415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQ4oNDyVn9J8sj8wpWyPKSrzPW91AjXC5QSksehG4TY=;
        b=Jc5s+h3ng6vjo32wA81ntR6W4co5prqTK1wVfVricR8wc3mkyuAe11ypZHG2yKyGH/
         SOvPhRtlNDYj45e4rREnFQ9zJ3af9ef4MZ8eu5npNb+x/7hHPO7l0nA6N9wqSyWW708/
         EzKzITVysrncNdBKK4slaNOPeBhl7Hm7IX27MroSTupjV6m7KNtvjqd5ukiHFrXYmIOw
         I19eiZvExBMokqJwo91x8ODd8mgRvVHXqXfM6hjpFrwI7wepO/CpSrT5nA8+KbZSVzmc
         94xy2kKU5eLq+Jk6zTxKap3sDJr/xhp7geCQpCVKZjBKyduu1uAax35EGAeoNigEeuxT
         4o4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQfGD92xwOzzjNC1n42AYOiSSYsA8zLv/6WyyMTBT7TmKYA3PuGpyOUgwfkwEj966fdeQaNhUBkZlMBF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2m2MLPTDf8zA0peC+QB57LooMKAPSjbmwGAtydwsMHEfwq04O
	s/3SUsDpDoHFJ9krhYTBKT0PKgTSO7fDjQfpQ7PScdKNkHU6NK8VzO85+/5l+vJW2OYSzTnYfGn
	u8NwIiNSKP8hO/4D3omfqun8vUDjsX86v5Ehyf/N9xcZ7nAjzfYG+ZkifuOBb19H3ebW6D8ZqAv
	9SuaLBDx+t0e+xQgiFdXDoNCVeKHZN6x2ZAJ0g
X-Received: by 2002:a2e:a587:0:b0:2ef:23ec:9353 with SMTP id 38308e7fff4ca-2f4f57978c9mr107802361fa.38.1724837614947;
        Wed, 28 Aug 2024 02:33:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrN5y6fe+G0denXRynGJFeAbblpVQNTVMZ9VRtPCuXw+tfyWMRx1ywC6FP8mAaOPM4fAatzTTgMdjb0uQUv8Y=
X-Received: by 2002:a2e:a587:0:b0:2ef:23ec:9353 with SMTP id
 38308e7fff4ca-2f4f57978c9mr107802151fa.38.1724837614306; Wed, 28 Aug 2024
 02:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819092851.441670-1-lulu@redhat.com> <20240819092851.441670-3-lulu@redhat.com>
 <CACGkMEtQaJ+o2WXnWw8iCF=9q7kx+CyVnn_YUgbNEo-ontHRqA@mail.gmail.com>
In-Reply-To: <CACGkMEtQaJ+o2WXnWw8iCF=9q7kx+CyVnn_YUgbNEo-ontHRqA@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 28 Aug 2024 17:32:57 +0800
Message-ID: <CACLfguUrEAEena_43od1MCyr+B9SJfx+Wj6XyL4b-yZasrkzrg@mail.gmail.com>
Subject: Re: [RFC 2/7] vhost: Add kthread support in function vhost_worker_queue()
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Aug 2024 at 10:36, Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Aug 19, 2024 at 5:29=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Added back the previously removed function vhost_worker_queue() and
> > renamed it to vhost_worker_queue_khtread(). The new vhost_worker_queue(=
)
> > will select the different mode based on the value of the parameter.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> It looks like a partial revert of some previous commit, please mention
> the commit id in the change log as least.
>
> So did for the following 3 or 4 patches.
>
> Thanks
>
sure, will add this
Thanks
cindy
> > ---
> >  drivers/vhost/vhost.c | 30 ++++++++++++++++++++++++++++--
> >  drivers/vhost/vhost.h |  1 +
> >  2 files changed, 29 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index da701f6b3f2c..6261c9df468e 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -236,8 +236,8 @@ void vhost_poll_stop(struct vhost_poll *poll)
> >  }
> >  EXPORT_SYMBOL_GPL(vhost_poll_stop);
> >
> > -static void vhost_worker_queue(struct vhost_worker *worker,
> > -                              struct vhost_work *work)
> > +static void vhost_worker_queue_task(struct vhost_worker *worker,
> > +                                   struct vhost_work *work)
> >  {
> >         if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
> >                 /* We can only add the work to the list after we're
> > @@ -249,6 +249,32 @@ static void vhost_worker_queue(struct vhost_worker=
 *worker,
> >         }
> >  }
> >
> > +static void vhost_work_queue_kthread(struct vhost_worker *worker,
> > +                                    struct vhost_work *work)
> > +{
> > +       if (!worker)
> > +               return;
> > +
> > +       if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
> > +               /* We can only add the work to the list after we're
> > +                * sure it was not in the list.
> > +                * test_and_set_bit() implies a memory barrier.
> > +                */
> > +               llist_add(&work->node, &worker->work_list);
> > +
> > +               wake_up_process(worker->task);
> > +       }
> > +}
> > +
> > +static void vhost_worker_queue(struct vhost_worker *worker,
> > +                              struct vhost_work *work)
> > +{
> > +       if (use_kthread) {
> > +               vhost_work_queue_kthread(worker, work);
> > +       } else {
> > +               vhost_worker_queue_task(worker, work);
> > +       }
> > +}
> >  bool vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work=
 *work)
> >  {
> >         struct vhost_worker *worker;
> > diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > index bb75a292d50c..c7f126fd09e8 100644
> > --- a/drivers/vhost/vhost.h
> > +++ b/drivers/vhost/vhost.h
> > @@ -27,6 +27,7 @@ struct vhost_work {
> >  };
> >
> >  struct vhost_worker {
> > +       struct task_struct      *task;
> >         struct vhost_task       *vtsk;
> >         struct vhost_dev        *dev;
> >         /* Used to serialize device wide flushing with worker swapping.=
 */
> > --
> > 2.45.0
> >
>


