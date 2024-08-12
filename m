Return-Path: <linux-kernel+bounces-282598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A4794E645
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE75728280F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 05:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB0514EC5C;
	Mon, 12 Aug 2024 05:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqUJnu01"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B37F14EC59
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 05:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723441651; cv=none; b=Vb9868DiM7gvdaBK2EioVA3Xa4z9Kv+mxIP2+e7vVsrPPD1uSmy4dU3xj7XjCqR5SlqM9sNb7myyeKuY9i7GNIv9zcA5yWdf6ldiyukx3w1VVOjztEVhKwOAW0dja+UPh+GQyjzhrNoFzhkhWLK/l08w+DWH4qW9daQxLEOsBEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723441651; c=relaxed/simple;
	bh=Uw8yb612ZKPbURrgt/Fv4sgrL3dUlccka3seY1ans64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AhiQ6RQVKvJQSwcwRwuAsuGXCzPWJrAbVt4WJ4QuG87LGSgEH/zQUPnTTjykTj6vAz8Zv02Ey23itkHxEHpMa7ijV02HV4IDcyK63PxslarM0EgmuXf0J2z0QUxWAaRLUelNwHbiwMz5/+iEETKaPIJ7kJLuUkJ+X/M9Gb+a5lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqUJnu01; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723441648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H5CsJWNFYLKrhPjV5w6+3TXZvOdH+ndcySRvBH2M9eo=;
	b=JqUJnu01mvPkLvw/YVSO74CavkIHNEKUV+Iq5vo2ZcO2xsdJ8wX3A+Pz4wmhEuRfeXCxXx
	6RDs3Y9XOTlhhQEkshBbQr/qhU039cf/mU2MgjkgbE/t4IO6r95srigoardoa62bAzRdbc
	hNxTjt7N39ogomWgr7hN0Y4tfyb5jXQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-zoj8TCDNPT61HcmvlOg5jA-1; Mon, 12 Aug 2024 01:47:22 -0400
X-MC-Unique: zoj8TCDNPT61HcmvlOg5jA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7278c31e2acso3876275a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 22:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723441642; x=1724046442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5CsJWNFYLKrhPjV5w6+3TXZvOdH+ndcySRvBH2M9eo=;
        b=l/byg5U8xtMD8pM4rwsGN80kfWbGs8YvUzX9MfuQYZ9Nw8GPBJrM0LtDGCGCP3rbvl
         E72/KjZw2ExuPAvtaZgdep3eeazZywsAFcN3BtWQYghsH2srFTwjw1zHZPXLqg3Kzm9T
         UavD9R5R36sEv5b3LTYWxtpEgLxatcW4DAvIdDXGJc2X363dY0h8PwPnXKxebGK1J5qh
         8N8PhPCJFc8xBiqvonUXCScduxteOqi7dzjPQTgxDYY3ks0ElKQkRDI/A/Om8/38OwTy
         XpJynTtN1FI99cwgUMXpl4mwZbthIScZTx8MBAbkGUIWtw3cFsK5VfbaRhbWsS7iwbUQ
         9htw==
X-Forwarded-Encrypted: i=1; AJvYcCV+AHWIbieTOpJeNNPmTbK3czI7gtrvHlvemLv9i1MJ4zi3QNwp3jBunHOGyEvWxUOlEazJpuExntP96Jmyx+XpoIhbOw2twOeMX7FE
X-Gm-Message-State: AOJu0Yx7AfTdiXb5uknjogWt26j8aaITF4dedk9Kkkm0MaSsF+XRTW3r
	nY+wvoSM+mnjwy6ECvCt7IdqxJ3XRlOq3ZcJhX+qgu8uarVXHejm/Tl2awy24wMDCkkcMaVGUKH
	dBt+ABOKCMZmBFz45I89imN2wIcrOT8iI2Nfv/uCYe/EWN96m9HWvgAUbDYdyksldTOHr16yIq+
	fCZpbzXJNjxI0YYarF30x/7HeOWX/Dot/vKuTH
X-Received: by 2002:a17:90b:4a01:b0:2c8:53be:fa21 with SMTP id 98e67ed59e1d1-2d1e80512c7mr9791792a91.34.1723441641646;
        Sun, 11 Aug 2024 22:47:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcQ+XQNc52+i7y7nv+eFycOjVns25ofqhkZcSaAIAiL54PDiPb1KE6nRmNAupkKLE5WiXOivV/pbuxkhY+hnM=
X-Received: by 2002:a17:90b:4a01:b0:2c8:53be:fa21 with SMTP id
 98e67ed59e1d1-2d1e80512c7mr9791777a91.34.1723441641179; Sun, 11 Aug 2024
 22:47:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808082044.11356-1-jasowang@redhat.com> <9da68127-23d8-48a4-b56f-a3ff54fa213c@nvidia.com>
