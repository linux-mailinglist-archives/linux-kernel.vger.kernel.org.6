Return-Path: <linux-kernel+bounces-185729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF2A8CB9DF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 05:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9EA28356B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727E274418;
	Wed, 22 May 2024 03:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gqdJs16o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B6D74BE0
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 03:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716349198; cv=none; b=la3pnzSQ3ASwnP3HdBo4EJJDMlCC9ajZSXY5ovVARIWTEfRCoO17+eCGVekQv5pvrh/TCwsuGSY1Cqpx/CYZ1pRECh2Tp7Lofi5VPSgkJHzO503jG4sF7jwNDyC3Zbjx2NTWQ2IhwpcTY57EPPvSrorU6CIZkD9kKn8HAFQTkRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716349198; c=relaxed/simple;
	bh=rsad/eQ6DWGheNrhJpEzrqphxiW82XXKQz+YNf64b9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLbs0I61uBkdA61q5iNVkoi9lKrm8LbcUlFuOyG38uLZ6O9/LxR/C9NHbEonawSRAcdg5YNcv25xpPwxP5m6KQ3AY9alMZKb7Z2k67wd+0sefx3pls1MMCDVXbN9dGeQDf8RmEcmR5xAVDlNbcHThLeWHSRijIC2llxs6VOs3SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gqdJs16o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716349195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ahfb/G0D4ZbkGUdB/34uH7SDNYvGMH6beGMeu1yJFi4=;
	b=gqdJs16oELEWpN82uY28xO1QvpVaT+wgQGSDQBkdMx5LfNahvSGkM3UM85rBXYaQe/Hm9K
	zjZxOPZY5izu4ik3iM9dx7dNG2v3j1Rqy3Son3KyZXSEwf+boK17aRS5y94lYNj4l7bMrm
	WwQa7Goo3cH2VJprF8jPDxAB0m4Qqzs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-8LGZCaWpNwqpnL95lTvOPQ-1; Tue, 21 May 2024 23:39:54 -0400
X-MC-Unique: 8LGZCaWpNwqpnL95lTvOPQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2b4330e57b6so13289339a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 20:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716349193; x=1716953993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahfb/G0D4ZbkGUdB/34uH7SDNYvGMH6beGMeu1yJFi4=;
        b=QSY/PwE5SDEUI8F7NPHPt43wYej1KYP+FiHFsBA1QSTxx+YqHL/emiEYkzNMV7ZmhC
         jes1Hioj8FRvzARgypabq4aYUuL5rLg4bHLjYYu2emeRskM3XvTpyxW0qf6aetS9bsMH
         9tmwJo909K0m6/unFEb2qIRU2AjBA71dFwjZ1Yod7gTeJT88B7SEHvj9vaLkUAB2DYo1
         xksOkNjALsefc9Bdf4an4NL3nyOx3RSekv1PXpoNYSBoZmrHZuPXbpZ36TyHGvcRn9nq
         wF5pJ846NkOh/EAkso2MbjCrLuGQFgJYpV2CDzP7e2ujLDU7yU9LbK6andngVblROXR6
         nP/g==
X-Forwarded-Encrypted: i=1; AJvYcCWtT8Lz9hXpzab3PjpSKoStXtAuuP9yC/Ss3DNWLiJ3okmQNgY8F0wq1dvgz/OOJ2JXuMpm9t/9Pu7T+kTbLqwpSH5YGHx0LOLMORN5
X-Gm-Message-State: AOJu0YywX0BUnhY9tfriHYD1KiarVbSTguO6+q7eEbZRdvrYXg0n1eD1
	V4BAaILbWxMe+1guaNVOtAMY3zdA+B3ncYexXZHZwcdPqjLimKubNfcNEs2/W65Tu8YEjbBlu4x
	qBd5w7+pQU7MNt9EN09ClLtZrCdcAhesvoxTxKjf9Q629rYg3vNHd4YkTg6/b5d3CnU2qV8SgOQ
	kWE9ltqklgOfdhq8Ebgzphry1bMeaVd44UZF5F
X-Received: by 2002:a17:90a:2ca1:b0:2b6:c4d7:fc31 with SMTP id 98e67ed59e1d1-2bd9f5bc52emr1191155a91.40.1716349192778;
        Tue, 21 May 2024 20:39:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8sphTEf2DYNIvycHgNVTAqOYPL463d5Bg/hLWjrc2NJXKaACBiVW4Y6g7W/u0hk1gVqaiG+1JL0LQ1v/2zrA=
