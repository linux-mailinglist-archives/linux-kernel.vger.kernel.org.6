Return-Path: <linux-kernel+bounces-518487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8BDA38FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 01:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75BA73AECD1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 00:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4184D2563;
	Tue, 18 Feb 2025 00:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="En5gsq3v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F912ECF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 00:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739837564; cv=none; b=t3Nw974RW3CfQ7xD2yzIdi07cu0QaYccN4VkDMDZH29GyBLmPhHg156uR9guQp3w+XbZt6Od9Ed/erQMzQi/xvZmaUm4mEwTr0uLj/XKHpw75fqnzoAQ6CW19xA8SV97B5Qz26xyi5VPIf8dKBv25YMZBS5vm0elsWwwuqIzb/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739837564; c=relaxed/simple;
	bh=uC8cKZgH5jtMxAMxHIrCMiEUZs5Vp6M4wFq3dcuatR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6XgJDsy1iHhMTbIugFKUNMKRg1wKnS8N7Bw/P7jfvL4//nvCZwMfEeSuJ05S2N9EFmEzehDHRAla7j7VeUzjO0fY3qt9MVDOcmQLwTNMHq4ZEGkFDFgShCnxMZTZWaul8oAMuZ2Pwg2ct/sOg/AyM3khthuHfOdOaCZQQxpthM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=En5gsq3v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739837561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B02gyojDUiuYtKrTl8LJtiDNK23qLyYF7c8avrsDEN4=;
	b=En5gsq3vzEN11EdmzkQ08n/+erybo1yl9eQ5mimlZMpDmuM4plZsTc48mGNFFzUIwlTG4g
	fz9ljOL0lLoza9YqQAVWlMrzknZvKCF1MsNVFz47XImRTcflky3rzHzLuVc2CfDkHyitIl
	m6D/JI8UzgdwvMzKoBaBzQOhDZBtvDY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-DA3lysBnMX6Gjn9Mm7LL7g-1; Mon, 17 Feb 2025 19:12:39 -0500
X-MC-Unique: DA3lysBnMX6Gjn9Mm7LL7g-1
X-Mimecast-MFC-AGG-ID: DA3lysBnMX6Gjn9Mm7LL7g_1739837559
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4394c489babso26142315e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:12:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739837558; x=1740442358;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B02gyojDUiuYtKrTl8LJtiDNK23qLyYF7c8avrsDEN4=;
        b=T4vZM4sMYwKrGJecylMeGRMLrjE1x35YDAd1pTHp4w5rrELHfL2ULu5gvzbz1IfPF4
         S744X4FCbt+z4TmvjD1lqRB8nMrSV2pOE0Vm/HF1Q4mNdObf2Yick7WWYQ0XlYtOf5CR
         CqekNwatyizaqmnWcep6OqrRKmm2izs3PWZ9SKkZWpXLKALvrpj2orfqFcJGnxc+TRFq
         +0310dcHmn5RgrsIsMbMik6gR4mY5UMu5HF2d/+Z8BqHdX5VwcSg8SAddkoDzYg04VsD
         rDK5tQNA7N6P1dginKkrifH7+m0pj4OLlGFXyBCdiW6/Fo85cn1PeRqWmmyRRO+uN4b5
         BPCg==
X-Forwarded-Encrypted: i=1; AJvYcCXKxpAnDDN6fXwn/j8agDapBmnZaaekq1Y8lVrN4pfK6CCaM+9MYL+AxZnRYCLLIXTK/piJOaxV4kPCGzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP8ToU86bdvPJAdrBA71VjrlIqVGQQAqWz5Whn2Vd2W9pidHK7
	5msh9vr2h7L4wJPOu/aQfai7UEoCgH9zagxLvGMyY5Hp59KJoqsiS1EPYZz2TYD6WcyR+lO0VB5
	Gd3bMPjeZG1Zr4FaoNZCey//EMPKsMetzg3QvuJRCdkA7lBgkkYRsXyAkttgFwQ==
X-Gm-Gg: ASbGncthAsasNKOYiDSAaSV4ApSfhnx+4g7+GczupmydmCNcFBEhGgTUXXqcpGPlVOj
	agugxfh+Rqq7DhVd0ejdyRoA2XIRAvxAMdI+ar5f+DEEeVjNLP7ys5hPN0Ykz2v531mGClS6KHQ
	znBWa03sIISnXzbvJfKlRe72pTMM7etoyE23LEFfQ2VLYB8NMbbNO13FPvzUNTMsybnurhKqLAW
	LrEDGIHixsXYg2vNsdXXyWtnHNN3ehST3d7Run+ZnShxWBakT9pY604XKVnShvbMfQiYhM=