In-Reply-To: <9da68127-23d8-48a4-b56f-a3ff54fa213c@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 12 Aug 2024 13:47:10 +0800
Message-ID: <CACGkMEshq0=djGQ0gJe=AinZ2EHSpgE6CykspxRgLS_Ok55FKw@mail.gmail.com>
Subject: Re: [RFC PATCH] vhost_vdpa: assign irq bypass producer token correctly
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: mst@redhat.com, lingshan.zhu@intel.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 2:04=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
>
>
> On 08.08.24 10:20, Jason Wang wrote:
> > We used to call irq_bypass_unregister_producer() in
> > vhost_vdpa_setup_vq_irq() which is problematic as we don't know if the
> > token pointer is still valid or not.
> >
> > Actually, we use the eventfd_ctx as the token so the life cycle of the
> > token should be bound to the VHOST_SET_VRING_CALL instead of
> > vhost_vdpa_setup_vq_irq() which could be called by set_status().
> >
> > Fixing this by setting up  irq bypass producer's token when handling
> > VHOST_SET_VRING_CALL and un-registering the producer before calling
> > vhost_vring_ioctl() to prevent a possible use after free as eventfd
> > could have been released in vhost_vring_ioctl().
> >
> > Fixes: 2cf1ba9a4d15 ("vhost_vdpa: implement IRQ offloading in vhost_vdp=
a")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > Note for Dragos: Please check whether this fixes your issue. I
> > slightly test it with vp_vdpa in L2.
> > ---
> >  drivers/vhost/vdpa.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index e31ec9ebc4ce..388226a48bcc 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -209,11 +209,9 @@ static void vhost_vdpa_setup_vq_irq(struct vhost_v=
dpa *v, u16 qid)
> >       if (irq < 0)
> >               return;
> >
> > -     irq_bypass_unregister_producer(&vq->call_ctx.producer);
> >       if (!vq->call_ctx.ctx)
> >               return;
> >
> > -     vq->call_ctx.producer.token =3D vq->call_ctx.ctx;
> >       vq->call_ctx.producer.irq =3D irq;
> >       ret =3D irq_bypass_register_producer(&vq->call_ctx.producer);
> >       if (unlikely(ret))
> > @@ -709,6 +707,12 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vd=
pa *v, unsigned int cmd,
> >                       vq->last_avail_idx =3D vq_state.split.avail_index=
;
> >               }
> >               break;
> > +     case VHOST_SET_VRING_CALL:
> > +             if (vq->call_ctx.ctx) {
> > +                     vhost_vdpa_unsetup_vq_irq(v, idx);
> > +                     vq->call_ctx.producer.token =3D NULL;
> > +             }
> > +             break;
> >       }
> >
> >       r =3D vhost_vring_ioctl(&v->vdev, cmd, argp);
> > @@ -747,13 +751,14 @@ static long vhost_vdpa_vring_ioctl(struct vhost_v=
dpa *v, unsigned int cmd,
> >                       cb.callback =3D vhost_vdpa_virtqueue_cb;
> >                       cb.private =3D vq;
> >                       cb.trigger =3D vq->call_ctx.ctx;
> > +                     vq->call_ctx.producer.token =3D vq->call_ctx.ctx;
> > +                     vhost_vdpa_setup_vq_irq(v, idx);
> >               } else {
> >                       cb.callback =3D NULL;
> >                       cb.private =3D NULL;
> >                       cb.trigger =3D NULL;
> >               }
> >               ops->set_vq_cb(vdpa, idx, &cb);
> > -             vhost_vdpa_setup_vq_irq(v, idx);
> >               break;
> >
> >       case VHOST_SET_VRING_NUM:
> > @@ -1419,6 +1424,7 @@ static int vhost_vdpa_open(struct inode *inode, s=
truct file *filep)
> >       for (i =3D 0; i < nvqs; i++) {
> >               vqs[i] =3D &v->vqs[i];
> >               vqs[i]->handle_kick =3D handle_vq_kick;
> > +             vqs[i]->call_ctx.ctx =3D NULL;
> >       }
> >       vhost_dev_init(dev, vqs, nvqs, 0, 0, 0, false,
> >                      vhost_vdpa_process_iotlb_msg);
>
> No more crashes, but now getting a lot of:
>  vhost-vdpa-X: vq Y, irq bypass producer (token 00000000a66e28ab) registr=
ation fails, ret =3D  -16
>
> ... seems like the irq_bypass_unregister_producer() that was removed
> might still be needed somewhere?

Probably, but I didn't see this when testing vp_vdpa.

When did you meet those warnings? Is it during the boot or migration?

Thanks

>
> Thanks,
> Dragos
>
>


