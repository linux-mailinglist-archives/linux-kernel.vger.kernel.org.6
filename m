Return-Path: <linux-kernel+bounces-528068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E54A41326
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379F13AEB9C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A9B19ABC6;
	Mon, 24 Feb 2025 02:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIvjNcmG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632F92A1BA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740362849; cv=none; b=HUSzr7y6OfNmi7SF76b9d4UlvB15tVOvegjC63Db+m4PhK+AgOCrEi2DfxNYcpc0KrKA+g1rY2Aec37aGXxyvKCe8i3LX0hsZavds95pqoVXpVMq5HfHZPzscWIoO6nf4pv8EiRP0rXvNOMl+DUTqU1KCabQ7f0nxunBsa+KYnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740362849; c=relaxed/simple;
	bh=PU6yMr0sXTgg8AdmJiBB0C7zILOYqIrL0RzfBj+VJek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Favs+gCTJJW9Wxcr6hnhAGnM0wuvg4eyosXimVh3gBOp5+pq6eRrmYgy+oq+1M/0U5y4Y0Q5Aen0/4/oJsKs4tp07y/8p3UF1+n/IUEob25xIKBQQOnfL5ArI5niQq8Vc8CiLKOYF6sgAnk0V3RDFJsfsZwCy88H1OcTSzGqrlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TIvjNcmG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740362846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVe7vnB2MmA0mVlr6ZcRDcJS83l3FqdJ8ruAmpKAwnw=;
	b=TIvjNcmG7EkeG+SxTe04r2Fr7l9rYPt4yTy8LSKrei+Bph4rUvZ/kv6XN5ALUl7SsLIbvO
	RVtDdT9T3fDeo6+IYVjJbR55sQFLzG3611nTXGGvWPokwFyK25jwS9muy8aYs6W5l0IbWl
	8c0cwPbs2WJv/DJnksCG6nffaXm28t0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-1Be0oIGcNWqd7MwqdOrCcQ-1; Sun, 23 Feb 2025 21:07:24 -0500
X-MC-Unique: 1Be0oIGcNWqd7MwqdOrCcQ-1
X-Mimecast-MFC-AGG-ID: 1Be0oIGcNWqd7MwqdOrCcQ_1740362843
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-220ec5c16e9so81560285ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 18:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740362843; x=1740967643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVe7vnB2MmA0mVlr6ZcRDcJS83l3FqdJ8ruAmpKAwnw=;
        b=DSJL2P2hPJ98RG825RwyPexziDfcYK1+Y1wAE1oe+sWo6Ctd6QD7lZpbtZW8UklncB
         HQfKd38D5XUKDPoFJ6xTWd7UtPOCAThc/RvX7EGajbuVUKgEKgGc1rlpsmxMGMAAMjOd
         4YCI71qsvBXjzp8UiSOE4v7y65PhltQg+ynEWTY/mtmb+voPLJMiao4RNxVynLnkG8Vh
         rT8CbV+NG0KWesqeQ/L99PpKUrnCmAAEqaTkHKfvGtokAXhiDFxLfcApZx+1SxHRK0qS
         /cPGhptBCfIFO8FZ4JS6wQisEHW1wzFK/UyuP/gAQQFBTQrAQHSgJdu0702XIPnIzSQJ
         QOHQ==
X-Gm-Message-State: AOJu0Yy1XTQsbaqkuvk4WI+vrftTvrReRtNmG+xV8iYlMG6SxyYaXC3p
	twetr1QaliJ+w0Mg6HXi1vmlfYYmGU0TUBesFAJH5MrtTtl9FItcg0XgPi+zYehQhz0D+/4Dp+8
	y+c8JbcAwu0iUP0Depeb3LXWw6s+V+7hvI2VWE9S8auDXEkgE2ULpx2s9eSepHSKasJT4jw2bhH
	/8qjLWjM+DPXhtqkd2wxYTyyjuMJIEccJxc7Az
X-Gm-Gg: ASbGncsY6ihzLpFfwJvVW3c2U4PGxmQu5RCdt1yTHWwulyXuhkZPAeW8XT17C2OsU4I
	SGooKJ/ti/ahKj1pWWprnwHv7M5mfNvLxwxdPIse5jNwKDVUgZ3uGNbM5vpFN7+flP0kvwT88dA
	==
X-Received: by 2002:a17:902:fc44:b0:215:bb50:6a05 with SMTP id d9443c01a7336-221a0ec944cmr167789755ad.9.1740362843336;
        Sun, 23 Feb 2025 18:07:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWxLxRjbNeL3k+qp4dEmIQrhzolbd0KxIjdVJyEzBRQaexy3vtda6ZsVVrL+WWqHZzBpasJUPbARwF1vugpVw=
X-Received: by 2002:a17:902:fc44:b0:215:bb50:6a05 with SMTP id
 d9443c01a7336-221a0ec944cmr167789465ad.9.1740362842890; Sun, 23 Feb 2025
 18:07:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c1dbc7dbad9b445245d3348f19e6742b0be07347.1740094946.git.mst@redhat.com>
 <CACGkMEsK5Z_5B9Lz46kYYB_ndOG=CrvtZE_tLbRjL7=fT7OxbQ@mail.gmail.com> <20250220202425-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250220202425-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2025 10:07:11 +0800