X-Received: by 2002:a05:600c:a014:b0:439:8340:637 with SMTP id 5b1f17b1804b1-439861fdba3mr42542965e9.30.1739837558453;
        Mon, 17 Feb 2025 16:12:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5kjO9h+qY7R0mzmILuEK/JSqwr6CGQLnkfN78PWHYwp+tnpQVFFvr841liMidGooiybCi0g==
X-Received: by 2002:a05:600c:a014:b0:439:8340:637 with SMTP id 5b1f17b1804b1-439861fdba3mr42542725e9.30.1739837557989;
        Mon, 17 Feb 2025 16:12:37 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f5:7ef9:8f0d:a8:10c1:4db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439858ec5fasm39352515e9.29.2025.02.17.16.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 16:12:37 -0800 (PST)
Date: Mon, 17 Feb 2025 19:12:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
Cc: Eric Auger <eauger@redhat.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
Message-ID: <20250217191103-mutt-send-email-mst@kernel.org>
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
 <cc7312ca-2745-48a5-a5ac-9ee1d1c4bee0@redhat.com>
 <20250203094700-mutt-send-email-mst@kernel.org>
 <7cee3c9e-515e-41de-a15c-04c7591e83eb@redhat.com>
 <6bce0f4c-636f-456b-ab21-4a25d3dc8803@redhat.com>
 <90a09ffa-e316-41f0-916b-25635b1d4bc6@linux.intel.com>
 <83b43e73-8599-44ff-8657-6d5f2f9b2de5@redhat.com>
 <20250214070904-mutt-send-email-mst@kernel.org>
 <a48ec78d-a86f-4332-87d0-e6071f72a7d1@redhat.com>
 <ee89c12c-a252-4c6d-a062-4fb57f2c85a9@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee89c12c-a252-4c6d-a062-4fb57f2c85a9@linux.intel.com>

