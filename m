Return-Path: <linux-kernel+bounces-525047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5320AA3EA28
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4033BA94A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC2B1ADC98;
	Fri, 21 Feb 2025 01:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fr/TDDFe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B777192D96
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101828; cv=none; b=PXQgZpWbt6n7SQ0lfVgsgeBgE150WotB4b6pHkQr50spLFcISEwz4EbBGxrfDFXbVaO7asU63v/PFK8vNqeMIwL5+okkfCXYIs0u99KDT5fWZDcg/gwbnUuhFYlo6K3tDpGR1TEQeP+XyC8QRGJeQ2RRE3xmFAFsPrqn6+7iBLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101828; c=relaxed/simple;
	bh=0lgTIhJ/W8ZvGJamupVG+BpNT7q4Ut+GzjEnDq7q66Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeXWFryXAmVjvAcfufikaHVK6tzQA215ShUdJAi0vvYQlk+QGDlyH1OoAbfAj7mLIzb3LvaThiHhkdwF1Z1h+AlshFoKvyepGK/JxZcDPhs7hTSs1fTUin9Mr+po9vtCsDvu2Ny2yyTspOa9npH0HcA+kvej3KoKz8EmanwotJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fr/TDDFe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740101824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mu/6TYww2CF+OKFrEBrIeYBZqIuSZlhwqee7pcE4gAE=;
	b=fr/TDDFelU7efb4/UzgDDeXPhnfoyvKmHhYAs9OZQ8pAyQ96exEkMQLNnI4ljvEVDlTfzi
	snt0yQdgNau4e9b14E+qaZi0t+6FI7OgaKxtHFZbnqYbSQ622br35AimBGj8yTVTfaa7Ku
	EOP57N3DDGUrpH68qwO3lC7MWYI7p2Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-dHhAwnSkPXSQOVqe3KPm9A-1; Thu, 20 Feb 2025 20:37:03 -0500
X-MC-Unique: dHhAwnSkPXSQOVqe3KPm9A-1
X-Mimecast-MFC-AGG-ID: dHhAwnSkPXSQOVqe3KPm9A_1740101822
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5e08dfe235fso1787336a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740101822; x=1740706622;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mu/6TYww2CF+OKFrEBrIeYBZqIuSZlhwqee7pcE4gAE=;
        b=ws9lRJqa1HoaiIKnVXt5Tu3+WaOp0LqQ/Sr2yP9FIiuKkwbc38fSjkEwCMyJXbwcdQ
         or+O1gJtBPUe0YKJHMoG5CgoLAB5kkAuiSakmK+4yzd4H1Z7tl1iTPTb3VOscMUZ4IKz
         hAtJEnpkWEgreyVsPA507l+QRvwTmRRx8OqXb4t04IGBc45Tq+RUiSFkTJVsQBj3P34b
         arOSk9R7kWW/gom9Xq0mRMzy0pCaEK30X0m8NrrkaPFVTBny5XGA8TjiFwxE7t9TRAR5
         hNp3zxRjGfGbLOFMYzox0xD0bQCg2j4VBO54usXYdh/WwpHxYL+dB6DV1KB5i/X5AjUa
         TSVw==
X-Gm-Message-State: AOJu0YxIRoM8PeSbihlt3aqgES/xkd2wLoTFn8/SzoRHPFS5zc6jkkR7
	OxgO0Uo0TpFlOhfaQ3F2TiqXPF7rOwbMl7WoI55yHzeF6UwaZd6XR5T5WMi5bxLEm867UK/DdsQ
	TEeKAd9UsSwZS2nBCAmzp4bXxiQpzWjlR3sngOI1bZuXjsLflhWzmZzRO6pFXNQ==
X-Gm-Gg: ASbGncuwvT1I3O/JpwoJSLT/R04YgOoB1tyE/uecTrItUegai2CsASEOmgLe6bBli/M
	wwewBC4fMZM+hcrBme9OIvgw91HyUi0aEI59lT3B6v/d7BjZAzYdETq8oETcwgdCC1TQWEvJX05
	2cNlwWaa4nMwVVauj5VC0WabM0YPeNURtU/8jHTLoW2zZ89nniwauBnmTccM9u3908Noq4M1cKM
	StLoTA4IYRbTNdY6zT1z97Xl52JEAJ1NdlwGXxw00O04vN/meHae5qo6ZuVMenEYZ1NH5MvYg+W
	YWC0
X-Received: by 2002:a05:6402:348d:b0:5dc:7823:e7e4 with SMTP id 4fb4d7f45d1cf-5e0b70f8732mr832244a12.12.1740101822162;
        Thu, 20 Feb 2025 17:37:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFz/3ZI9S1ZBKYSKaIf/9/ImJu3ySJ3bUZkAYEGTF9kx/0kyVGHLCMk7qMBrVOD1kMJ9Ct66A==
X-Received: by 2002:a05:6402:348d:b0:5dc:7823:e7e4 with SMTP id 4fb4d7f45d1cf-5e0b70f8732mr832231a12.12.1740101821741;
        Thu, 20 Feb 2025 17:37:01 -0800 (PST)
