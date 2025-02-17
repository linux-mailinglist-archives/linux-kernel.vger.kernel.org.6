Return-Path: <linux-kernel+bounces-514919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F611A35D58
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D9C3A7621
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD9A263C86;
	Fri, 14 Feb 2025 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egZvpCyS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E674725A654
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739535400; cv=none; b=Dj4JXen88aPt95dcJ9ssicFDhXayI8z51bej6JmgdNTNxb1apFKPM0BL2iKgVmZyi7DF3LFWutJl/k5cW/mpXeI5MlwG7WX2E1W8xMQtS6btizMQefLO3eTrjpZLfHNbU67bzQUNyJ1XTcotX/LkQmO6FJAQvngnpDCg8QXkyRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739535400; c=relaxed/simple;
	bh=/o8fcaoZZy95Ve/jJBOP4FiNXTZNLQeMk1Fa6jY4dMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzaJFiiH1MWo9Mjl1TOYFaTRs2exyiR3V9BTJhXHpPoikC0e2tSyl0JpBhxeEbXXn14qpmpbgyU9eXnZaXbeDwM1SpGF9xKKg8+8gemZTh742hUe4sdtmdKhgPWViP2IqVC57ElgdpiwhZ3uDWoCm9w4p5nKegLI3oUVHWXb4EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=egZvpCyS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739535397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UA+7Z+yJbgdcOkkvDK35ReVebQSawPFeyqsCedXlO0E=;
	b=egZvpCySG0l0NyzZqc1UpMWKA2UTAPMtpuaf73ppYiVWnLu2sW7QCX3HZqsemOn+ses5Pz
	J3CFsnErQr5Tzskl8e62cQoYxx8X7frVNaLe5Gw8PV9XufC8Tqi81IMPrG/lTGzuF33029
	Laq4BDm06aC8OQtkMKNPq8WaSC+hPOw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-LK-OaCMNOeSNhZ-ctFB2vQ-1; Fri, 14 Feb 2025 07:16:36 -0500
X-MC-Unique: LK-OaCMNOeSNhZ-ctFB2vQ-1
X-Mimecast-MFC-AGG-ID: LK-OaCMNOeSNhZ-ctFB2vQ_1739535395
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ab77dd2c243so261326066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:16:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739535395; x=1740140195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UA+7Z+yJbgdcOkkvDK35ReVebQSawPFeyqsCedXlO0E=;
        b=qfZXMp1N75vnPeuFtRW/++voTzI09Ch0+wR3QKsreU3LQsq1rB8uHxjp16/zVnhs52
         qH5VDwFAgsiS5TCu0Bzi06p/3zBAN6akXAiK8MDm7Mxb8PlGTqmPXLjL7fifx0I2U965
         Zm17WPSLui0GJZNTw53wh9V8XQhVAq4+dRUkRv25eP4kkuCg3tKTloO+02YxtAdsk+92
         sttD+xS0yk9QwHtAekyetP+17wGHlvTOvCAWQ/+pPG4lb1hN75B7gsSAd6Gm4zpr49gv
         80hpsK8U21ETlz6KFYzCVhmt100GYNyw2hYaOPhxV131dMxlw3vdTfvgHvb5tTvUZyKT
         NFkg==
X-Forwarded-Encrypted: i=1; AJvYcCVLZLYZAf9TImfwRT7EID8O6Nlj6s1aWDQqqfP5jvwuUHOFLTRxrKPFUj07tumpoABdX0bQQanQsw66Agc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSzMhWaqy96kb0xJeYsV+ipGiJE6sKzeNaSWkT0seeuLdVp4ym
	piHmyiSR68cHCuMzDD6oszyVvRqQBItmNDoxeTBFWqTZvcH9e0jSCHfEbCfCVN4clsdJk3ecFGc
	YejXD/sKMEKO9vvgfGqLP30lCBidErjNsHZsz3e3X4XmmOW53YeDM2D1uo0ilDA==
X-Gm-Gg: ASbGncu5SmNxn0+4z59E5UA7lZKhbzMV7MOtte5pgdcDyxz6sWZcD91MgHvapq15nn6
	2AQk07aOFZ46rkklZRMTt9nelfu1XlS3ozhSNkqeDk9jQPDU4D++qYBewRshVwQd9SsAjdtHIiZ
	ZvNODOfjpvcjiCxIFU997bgxRUUIfloajIBqgFr8t3fd7inhAYavneNNx/o4pMkR1KoMzQyVR7i
	NPCkk4dfUpQmc0MFRU2U9SV59pwsIDjCEtjFBhXhvMzQZIWTkOrXylGcP2E+qDZ9we/vQ==
X-Received: by 2002:a17:907:d15:b0:aa6:9503:aa73 with SMTP id a640c23a62f3a-aba501bc5admr737240066b.51.1739535395118;
        Fri, 14 Feb 2025 04:16:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzflie8j7cMepDFh5VNqCOhDNeSL2Ik5idlR4ZEhXPbKFLX9WkajJhHZ7aepnfCQqle/r6yA==