On Tue, Feb 18, 2025 at 07:57:23AM +0800, Ning, Hongyu wrote:
> 
> 
> On 2025/2/17 17:25, Eric Auger wrote:
> > Hi Michael, Hongyu,
> > 
> > On 2/14/25 1:16 PM, Michael S. Tsirkin wrote:
> > > On Fri, Feb 14, 2025 at 08:56:56AM +0100, Eric Auger wrote:
> > > > Hi,
> > > > 
> > > > On 2/14/25 8:21 AM, Ning, Hongyu wrote:
> > > > > 
> > > > > 
> > > > > On 2025/2/6 16:59, Eric Auger wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > On 2/4/25 12:46 PM, Eric Auger wrote:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > On 2/3/25 3:48 PM, Michael S. Tsirkin wrote:
> > > > > > > > On Fri, Jan 31, 2025 at 10:53:15AM +0100, Eric Auger wrote:
> > > > > > > > > Hi Kirill, Michael
> > > > > > > > > 
> > > > > > > > > On 8/8/24 9:51 AM, Kirill A. Shutemov wrote:
> > > > > > > > > > Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
> > > > > > > > > > accesses during the hang.
> > > > > > > > > > 
> > > > > > > > > >      Invalid read at addr 0x102877002, size 2, region '(null)',
> > > > > > > > > > reason: rejected
> > > > > > > > > >      Invalid write at addr 0x102877A44, size 2, region '(null)',
> > > > > > > > > > reason: rejected
> > > > > > > > > >      ...
> > > > > > > > > > 
> > > > > > > > > > It was traced down to virtio-console. Kexec works fine if virtio-
> > > > > > > > > > console
> > > > > > > > > > is not in use.
> > > > > > > > > > 
> > > > > > > > > > Looks like virtio-console continues to write to the MMIO even after
> > > > > > > > > > underlying virtio-pci device is removed.
> > > > > > > > > > 
> > > > > > > > > > The problem can be mitigated by removing all virtio devices on virtio
> > > > > > > > > > bus shutdown.
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > > > > > > > Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> > > > > > > > > 
> > > > > > > > > Gentle ping on that patch that seems to have fallen though the cracks.
> > > > > > > > > 
> > > > > > > > > I think this fix is really needed. I have another test case with a
> > > > > > > > > rebooting guest exposed with virtio-net (backed by vhost-net) and
> > > > > > > > > viommu. Since there is currently no shutdown for the virtio-net, on
> > > > > > > > > reboot, the IOMMU is disabled through the native_machine_shutdown()/
> > > > > > > > > x86_platform.iommu_shutdown() while the virtio-net is still alive.
> > > > > > > > > 
> > > > > > > > > Normally device_shutdown() should call virtio-net shutdown before the
> > > > > > > > > IOMMU tear down and we wouldn't see any spurious transactions after
> > > > > > > > > iommu shutdown.
> > > > > > > > > 
> > > > > > > > > With that fix, the above test case is fixed and I do not see spurious
> > > > > > > > > vhost IOTLB miss spurious requests.
> > > > > > > > > 
> > > > > > > > > For more details, see qemu thread ([PATCH] hw/virtio/vhost: Disable
> > > > > > > > > IOTLB callbacks when IOMMU gets disabled,
> > > > > > > > > https://lore.kernel.org/all/20250120173339.865681-1-
> > > > > > > > > eric.auger@redhat.com/)
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > > > > > > > > Tested-by: Eric Auger <eric.auger@redhat.com>
> > > > > > > > > 
> > > > > > > > > Thanks
> > > > > > > > > 
> > > > > > > > > Eric
> > > > > > > > > 
> > > > > > > > > > ---
> > > > > > > > > >    drivers/virtio/virtio.c | 10 ++++++++++
> > > > > > > > > >    1 file changed, 10 insertions(+)
> > > > > > > > > > 
> > > > > > > > > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > > > > > > > > index a9b93e99c23a..6c2f908eb22c 100644
> > > > > > > > > > --- a/drivers/virtio/virtio.c
> > > > > > > > > > +++ b/drivers/virtio/virtio.c
> > > > > > > > > > @@ -356,6 +356,15 @@ static void virtio_dev_remove(struct device *_d)
> > > > > > > > > >        of_node_put(dev->dev.of_node);
> > > > > > > > > >    }
> > > > > > > > > >    +static void virtio_dev_shutdown(struct device *_d)
> > > > > > > > > > +{
> > > > > > > > > > +    struct virtio_device *dev = dev_to_virtio(_d);
> > > > > > > > > > +    struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> > > > > > > > > > +
> > > > > > > > > > +    if (drv && drv->remove)
> > > > > > > > > > +        drv->remove(dev);
> > > > > > > > 
> > > > > > > > 
> > > > > > > > I am concerned that full remove is a heavyweight operation.
> > > > > > > > Do not want to slow down reboots even more.
> > > > > > > > How about just doing a reset, instead?
> > > > > > > 
> > > > > > > I tested with
> > > > > > > 
> > > > > > > static void virtio_dev_shutdown(struct device *_d)
> > > > > > > {
> > > > > > >           struct virtio_device *dev = dev_to_virtio(_d);
> > > > > > > 
> > > > > > >           virtio_reset_device(dev);
> > > > > > > }
> > > > > > > 
> > > > > > > 
> > > > > > > and it fixes my issue.
> > > > > > > 
> > > > > > > Kirill, would that fix you issue too?
> > > > > 
> > > > > Hi,
> > > > > 
> > > > > sorry for my late response, I synced with Kirill offline and did a retest.
> > > > > 
> > > > > The issue is still reproduced on my side, kexec will be stuck in case of
> > > > > "console=hvc0" append in kernel cmdline and even with such patch applied.
> > > > 
> > > > Thanks for testing!
> > > > 
> > > > Michael, it looks like the initial patch from Kyrill is the one that
> > > > fixes both issues. virtio_reset_device() usage does not work for the
> > > > initial bug report while it works for me. Other ideas?
> > > > 
> > > > Thanks
> > > > 
> > > > Eric
> > > 
> > > Ah, wait a second.
> > > 
> > > Looks like virtio-console continues to write to the MMIO even after
> > > underlying virtio-pci device is removed.
> > > 
> > > Hmm. I am not sure why that is a problem, but I assume some hypervisors just
> > > hang the system if you try to kick them after reset.
> > > Unfortunate that spec did not disallow it.
> > > 
> > > If we want to prevent that, we want to do something like this:
> > > 
> > > 
> > > 	/*
> > > 	 * Some devices get wedged if you kick them after they are
> > > 	 * reset. Mark all vqs as broken to make sure we don't.
> > > 	 */
> > >          virtio_break_device(dev);
> > >          /*
> > >           * The below virtio_synchronize_cbs() guarantees that any
> > >           * interrupt for this line arriving after
> > >           * virtio_synchronize_vqs() has completed is guaranteed to see
> > >           * vq->broken as true.
> > >           */
> > >          virtio_synchronize_cbs(dev);
> > >          dev->config->reset(dev);
> > > 
> > > 
> > > I assume this still works for you, yes?
> > Would that still been done in the virtio_dev_shutdown()?
> > 
> > Is that what you tested Hongyu?
> 
> Hi Eric,
> 
> my patch applied based on Michael's comments:
> 
> ---
>  drivers/virtio/virtio.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index ba37665188b5..458dc28be060 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -395,6 +395,25 @@ static const struct cpumask
> *virtio_irq_get_affinity(struct device *_d,
>         return dev->config->get_vq_affinity(dev, irq_vec);
>  }
> 
> +static void virtio_dev_shutdown(struct device *_d)
> +{
> +        struct virtio_device *dev = dev_to_virtio(_d);
> +        /*
> +         * Some devices get wedged if you kick them after they are
> +         * reset. Mark all vqs as broken to make sure we don't.
> +         */
> +        virtio_break_device(dev);
> +        /*
> +         * The below virtio_synchronize_cbs() guarantees that any
> +         * interrupt for this line arriving after
> +         * virtio_synchronize_vqs() has completed is guaranteed to see
> +         * vq->broken as true.
> +         */
> +        virtio_synchronize_cbs(dev);
> +        dev->config->reset(dev);
> +       //virtio_reset_device(dev);
> +}
> +
>  static const struct bus_type virtio_bus = {
>         .name  = "virtio",
>         .match = virtio_dev_match,
> @@ -403,6 +422,7 @@ static const struct bus_type virtio_bus = {
>         .probe = virtio_dev_probe,
>         .remove = virtio_dev_remove,
>         .irq_get_affinity = virtio_irq_get_affinity,
> +       .shutdown = virtio_dev_shutdown,
>  };
> 
>  int __register_virtio_driver(struct virtio_driver *driver, struct module
> *owner)
> --
> 2.43.0



yes, that's the patch. Does it work for you? Addresses the
problem? If yes I'll repost.

> 
> > 
> > Eric
> > > 
> > > 
> > > 
> > > > > 
> > > > > my kernel code base is 6.14.0-rc2.
> > > > > 
> > > > > let me know if any more experiments needed.
> > > > > 
> > > > > ---
> > > > >   drivers/virtio/virtio.c | 8 ++++++++
> > > > >   1 file changed, 8 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > > > index ba37665188b5..f9f885d04763 100644
> > > > > --- a/drivers/virtio/virtio.c
> > > > > +++ b/drivers/virtio/virtio.c
> > > > > @@ -395,6 +395,13 @@ static const struct cpumask
> > > > > *virtio_irq_get_affinity(struct device *_d,
> > > > >          return dev->config->get_vq_affinity(dev, irq_vec);
> > > > >   }
> > > > > 
> > > > > +static void virtio_dev_shutdown(struct device *_d)
> > > > > +{
> > > > > +        struct virtio_device *dev = dev_to_virtio(_d);
> > > > > +
> > > > > +        virtio_reset_device(dev);
> > > > > +}
> > > > > +
> > > > >   static const struct bus_type virtio_bus = {
> > > > >          .name  = "virtio",
> > > > >          .match = virtio_dev_match,
> > > > > @@ -403,6 +410,7 @@ static const struct bus_type virtio_bus = {
> > > > >          .probe = virtio_dev_probe,
> > > > >          .remove = virtio_dev_remove,
> > > > >          .irq_get_affinity = virtio_irq_get_affinity,
> > > > > +       .shutdown = virtio_dev_shutdown,
> > > > >   };
> > > > > 
> > > > >   int __register_virtio_driver(struct virtio_driver *driver, struct
> > > > > module *owner)
> > > > > -- 
> > > > > 2.43.0
> > > > > 
> > > > > 
> > > > > > gentle ping.
> > > > > > 
> > > > > > this also fixes another issue with qemu vSMMU + virtio-scsi-pci. With
> > > > > > the above addition I get rid of spurious warning in qemu on guest reboot.
> > > > > > 
> > > > > > qemu-system-aarch64: virtio: zero sized buffers are not allowed
> > > > > > qemu-system-aarch64: vhost vring error in virtqueue 0: Invalid
> > > > > > argument (22)
> > > > > > 
> > > > > > Would you mind if I respin?
> > > > > > 
> > > > > > Thanks
> > > > > > 
> > > > > > Eric
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > Thanks
> > > > > > > 
> > > > > > > Eric
> > > > > > > > 
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >    static const struct bus_type virtio_bus = {
> > > > > > > > > >        .name  = "virtio",
> > > > > > > > > >        .match = virtio_dev_match,
> > > > > > > > > > @@ -363,6 +372,7 @@ static const struct bus_type virtio_bus = {
> > > > > > > > > >        .uevent = virtio_uevent,
> > > > > > > > > >        .probe = virtio_dev_probe,
> > > > > > > > > >        .remove = virtio_dev_remove,
> > > > > > > > > > +    .shutdown = virtio_dev_shutdown,
> > > > > > > > > >    };
> > > > > > > > > >      int __register_virtio_driver(struct virtio_driver *driver,
> > > > > > > > > > struct module *owner)
> > > > > > > > 
> > > > > > > 
> > > > > > 
> > > > > 
> > > 
> > 
> > 


