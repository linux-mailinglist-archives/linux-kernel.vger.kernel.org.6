Return-Path: <linux-kernel+bounces-282667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D4594E725
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6464A1F20FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621CE1537C8;
	Mon, 12 Aug 2024 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bc2i8VZT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28E24C9F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 06:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445420; cv=none; b=NJLMormz2TGHANuORWfXkJayKYKV4pnfvePQblNn14eNYGsL6HFFPamFCDCiN5VVaP7nDfEh2gBI6+1bcrKzEUAxHaGiH6J/G2XaWOdxS4wUARNGzdbUq9Ukw5WMlko6/Q0eUA/FuMkI2V6cPPqp3NqaMSVm7eKbmxf9w+wldOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445420; c=relaxed/simple;
	bh=W0eY8Xq3o3fHaz8bN7dG7yytV8UUgXdPUr5ycR0qiCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpT3/WERheYpGEgza68WInHA97Mk1JYMxVxJZhDIz0orJQQGYw1FvJOzATjPfeHM6Chl+fNYYAIYI1pj0lu29dKXP+lgvcdqskTOK8tmwlIRlsRbWjMe4x3/73pwziGUudYbQjWC8lkI7TYRmzfzOmgjsmMJm0n88rORQcITljE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bc2i8VZT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723445417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gD7Wwk8kOu+4mm0l1d/x7a1qMGGKB1sRxp0z9/NXgwQ=;
	b=bc2i8VZTzWTSNYzgJsdsARXrC3aXeMSqeq4rM6XM/44pUdzor5LOHRngETERrFvSXf4w/f
	3Sm59XI3SHTs6oAXGsXoeAzly4IeABQPWTaCTVU3IQ8rSTtfEUe9BEb7hbaNkitZpNhgOb
	5EXnXCOm2ifJlSjsH7lIO0wPrA5Ck48=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-AmYUMQ20M_yiyGEW9CTuOA-1; Mon, 12 Aug 2024 02:50:09 -0400
X-MC-Unique: AmYUMQ20M_yiyGEW9CTuOA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2cb6f2b965dso5514444a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 23:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723445408; x=1724050208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gD7Wwk8kOu+4mm0l1d/x7a1qMGGKB1sRxp0z9/NXgwQ=;
        b=RM6gowC5bTM+K+hFfAOXpKdcx7IL3jf+a9R9KdtuzymdBknXh/U9UF1+bWGfSlNar7
         M1kyps6/rh5M/Anq08QLepncJRTVEkYpJeDRHEASXyPhWyYrm5WDfZJzaLFlY2PYkRfn
         y12QGdStM49KG6Mez4YjxkSbfiw4JU8gdTQX+Pf7yTyChCU9OknlIUh4JEBvr6TFp/de
         AudSRBqvjsxWCleeh2Hcq/c7lsv2OoO6go7s1tbsurBk1QF8AbMAHybjrOmarW54O+FL
         K5BDolMgz3tKnkVtGOT0KCQ6WDN4v0x+gjaR1aocOgQOfvVHWQlJLzanb3aQb23Q2nLH
         Bj7g==
X-Forwarded-Encrypted: i=1; AJvYcCWQA7E/fwjUznbVOUvY+OYrtFI5ZXnVCVHfEjEJhWCM4JZPAn1Yq/eNmlNAD5x8BJP0RgqZlKttdOWZxSOkh9/W7RcRW6ocJu9l6zrq
X-Gm-Message-State: AOJu0Ywl+DWIECPWzc470+J4qSmvq0pdL2x40uZaY52CpqCNT9Vh0PfD
	G3mTaG+0upQroaz5JbvpUtuWhbaXwfotqiCfk57bVSCSba2yM0/v1iChAVoUaEizc1yJTZfBf7Y
	muQtC/OlAxvlYK/99SewN/7jn3FFBZDBC2fGXrTzI4pl2g/+Yee1+LMkWwiDoXhBucnbKIH6dyA
	rWqxrDNU4cTA86OnTe2G26UVn2bfAClbWUvD9F
X-Received: by 2002:a17:90b:207:b0:2c8:6308:ad78 with SMTP id 98e67ed59e1d1-2d1e80535d9mr10033987a91.34.1723445408331;
        Sun, 11 Aug 2024 23:50:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLGdwLYNX0VkuJKSx7I3Z1IUqAOr4ykW1cwWLQquNN9Af/9UdiPhu4hOno89xx+1HV9TCUE70bE5DOF3ax+PY=
X-Received: by 2002:a17:90b:207:b0:2c8:6308:ad78 with SMTP id
 98e67ed59e1d1-2d1e80535d9mr10033967a91.34.1723445407662; Sun, 11 Aug 2024
 23:50:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808082044.11356-1-jasowang@redhat.com> <9da68127-23d8-48a4-b56f-a3ff54fa213c@nvidia.com>
 <CACGkMEshq0=djGQ0gJe=AinZ2EHSpgE6CykspxRgLS_Ok55FKw@mail.gmail.com>
