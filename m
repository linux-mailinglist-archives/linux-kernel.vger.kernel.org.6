Return-Path: <linux-kernel+bounces-516948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE77A37A11
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 04:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2300D1884F12
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 03:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFFD14D444;
	Mon, 17 Feb 2025 03:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHGsqRWU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9D514A8B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739762965; cv=none; b=MZjnVrrLndzBQoPXjB8YgMkv2TFuzIqeacaF3d8R9L0sG+4i/TaSQjw+HZ/lhYVC/AY9Amrsajt4o7fEfjTY1zzVCabIoTmoUZpgbzTrjCncZ0unyukUlFU+nVh4K9bU6R226Jb3Mb+8tszAj9QtopQfJqV+B/BUehX6vtVSINc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739762965; c=relaxed/simple;
	bh=gvjGreFfd3ywyP+BobAYK5BNOgggxOunKV0p9DGc8aY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dw2VXie1viKDWST2urZHIp9wfr0nryqOOfM4g9qBKKbO+rCRa0fkqd6CPSGdcaKbXdyoGMtSqolUF0HCD9xNboVxRzx2fIdJmghDFbsd58FzPFlk+iN7cQON35bryt6Nna85BRMF9SplhFIzXg3rjlgrrkLOhy/impm0K3AMXfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jHGsqRWU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739762962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hBMioyPyS9FgDAMVl0nh45eoQD5TEkmZ/tQviWSSO7s=;
	b=jHGsqRWUfLjDTttNeCxJQGxOXPPUXCVeZnx54WnKBgtxJKEP7h3wrI+DPvYsysXy3FDX7W
	+uc/uPpbHaLs8FrI/bHId/bGv91cukqQhyh0znMA2f1fIPIu/B8vHcoCQOLEjRqDo3Tyrq
	7nnwBgyQPY0gbM3LS2ckkDRgnx5FzIQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-KsXGDXWJMgi1KTc_Z815UA-1; Sun, 16 Feb 2025 22:29:21 -0500
X-MC-Unique: KsXGDXWJMgi1KTc_Z815UA-1
X-Mimecast-MFC-AGG-ID: KsXGDXWJMgi1KTc_Z815UA_1739762960
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc2f22f959so4808100a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 19:29:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739762960; x=1740367760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBMioyPyS9FgDAMVl0nh45eoQD5TEkmZ/tQviWSSO7s=;
        b=Rf2fULkMz1r/Zm1aqBT+00S13Fmc3Z5nHZpwaR4XBvn8xr8BI86ND12JEEunIOeU2R
         R1TYoDMPlTDebkK4faYl4XPHwSO+s5XeDYcQCoiEdllODty2700LObk4aUwtpY91HCjo
         hQiuDJ/+cqIVqLtDomoUVznYjG+M7UlhpOrf3oJAIFiE1AysJO7uZMxxxccJ4OOns1Se
         RpdbsMN+G2E7521YYf0Wnifel3Ke9CiuTtIlItA1SPHpo0ct0KfhZKrjTEJqUZhVEWju
         VzJZrKhxOSXC5adxKNzYtsl9X6d7jUmaWGG4xE3wvvECsAx51SzxavNFYYqk+MWrNWhD
         gOsw==
X-Forwarded-Encrypted: i=1; AJvYcCUhDRJfNhc8cpcoHhbeeSEuPdpxrgpiDx93t5DszvlWpqh92VbiC/LQxdlLZPRIXtBR29XO3KcP1LeE2+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9hCq4jimiwWjSuKonk/oIF8evZ8T7GOXwZK3inizgljYHWSjM
	BOuY01Mf3r8QljDf/SUSPKwRZ5aTzfm3QoVpcaT3Hg4t8Wy407jJ9EVmGbxE/y1OaJPdebaNmuT
	yaB5CZhVESLGEGx4C26zhVYnrxw+IdRH8WXIR6u4CwOfRR0+2X7GwzvnMTAgDCEbWvMJLNRzDTd
	suFKk7O847oMJKT47fRD/EfAThqbEYM72idsEI