X-Received: by 2002:a17:90a:2ca1:b0:2b6:c4d7:fc31 with SMTP id
 98e67ed59e1d1-2bd9f5bc52emr1191138a91.40.1716349192371; Tue, 21 May 2024
 20:39:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1716218462-84587-1-git-send-email-steven.sistare@oracle.com>
 <1716218462-84587-4-git-send-email-steven.sistare@oracle.com>
 <CACGkMEur=CoU1GgxNdweu-SfuutSN-a+LaHLkdtoWYJMnE+LOg@mail.gmail.com> <46f91e76-6f88-4f83-8854-10baed4e82c9@oracle.com>
In-Reply-To: <46f91e76-6f88-4f83-8854-10baed4e82c9@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 May 2024 11:39:41 +0800
Message-ID: <CACGkMEtVt+W4jmBxaXAytreXjJUHxmo+zzAw0wsrLw97pJmW-A@mail.gmail.com>
Subject: Re: [PATCH V3 3/3] vdpa_sim: flush workers on suspend
To: Steven Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xie Yongji <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 9:39=E2=80=AFPM Steven Sistare
<steven.sistare@oracle.com> wrote:
>
> On 5/20/2024 10:32 PM, Jason Wang wrote:
> > On Mon, May 20, 2024 at 11:21=E2=80=AFPM Steve Sistare
> > <steven.sistare@oracle.com> wrote:
> >>
> >> Flush to guarantee no workers are running when suspend returns.
> >> Add a lock to enforce ordering between clearing running, flushing,
> >> and posting new work in vdpasim_kick_vq.  It must be a spin lock
> >> because vdpasim_kick_vq may be reached va eventfd_write.
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> ---
> >>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 16 ++++++++++++++--
> >>   drivers/vdpa/vdpa_sim/vdpa_sim.h |  1 +
> >>   2 files changed, 15 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/=
vdpa_sim.c
> >> index 8ffea8430f95..67ed49d95bf0 100644
> >> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >> @@ -322,7 +322,7 @@ static u16 vdpasim_get_vq_size(struct vdpa_device =
*vdpa, u16 idx)
> >>                  return VDPASIM_QUEUE_MAX;
> >>   }
> >>
> >> -static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
> >> +static void vdpasim_do_kick_vq(struct vdpa_device *vdpa, u16 idx)
> >>   {
> >>          struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> >>          struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[idx];
> >> @@ -337,6 +337,15 @@ static void vdpasim_kick_vq(struct vdpa_device *v=
dpa, u16 idx)
> >>                  vdpasim_schedule_work(vdpasim);
> >>   }
> >>
> >> +static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
> >> +{
> >> +       struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> >> +
> >> +       spin_lock(&vdpasim->kick_lock);
> >> +       vdpasim_do_kick_vq(vdpa, idx);
> >> +       spin_unlock(&vdpasim->kick_lock);
> >> +}
> >> +
> >>   static void vdpasim_set_vq_cb(struct vdpa_device *vdpa, u16 idx,
> >>                                struct vdpa_callback *cb)
> >>   {
> >> @@ -520,8 +529,11 @@ static int vdpasim_suspend(struct vdpa_device *vd=
pa)
> >>          struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> >>
> >>          mutex_lock(&vdpasim->mutex);
> >> +       spin_lock(&vdpasim->kick_lock);
> >>          vdpasim->running =3D false;
> >> +       spin_unlock(&vdpasim->kick_lock);
> >>          mutex_unlock(&vdpasim->mutex);
> >> +       kthread_flush_work(&vdpasim->work);
> >>
> >>          return 0;
> >>   }
> >> @@ -537,7 +549,7 @@ static int vdpasim_resume(struct vdpa_device *vdpa=
)
> >>          if (vdpasim->pending_kick) {
> >>                  /* Process pending descriptors */
> >>                  for (i =3D 0; i < vdpasim->dev_attr.nvqs; ++i)
> >> -                       vdpasim_kick_vq(vdpa, i);
> >> +                       vdpasim_do_kick_vq(vdpa, i);
> >>
> >>                  vdpasim->pending_kick =3D false;
> >>          }
> >> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/=
vdpa_sim.h
> >> index bb137e479763..5eb6ca9c5ec5 100644
> >> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> >> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> >> @@ -75,6 +75,7 @@ struct vdpasim {
> >>          bool pending_kick;
> >>          /* spinlock to synchronize iommu table */
> >>          spinlock_t iommu_lock;
> >> +       spinlock_t kick_lock;
> >
> > It looks to me this is not initialized?
>
> Yup, I lost that line while fiddling with different locking schemes.
> Thanks, will fix in V4.
>
> @@ -236,6 +236,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_att=
r
> *dev_attr,
>
>          mutex_init(&vdpasim->mutex);
>          spin_lock_init(&vdpasim->iommu_lock);
> +       spin_lock_init(&vdpasim->kick_lock);
>
> With that fix, does this patch earn your RB?

Yes.

Thanks

>
> - Steve
>
> >>   };
> >>
> >>   struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr,
> >> --
> >> 2.39.3
> >>
> >
>