Received: from redhat.com ([2.55.163.174])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1c58e2sm13020685a12.20.2025.02.20.17.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 17:37:00 -0800 (PST)
Date: Thu, 20 Feb 2025 20:36:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, Eric Auger <eauger@redhat.com>,
	Hongyu Ning <hongyu.ning@linux.intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] virtio: break and reset virtio devices on
 device_shutdown()
Message-ID: <20250220202425-mutt-send-email-mst@kernel.org>
References: <c1dbc7dbad9b445245d3348f19e6742b0be07347.1740094946.git.mst@redhat.com>
 <CACGkMEsK5Z_5B9Lz46kYYB_ndOG=CrvtZE_tLbRjL7=fT7OxbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsK5Z_5B9Lz46kYYB_ndOG=CrvtZE_tLbRjL7=fT7OxbQ@mail.gmail.com>

On Fri, Feb 21, 2025 at 09:11:51AM +0800, Jason Wang wrote:
> On Fri, Feb 21, 2025 at 7:42 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
> > accesses during the hang.
> >
> >         Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
> >         Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
> >         ...
> >
> > It was traced down to virtio-console. Kexec works fine if virtio-console
> > is not in use.
> >
> > The issue is that virtio-console continues to write to the MMIO even after
> > underlying virtio-pci device is reset.
> 
> Some of my questions were not answered so I need to post them again.
> 
> Do we need to fix vitio-console?

this fixes all devices so no.

> Note that we've already break the device in virtio_pci_remove():
> 
> static void virtio_pci_remove(struct pci_dev *pci_dev)
> {
>   struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
>         struct device *dev = get_device(&vp_dev->vdev.dev);
> 
>         /*
>          * Device is marked broken on surprise removal so that virtio upper
>          * layers can abort any ongoing operation.
>          */
>         if (!pci_device_is_present(pci_dev))
>                 virtio_break_device(&vp_dev->vdev);
> 
> ...


shutdown path does not invoke remove, and I do not want to,
since that will slow down reboots for no good reason.

> >
> > Additionally, Eric noticed that IOMMUs are reset before devices, if
> > devices are not reset on shutdown they continue to poke at guest memory
> > and get errors from the IOMMU. Some devices get wedged then.
> >
> > The problem can be solved by breaking all virtio devices on virtio
> > bus shutdown, then resetting them.
> >
> > Reported-by: Eric Auger <eauger@redhat.com>
> > Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/virtio/virtio.c | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index c1cc1157b380..e5b29520d3b2 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -377,6 +377,36 @@ static void virtio_dev_remove(struct device *_d)
> >         of_node_put(dev->dev.of_node);
> >  }
> >
> > +static void virtio_dev_shutdown(struct device *_d)
> > +{
> > +       struct virtio_device *dev = dev_to_virtio(_d);
> > +       struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> > +
> > +       /*
> > +        * Stop accesses to or from the device.
> > +        * We only need to do it if there's a driver - no accesses otherwise.
> > +        */
> > +       if (!drv)
> > +               return;
> > +
> > +       /*
> > +        * Some devices get wedged if you kick them after they are
> > +        * reset. Mark all vqs as broken to make sure we don't.
> > +        */
> > +       virtio_break_device(dev);
> > +       /*
> > +        * The below virtio_synchronize_cbs() guarantees that any interrupt
> > +        * for this line arriving after virtio_synchronize_vqs() has completed
> > +        * is guaranteed to see vq->broken as true.
> > +        */
> > +       virtio_synchronize_cbs(dev);
> 
> This looks like a partial re-introduction of the hardening work, but
> the ccw part is still in-completed e.g the synchronization requires a
> read_lock() and depends on CONFIG_VIRTIO_HARDEN_NOTIFICATION (which is
> marked as broken now).

Hmm I don't understand why we can not just take a subchannel lock.
worth thinking about it. as this doesn't regress i think
I can live with it for now.

> Should it better to
> 
> 1) fix the virtio-console

the problem is not unique to console. it was just observed there.
any device can trigger this.

> 2) simply rest in shutdown

then we are back with devices wedged as they are kicked
while reset.

> 3) wait for the hardening work to be done in the future?
> 
> Thanks

as users are seeing this on x86, I want to fix it.
finding a way to fix virtio_synchronize_cbs seems best.

does not need to block this patch.

> > +       /*
> > +        * As IOMMUs are reset on shutdown, this will block device access to memory.
> > +        * Some devices get wedged if this happens, so reset to make sure it does not.
> > +        */
> > +       dev->config->reset(dev);
> > +}
> > +
> >  static const struct bus_type virtio_bus = {
> >         .name  = "virtio",
> >         .match = virtio_dev_match,
> > @@ -384,6 +414,7 @@ static const struct bus_type virtio_bus = {
> >         .uevent = virtio_uevent,
> >         .probe = virtio_dev_probe,
> >         .remove = virtio_dev_remove,
> > +       .shutdown = virtio_dev_shutdown,
> >  };
> >
> >  int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)
> > --
> > MST
> >