X-Gm-Gg: ASbGncufxj1yYoOGt03c4D24Rq0kEIy8fPcpDFOZSPIuU5f44IavryJ26aMBHBWNExK
	snyzBMOuKPsdYTOWqjyameFcP4yOvsMiBM6jtC150DP88IwmVgUnWXGdbOBP9wV8=
X-Received: by 2002:a17:90b:1283:b0:2ee:c30f:33c9 with SMTP id 98e67ed59e1d1-2fc4076fa1cmr12824447a91.14.1739762959863;
        Sun, 16 Feb 2025 19:29:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUCDF2lIZkme+5vdswvB08CBiQ+x5mr6YXW/A1NxyzVdC4qsVGmmuK2S87hhPfviLjrP9FessucpsAECS9DKc=
X-Received: by 2002:a17:90b:1283:b0:2ee:c30f:33c9 with SMTP id
 98e67ed59e1d1-2fc4076fa1cmr12824409a91.14.1739762959237; Sun, 16 Feb 2025
 19:29:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
 <cc7312ca-2745-48a5-a5ac-9ee1d1c4bee0@redhat.com> <20250203094700-mutt-send-email-mst@kernel.org>
 <7cee3c9e-515e-41de-a15c-04c7591e83eb@redhat.com> <6bce0f4c-636f-456b-ab21-4a25d3dc8803@redhat.com>
 <90a09ffa-e316-41f0-916b-25635b1d4bc6@linux.intel.com> <83b43e73-8599-44ff-8657-6d5f2f9b2de5@redhat.com>
 <20250214070904-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250214070904-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Feb 2025 11:29:07 +0800
X-Gm-Features: AWEUYZlt_oyzDIg357m_PbrkoCgZL7VTQMbXBDtTMiaqiqCrLnAhrjzM9ZM3gyI
Message-ID: <CACGkMEsejG=6nj0YY7Wfzd1YBihoqn10PnhHtsVVdEOfPsgwNQ@mail.gmail.com>
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Auger <eauger@redhat.com>, "Ning, Hongyu" <hongyu.ning@linux.intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Zhenzhong Duan <zhenzhong.duan@intel.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 8:16=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Feb 14, 2025 at 08:56:56AM +0100, Eric Auger wrote:
> > Hi,
> >
> > On 2/14/25 8:21 AM, Ning, Hongyu wrote:
> > >
> > >
> > > On 2025/2/6 16:59, Eric Auger wrote:
> > >> Hi,
> > >>
> > >> On 2/4/25 12:46 PM, Eric Auger wrote:
> > >>> Hi,
> > >>>
> > >>> On 2/3/25 3:48 PM, Michael S. Tsirkin wrote:
> > >>>> On Fri, Jan 31, 2025 at 10:53:15AM +0100, Eric Auger wrote:
> > >>>>> Hi Kirill, Michael
> > >>>>>
> > >>>>> On 8/8/24 9:51 AM, Kirill A. Shutemov wrote:
> > >>>>>> Hongyu reported a hang on kexec in a VM. QEMU reported invalid m=
emory
> > >>>>>> accesses during the hang.
> > >>>>>>
> > >>>>>>     Invalid read at addr 0x102877002, size 2, region '(null)',
> > >>>>>> reason: rejected
> > >>>>>>     Invalid write at addr 0x102877A44, size 2, region '(null)',
> > >>>>>> reason: rejected
> > >>>>>>     ...
> > >>>>>>
> > >>>>>> It was traced down to virtio-console. Kexec works fine if virtio=
-
> > >>>>>> console
> > >>>>>> is not in use.
> > >>>>>>
> > >>>>>> Looks like virtio-console continues to write to the MMIO even af=
ter
> > >>>>>> underlying virtio-pci device is removed.
> > >>>>>>
> > >>>>>> The problem can be mitigated by removing all virtio devices on v=
irtio
> > >>>>>> bus shutdown.
> > >>>>>>
> > >>>>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.c=
om>
> > >>>>>> Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> > >>>>>
> > >>>>> Gentle ping on that patch that seems to have fallen though the cr=
acks.
> > >>>>>
> > >>>>> I think this fix is really needed. I have another test case with =
a
> > >>>>> rebooting guest exposed with virtio-net (backed by vhost-net) and
> > >>>>> viommu. Since there is currently no shutdown for the virtio-net, =
on
> > >>>>> reboot, the IOMMU is disabled through the native_machine_shutdown=
()/
> > >>>>> x86_platform.iommu_shutdown() while the virtio-net is still alive=
.
> > >>>>>
> > >>>>> Normally device_shutdown() should call virtio-net shutdown before=
 the