In-Reply-To: <CACGkMEshq0=djGQ0gJe=AinZ2EHSpgE6CykspxRgLS_Ok55FKw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 12 Aug 2024 14:49:56 +0800
Message-ID: <CACGkMEvAVM+KLpq7=+m8q1Wajs_FSSfftRGE+HN16OrFhqX=ow@mail.gmail.com>
Subject: Re: [RFC PATCH] vhost_vdpa: assign irq bypass producer token correctly
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: mst@redhat.com, lingshan.zhu@intel.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 1:47=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Aug 9, 2024 at 2:04=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
> >
> >
> >
> > On 08.08.24 10:20, Jason Wang wrote:
> > > We used to call irq_bypass_unregister_producer() in
> > > vhost_vdpa_setup_vq_irq() which is problematic as we don't know if th=
e
> > > token pointer is still valid or not.
> > >
> > > Actually, we use the eventfd_ctx as the token so the life cycle of th=
e
> > > token should be bound to the VHOST_SET_VRING_CALL instead of
> > > vhost_vdpa_setup_vq_irq() which could be called by set_status().
> > >
> > > Fixing this by setting up  irq bypass producer's token when handling
> > > VHOST_SET_VRING_CALL and un-registering the producer before calling
> > > vhost_vring_ioctl() to prevent a possible use after free as eventfd
> > > could have been released in vhost_vring_ioctl().
> > >
> > > Fixes: 2cf1ba9a4d15 ("vhost_vdpa: implement IRQ offloading in vhost_v=
dpa")
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > > Note for Dragos: Please check whether this fixes your issue. I
> > > slightly test it with vp_vdpa in L2.
> > > ---
> > >  drivers/vhost/vdpa.c | 12 +++++++++---
> > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > index e31ec9ebc4ce..388226a48bcc 100644
> > > --- a/drivers/vhost/vdpa.c
> > > +++ b/drivers/vhost/vdpa.c
> > > @@ -209,11 +209,9 @@ static void vhost_vdpa_setup_vq_irq(struct vhost=
_vdpa *v, u16 qid)
> > >       if (irq < 0)
> > >               return;
> > >
> > > -     irq_bypass_unregister_producer(&vq->call_ctx.producer);
> > >       if (!vq->call_ctx.ctx)
> > >               return;
> > >
> > > -     vq->call_ctx.producer.token =3D vq->call_ctx.ctx;
> > >       vq->call_ctx.producer.irq =3D irq;
> > >       ret =3D irq_bypass_register_producer(&vq->call_ctx.producer);
> > >       if (unlikely(ret))
> > > @@ -709,6 +707,12 @@ static long vhost_vdpa_vring_ioctl(struct vhost_=
vdpa *v, unsigned int cmd,
> > >                       vq->last_avail_idx =3D vq_state.split.avail_ind=
ex;
> > >               }
> > >               break;
> > > +     case VHOST_SET_VRING_CALL:
> > > +             if (vq->call_ctx.ctx) {
> > > +                     vhost_vdpa_unsetup_vq_irq(v, idx);
> > > +                     vq->call_ctx.producer.token =3D NULL;
> > > +             }
> > > +             break;
> > >       }
> > >
> > >       r =3D vhost_vring_ioctl(&v->vdev, cmd, argp);
> > > @@ -747,13 +751,14 @@ static long vhost_vdpa_vring_ioctl(struct vhost=
_vdpa *v, unsigned int cmd,
> > >                       cb.callback =3D vhost_vdpa_virtqueue_cb;
> > >                       cb.private =3D vq;
> > >                       cb.trigger =3D vq->call_ctx.ctx;
> > > +                     vq->call_ctx.producer.token =3D vq->call_ctx.ct=
x;
> > > +                     vhost_vdpa_setup_vq_irq(v, idx);
> > >               } else {
> > >                       cb.callback =3D NULL;
> > >                       cb.private =3D NULL;
> > >                       cb.trigger =3D NULL;
> > >               }
> > >               ops->set_vq_cb(vdpa, idx, &cb);
> > > -             vhost_vdpa_setup_vq_irq(v, idx);
> > >               break;
> > >
> > >       case VHOST_SET_VRING_NUM:
> > > @@ -1419,6 +1424,7 @@ static int vhost_vdpa_open(struct inode *inode,=
 struct file *filep)
> > >       for (i =3D 0; i < nvqs; i++) {
> > >               vqs[i] =3D &v->vqs[i];
> > >               vqs[i]->handle_kick =3D handle_vq_kick;
> > > +             vqs[i]->call_ctx.ctx =3D NULL;
> > >       }
> > >       vhost_dev_init(dev, vqs, nvqs, 0, 0, 0, false,
> > >                      vhost_vdpa_process_iotlb_msg);
> >
> > No more crashes, but now getting a lot of:
> >  vhost-vdpa-X: vq Y, irq bypass producer (token 00000000a66e28ab) regis=
tration fails, ret =3D  -16
> >
> > ... seems like the irq_bypass_unregister_producer() that was removed
> > might still be needed somewhere?
>
> Probably, but I didn't see this when testing vp_vdpa.
>
> When did you meet those warnings? Is it during the boot or migration?

Btw, it would be helpful to check if mlx5_get_vq_irq() works
correctly. I believe it should return an error if the virtqueue
interrupt is not allocated. After a glance at the code, it seems not
straightforward to me.

Thanks

>
> Thanks
>
> >
> > Thanks,
> > Dragos
> >
> >