X-Gm-Features: AWEUYZko-kyR9PF7g9ncOaaPlJPn8qANKIEBHPGlYecjyDDfOeEVhkoKNiHoBsY
Message-ID: <CACGkMEuKb040MZHeNEX2b2XhuJMLpCwBgTms_zL5NEw9KFgzew@mail.gmail.com>
Subject: Re: [PATCH] virtio: break and reset virtio devices on device_shutdown()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Eric Auger <eauger@redhat.com>, 
	Hongyu Ning <hongyu.ning@linux.intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 9:37=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Feb 21, 2025 at 09:11:51AM +0800, Jason Wang wrote:
> > On Fri, Feb 21, 2025 at 7:42=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
> > > accesses during the hang.
> > >
> > >         Invalid read at addr 0x102877002, size 2, region '(null)', re=
ason: rejected
> > >         Invalid write at addr 0x102877A44, size 2, region '(null)', r=
eason: rejected
> > >         ...
> > >
> > > It was traced down to virtio-console. Kexec works fine if virtio-cons=
ole
> > > is not in use.
> > >
> > > The issue is that virtio-console continues to write to the MMIO even =
after
> > > underlying virtio-pci device is reset.
> >
> > Some of my questions were not answered so I need to post them again.
> >
> > Do we need to fix vitio-console?
>
> this fixes all devices so no.
>
> > Note that we've already break the device in virtio_pci_remove():
> >
> > static void virtio_pci_remove(struct pci_dev *pci_dev)
> > {
> >   struct virtio_pci_device *vp_dev =3D pci_get_drvdata(pci_dev);
> >         struct device *dev =3D get_device(&vp_dev->vdev.dev);
> >
> >         /*
> >          * Device is marked broken on surprise removal so that virtio u=
pper
> >          * layers can abort any ongoing operation.
> >          */
> >         if (!pci_device_is_present(pci_dev))
> >                 virtio_break_device(&vp_dev->vdev);
> >
> > ...
>
>
> shutdown path does not invoke remove, and I do not want to,
> since that will slow down reboots for no good reason.
>
> > >
> > > Additionally, Eric noticed that IOMMUs are reset before devices, if
> > > devices are not reset on shutdown they continue to poke at guest memo=
ry
> > > and get errors from the IOMMU. Some devices get wedged then.
> > >
> > > The problem can be solved by breaking all virtio devices on virtio
> > > bus shutdown, then resetting them.
> > >
> > > Reported-by: Eric Auger <eauger@redhat.com>
> > > Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  drivers/virtio/virtio.c | 31 +++++++++++++++++++++++++++++++
> > >  1 file changed, 31 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > index c1cc1157b380..e5b29520d3b2 100644
> > > --- a/drivers/virtio/virtio.c
> > > +++ b/drivers/virtio/virtio.c
> > > @@ -377,6 +377,36 @@ static void virtio_dev_remove(struct device *_d)
> > >         of_node_put(dev->dev.of_node);
> > >  }
> > >
> > > +static void virtio_dev_shutdown(struct device *_d)
> > > +{
> > > +       struct virtio_device *dev =3D dev_to_virtio(_d);
> > > +       struct virtio_driver *drv =3D drv_to_virtio(dev->dev.driver);
> > > +
> > > +       /*
> > > +        * Stop accesses to or from the device.
> > > +        * We only need to do it if there's a driver - no accesses ot=
herwise.
> > > +        */
> > > +       if (!drv)
> > > +               return;
> > > +
> > > +       /*
> > > +        * Some devices get wedged if you kick them after they are
> > > +        * reset. Mark all vqs as broken to make sure we don't.
> > > +        */
> > > +       virtio_break_device(dev);
> > > +       /*
> > > +        * The below virtio_synchronize_cbs() guarantees that any int=
errupt
> > > +        * for this line arriving after virtio_synchronize_vqs() has =
completed
> > > +        * is guaranteed to see vq->broken as true.
> > > +        */
> > > +       virtio_synchronize_cbs(dev);
> >
> > This looks like a partial re-introduction of the hardening work, but
> > the ccw part is still in-completed e.g the synchronization requires a
> > read_lock() and depends on CONFIG_VIRTIO_HARDEN_NOTIFICATION (which is
> > marked as broken now).
>
> Hmm I don't understand why we can not just take a subchannel lock.

Might be, just want to point that ccw (and there maybe other transport
that) lacks synchronization.

> worth thinking about it. as this doesn't regress i think
> I can live with it for now.
>
> > Should it better to
> >
> > 1) fix the virtio-console
>
> the problem is not unique to console. it was just observed there.
> any device can trigger this.
>
> > 2) simply rest in shutdown
>
> then we are back with devices wedged as they are kicked
> while reset.
>
> > 3) wait for the hardening work to be done in the future?
> >
> > Thanks
>
> as users are seeing this on x86, I want to fix it.
> finding a way to fix virtio_synchronize_cbs seems best.
>
> does not need to block this patch.

Ok.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> > > +       /*
> > > +        * As IOMMUs are reset on shutdown, this will block device ac=
cess to memory.
> > > +        * Some devices get wedged if this happens, so reset to make =
sure it does not.
> > > +        */
> > > +       dev->config->reset(dev);
> > > +}
> > > +
> > >  static const struct bus_type virtio_bus =3D {
> > >         .name  =3D "virtio",
> > >         .match =3D virtio_dev_match,
> > > @@ -384,6 +414,7 @@ static const struct bus_type virtio_bus =3D {
> > >         .uevent =3D virtio_uevent,
> > >         .probe =3D virtio_dev_probe,
> > >         .remove =3D virtio_dev_remove,
> > > +       .shutdown =3D virtio_dev_shutdown,
> > >  };
> > >
> > >  int __register_virtio_driver(struct virtio_driver *driver, struct mo=
dule *owner)
> > > --
> > > MST
> > >
>