> > >>>>> IOMMU tear down and we wouldn't see any spurious transactions aft=
er
> > >>>>> iommu shutdown.
> > >>>>>
> > >>>>> With that fix, the above test case is fixed and I do not see spur=
ious
> > >>>>> vhost IOTLB miss spurious requests.
> > >>>>>
> > >>>>> For more details, see qemu thread ([PATCH] hw/virtio/vhost: Disab=
le
> > >>>>> IOTLB callbacks when IOMMU gets disabled,
> > >>>>> https://lore.kernel.org/all/20250120173339.865681-1-
> > >>>>> eric.auger@redhat.com/)
> > >>>>>
> > >>>>>
> > >>>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > >>>>> Tested-by: Eric Auger <eric.auger@redhat.com>
> > >>>>>
> > >>>>> Thanks
> > >>>>>
> > >>>>> Eric
> > >>>>>
> > >>>>>> ---
> > >>>>>>   drivers/virtio/virtio.c | 10 ++++++++++
> > >>>>>>   1 file changed, 10 insertions(+)
> > >>>>>>
> > >>>>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > >>>>>> index a9b93e99c23a..6c2f908eb22c 100644
> > >>>>>> --- a/drivers/virtio/virtio.c
> > >>>>>> +++ b/drivers/virtio/virtio.c
> > >>>>>> @@ -356,6 +356,15 @@ static void virtio_dev_remove(struct device=
 *_d)