X-Received: by 2002:a17:907:d15:b0:aa6:9503:aa73 with SMTP id a640c23a62f3a-aba501bc5admr737236866b.51.1739535394691;
        Fri, 14 Feb 2025 04:16:34 -0800 (PST)
Received: from redhat.com ([2.55.187.107])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532322dbsm336512866b.10.2025.02.14.04.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:16:33 -0800 (PST)
Date: Fri, 14 Feb 2025 07:16:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eauger@redhat.com>
Cc: "Ning, Hongyu" <hongyu.ning@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
Message-ID: <20250214070904-mutt-send-email-mst@kernel.org>
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
 <cc7312ca-2745-48a5-a5ac-9ee1d1c4bee0@redhat.com>
 <20250203094700-mutt-send-email-mst@kernel.org>
 <7cee3c9e-515e-41de-a15c-04c7591e83eb@redhat.com>
 <6bce0f4c-636f-456b-ab21-4a25d3dc8803@redhat.com>
 <90a09ffa-e316-41f0-916b-25635b1d4bc6@linux.intel.com>
 <83b43e73-8599-44ff-8657-6d5f2f9b2de5@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83b43e73-8599-44ff-8657-6d5f2f9b2de5@redhat.com>

On Fri, Feb 14, 2025 at 08:56:56AM +0100, Eric Auger wrote:
> Hi,
> 
> On 2/14/25 8:21 AM, Ning, Hongyu wrote:
> > 
> > 
> > On 2025/2/6 16:59, Eric Auger wrote:
> >> Hi,
> >>
> >> On 2/4/25 12:46 PM, Eric Auger wrote:
> >>> Hi,
> >>>
> >>> On 2/3/25 3:48 PM, Michael S. Tsirkin wrote:
> >>>> On Fri, Jan 31, 2025 at 10:53:15AM +0100, Eric Auger wrote:
> >>>>> Hi Kirill, Michael
> >>>>>
> >>>>> On 8/8/24 9:51 AM, Kirill A. Shutemov wrote:
> >>>>>> Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
> >>>>>> accesses during the hang.
> >>>>>>
> >>>>>> ����Invalid read at addr 0x102877002, size 2, region '(null)',
> >>>>>> reason: rejected
> >>>>>> ����Invalid write at addr 0x102877A44, size 2, region '(null)',
> >>>>>> reason: rejected
> >>>>>> ����...
> >>>>>>
> >>>>>> It was traced down to virtio-console. Kexec works fine if virtio-
> >>>>>> console
> >>>>>> is not in use.
> >>>>>>
> >>>>>> Looks like virtio-console continues to write to the MMIO even after
> >>>>>> underlying virtio-pci device is removed.
> >>>>>>
> >>>>>> The problem can be mitigated by removing all virtio devices on virtio
> >>>>>> bus shutdown.
> >>>>>>
> >>>>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >>>>>> Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> >>>>>
> >>>>> Gentle ping on that patch that seems to have fallen though the cracks.
> >>>>>
> >>>>> I think this fix is really needed. I have another test case with a
> >>>>> rebooting guest exposed with virtio-net (backed by vhost-net) and
> >>>>> viommu. Since there is currently no shutdown for the virtio-net, on
> >>>>> reboot, the IOMMU is disabled through the native_machine_shutdown()/
> >>>>> x86_platform.iommu_shutdown() while the virtio-net is still alive.
> >>>>>
> >>>>> Normally device_shutdown() should call virtio-net shutdown before the
> >>>>> IOMMU tear down and we wouldn't see any spurious transactions after
> >>>>> iommu shutdown.
> >>>>>
> >>>>> With that fix, the above test case is fixed and I do not see spurious
> >>>>> vhost IOTLB miss spurious requests.
> >>>>>
> >>>>> For more details, see qemu thread ([PATCH] hw/virtio/vhost: Disable
> >>>>> IOTLB callbacks when IOMMU gets disabled,
> >>>>> https://lore.kernel.org/all/20250120173339.865681-1-
> >>>>> eric.auger@redhat.com/)
> >>>>>
> >>>>>
> >>>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> >>>>> Tested-by: Eric Auger <eric.auger@redhat.com>
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>> Eric
> >>>>>
> >>>>>> ---
> >>>>>> � drivers/virtio/virtio.c | 10 ++++++++++
> >>>>>> � 1 file changed, 10 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> >>>>>> index a9b93e99c23a..6c2f908eb22c 100644
> >>>>>> --- a/drivers/virtio/virtio.c
> >>>>>> +++ b/drivers/virtio/virtio.c
> >>>>>> @@ -356,6 +356,15 @@ static void virtio_dev_remove(struct device *_d)
> >>>>>> ����� of_node_put(dev->dev.of_node);
> >>>>>> � }
> >>>>>> � +static void virtio_dev_shutdown(struct device *_d)
> >>>>>> +{
> >>>>>> +��� struct virtio_device *dev = dev_to_virtio(_d);
> >>>>>> +��� struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> >>>>>> +
> >>>>>> +��� if (drv && drv->remove)
> >>>>>> +������� drv->remove(dev);
> >>>>
> >>>>
> >>>> I am concerned that full remove is a heavyweight operation.
> >>>> Do not want to slow down reboots even more.
> >>>> How about just doing a reset, instead?
> >>>
> >>> I tested with
> >>>
> >>> static void virtio_dev_shutdown(struct device *_d)
> >>> {
> >>> �������� struct virtio_device *dev = dev_to_virtio(_d);
> >>>
> >>> �������� virtio_reset_device(dev);
> >>> }
> >>>
> >>>
> >>> and it fixes my issue.
> >>>
> >>> Kirill, would that fix you issue too?
> > 
> > Hi,
> > 
> > sorry for my late response, I synced with Kirill offline and did a retest.
> > 
> > The issue is still reproduced on my side, kexec will be stuck in case of
> > "console=hvc0" append in kernel cmdline and even with such patch applied.
> 
> Thanks for testing!
> 
> Michael, it looks like the initial patch from Kyrill is the one that
> fixes both issues. virtio_reset_device() usage does not work for the
> initial bug report while it works for me. Other ideas?
> 
> Thanks
> 
> Eric

Ah, wait a second.

Looks like virtio-console continues to write to the MMIO even after
underlying virtio-pci device is removed.

Hmm. I am not sure why that is a problem, but I assume some hypervisors just
hang the system if you try to kick them after reset.
Unfortunate that spec did not disallow it.

If we want to prevent that, we want to do something like this:


	/*
	 * Some devices get wedged if you kick them after they are
	 * reset. Mark all vqs as broken to make sure we don't.
	 */
        virtio_break_device(dev);
        /*
         * The below virtio_synchronize_cbs() guarantees that any
         * interrupt for this line arriving after
         * virtio_synchronize_vqs() has completed is guaranteed to see
         * vq->broken as true.
         */
        virtio_synchronize_cbs(dev);
        dev->config->reset(dev);


I assume this still works for you, yes?



> > 
> > my kernel code base is 6.14.0-rc2.
> > 
> > let me know if any more experiments needed.
> > 
> > ---
> > �drivers/virtio/virtio.c | 8 ++++++++
> > �1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index ba37665188b5..f9f885d04763 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -395,6 +395,13 @@ static const struct cpumask
> > *virtio_irq_get_affinity(struct device *_d,
> > ������� return dev->config->get_vq_affinity(dev, irq_vec);
> > �}
> > 
> > +static void virtio_dev_shutdown(struct device *_d)
> > +{
> > +������� struct virtio_device *dev = dev_to_virtio(_d);
> > +
> > +������� virtio_reset_device(dev);
> > +}
> > +
> > �static const struct bus_type virtio_bus = {
> > ������� .name� = "virtio",
> > ������� .match = virtio_dev_match,
> > @@ -403,6 +410,7 @@ static const struct bus_type virtio_bus = {
> > ������� .probe = virtio_dev_probe,
> > ������� .remove = virtio_dev_remove,
> > ������� .irq_get_affinity = virtio_irq_get_affinity,
> > +������ .shutdown = virtio_dev_shutdown,
> > �};
> > 
> > �int __register_virtio_driver(struct virtio_driver *driver, struct
> > module *owner)
> > -- 
> > 2.43.0
> > 
> > 
> >> gentle ping.
> >>
> >> this also fixes another issue with qemu vSMMU + virtio-scsi-pci. With
> >> the above addition I get rid of spurious warning in qemu on guest reboot.
> >>
> >> qemu-system-aarch64: virtio: zero sized buffers are not allowed
> >> qemu-system-aarch64: vhost vring error in virtqueue 0: Invalid
> >> argument (22)
> >>
> >> Would you mind if I respin?
> >>
> >> Thanks
> >>
> >> Eric
> >>
> >>
> >>
> >>
> >>>
> >>> Thanks
> >>>
> >>> Eric
> >>>>
> >>>>>> +}
> >>>>>> +
> >>>>>> � static const struct bus_type virtio_bus = {
> >>>>>> ����� .name� = "virtio",
> >>>>>> ����� .match = virtio_dev_match,
> >>>>>> @@ -363,6 +372,7 @@ static const struct bus_type virtio_bus = {
> >>>>>> ����� .uevent = virtio_uevent,
> >>>>>> ����� .probe = virtio_dev_probe,
> >>>>>> ����� .remove = virtio_dev_remove,
> >>>>>> +��� .shutdown = virtio_dev_shutdown,
> >>>>>> � };
> >>>>>> � � int __register_virtio_driver(struct virtio_driver *driver,
> >>>>>> struct module *owner)
> >>>>
> >>>
> >>
> > 