> > >>>>>>       of_node_put(dev->dev.of_node);
> > >>>>>>   }
> > >>>>>>   +static void virtio_dev_shutdown(struct device *_d)
> > >>>>>> +{
> > >>>>>> +    struct virtio_device *dev =3D dev_to_virtio(_d);
> > >>>>>> +    struct virtio_driver *drv =3D drv_to_virtio(dev->dev.driver=
);
> > >>>>>> +
> > >>>>>> +    if (drv && drv->remove)
> > >>>>>> +        drv->remove(dev);
> > >>>>
> > >>>>
> > >>>> I am concerned that full remove is a heavyweight operation.
> > >>>> Do not want to slow down reboots even more.
> > >>>> How about just doing a reset, instead?
> > >>>
> > >>> I tested with
> > >>>
> > >>> static void virtio_dev_shutdown(struct device *_d)
> > >>> {
> > >>>          struct virtio_device *dev =3D dev_to_virtio(_d);
> > >>>
> > >>>          virtio_reset_device(dev);
> > >>> }
> > >>>
> > >>>
> > >>> and it fixes my issue.
> > >>>
> > >>> Kirill, would that fix you issue too?
> > >
> > > Hi,
> > >
> > > sorry for my late response, I synced with Kirill offline and did a re=
test.
> > >
> > > The issue is still reproduced on my side, kexec will be stuck in case=
 of
> > > "console=3Dhvc0" append in kernel cmdline and even with such patch ap=
plied.
> >
> > Thanks for testing!
> >
> > Michael, it looks like the initial patch from Kyrill is the one that
> > fixes both issues. virtio_reset_device() usage does not work for the
> > initial bug report while it works for me. Other ideas?
> >
> > Thanks
> >
> > Eric
>
> Ah, wait a second.
>
> Looks like virtio-console continues to write to the MMIO even after
> underlying virtio-pci device is removed.

Where is such code? I think the virtcons_remove() is called so the
console is unregistered from the subsystem.

Or for surprise removal, we have break the device in:

static void virtio_pci_remove(struct pci_dev *pci_dev)
{
        struct virtio_pci_device *vp_dev =3D pci_get_drvdata(pci_dev);
        struct device *dev =3D get_device(&vp_dev->vdev.dev);

        /*
         * Device is marked broken on surprise removal so that virtio upper
         * layers can abort any ongoing operation.
         */
        if (!pci_device_is_present(pci_dev))
                virtio_break_device(&vp_dev->vdev);


>
> Hmm. I am not sure why that is a problem, but I assume some hypervisors j=
ust
> hang the system if you try to kick them after reset.
> Unfortunate that spec did not disallow it.
>
> If we want to prevent that, we want to do something like this:
>
>
>         /*
>          * Some devices get wedged if you kick them after they are
>          * reset. Mark all vqs as broken to make sure we don't.
>          */
>         virtio_break_device(dev);
>         /*
>          * The below virtio_synchronize_cbs() guarantees that any
>          * interrupt for this line arriving after
>          * virtio_synchronize_vqs() has completed is guaranteed to see
>          * vq->broken as true.
>          */
>         virtio_synchronize_cbs(dev);

This seems to relate to doing this when we reintroduce the
notification hardening.

>         dev->config->reset(dev);
>
>
> I assume this still works for you, yes?
>

Thanks

>
>
> > >
> > > my kernel code base is 6.14.0-rc2.
> > >
> > > let me know if any more experiments needed.
> > >
> > > ---
> > >  drivers/virtio/virtio.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > index ba37665188b5..f9f885d04763 100644
> > > --- a/drivers/virtio/virtio.c
> > > +++ b/drivers/virtio/virtio.c
> > > @@ -395,6 +395,13 @@ static const struct cpumask
> > > *virtio_irq_get_affinity(struct device *_d,
> > >         return dev->config->get_vq_affinity(dev, irq_vec);
> > >  }
> > >
> > > +static void virtio_dev_shutdown(struct device *_d)
> > > +{
> > > +        struct virtio_device *dev =3D dev_to_virtio(_d);
> > > +
> > > +        virtio_reset_device(dev);
> > > +}
> > > +
> > >  static const struct bus_type virtio_bus =3D {
> > >         .name  =3D "virtio",
> > >         .match =3D virtio_dev_match,
> > > @@ -403,6 +410,7 @@ static const struct bus_type virtio_bus =3D {
> > >         .probe =3D virtio_dev_probe,
> > >         .remove =3D virtio_dev_remove,
> > >         .irq_get_affinity =3D virtio_irq_get_affinity,
> > > +       .shutdown =3D virtio_dev_shutdown,
> > >  };
> > >
> > >  int __register_virtio_driver(struct virtio_driver *driver, struct
> > > module *owner)
> > > --
> > > 2.43.0
> > >
> > >
> > >> gentle ping.
> > >>
> > >> this also fixes another issue with qemu vSMMU + virtio-scsi-pci. Wit=
h
> > >> the above addition I get rid of spurious warning in qemu on guest re=
boot.
> > >>
> > >> qemu-system-aarch64: virtio: zero sized buffers are not allowed
> > >> qemu-system-aarch64: vhost vring error in virtqueue 0: Invalid
> > >> argument (22)
> > >>
> > >> Would you mind if I respin?
> > >>
> > >> Thanks
> > >>
> > >> Eric
> > >>
> > >>
> > >>
> > >>
> > >>>
> > >>> Thanks
> > >>>
> > >>> Eric
> > >>>>
> > >>>>>> +}
> > >>>>>> +
> > >>>>>>   static const struct bus_type virtio_bus =3D {
> > >>>>>>       .name  =3D "virtio",
> > >>>>>>       .match =3D virtio_dev_match,
> > >>>>>> @@ -363,6 +372,7 @@ static const struct bus_type virtio_bus =3D =
{
> > >>>>>>       .uevent =3D virtio_uevent,
> > >>>>>>       .probe =3D virtio_dev_probe,
> > >>>>>>       .remove =3D virtio_dev_remove,
> > >>>>>> +    .shutdown =3D virtio_dev_shutdown,
> > >>>>>>   };
> > >>>>>>     int __register_virtio_driver(struct virtio_driver *driver,
> > >>>>>> struct module *owner)
> > >>>>
> > >>>
> > >>
> > >
>


