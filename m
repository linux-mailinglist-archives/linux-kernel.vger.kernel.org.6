Return-Path: <linux-kernel+bounces-310866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBC7968234
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 878792842C1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D117618661C;
	Mon,  2 Sep 2024 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fN6c49c4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73255185E64
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266460; cv=none; b=KebwdRi+mjTjGB7kIg0OAud4GmFxbWyHK4urmzWk4FnjHiux3aLwOlp+L+MKf+9wAyP5tivi7hP2Ufdb12fkLBGf2PXT75KSqxqN4fHY73IfyoZ+encFvfKya5ZOzgUUHshVnl8dJRJQiAsh6V+OvAsMT7AnTqTzvei4XUHEEMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266460; c=relaxed/simple;
	bh=kVrdcp5X6KGHsHHKhTjGsM+c6FhnTV4o5Uy8xPdtln0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWnMwtbzJcP6HwdGnjeOz8C/a6ReP8+ic0AKFdvbX+fe6OHlp7JYpm/TU0tapfhRclLKIVRT/0FDPImTMxVm2V5+n6HeqvNLpOBgV4hsrCXTN/hkXiBqEuZBK4wNY8Eas9XCiiGvrhHJFtkaX/82bkcqRfYCAIrWhoeNiaOZc0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fN6c49c4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725266457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26H5O4MkZ+Qzy75C2mG+4OJtZUWPAYfLHPXwN1Awbaw=;
	b=fN6c49c4yZA28PsMy3DeQ+kWMltdUfgHLjEb9G0bRo6emaJvinccjM6fMfZeO7xy1eklYM
	hMapDZ1H5L2apJlDnbi/IzqhZIyJlCbOARZQ4LI2FpWnzEyEH4cX0BgWe3ssKrPESxUfoc
	WUzB4wAcs8LTgYmlArLUcz3OZYhKkHM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-wAGJESAyP0ODnKX8k1zBBA-1; Mon, 02 Sep 2024 04:40:55 -0400
X-MC-Unique: wAGJESAyP0ODnKX8k1zBBA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2f3fc9d8c00so38805801fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725266454; x=1725871254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26H5O4MkZ+Qzy75C2mG+4OJtZUWPAYfLHPXwN1Awbaw=;
        b=VvtpuqA0YndAxJhnm2SEwPOZr5ikiPXiFhyDbEXj+F1h56zDELUrISYl53DcqhjSF4
         jVMsJUHKQME8VZz4+wBwIbOMmGmzEozHxEi2y1yG60QvMYj7yu0UBy1nMSQ84YfT7muy
         +LW/gyAVtXumWLp9FMQh+eOq6M62ADzo4eO2l+7rEOgCuY7/+owbrD3DCbhdRtHjnOOC
         PCQhsdxm7YcRmKhc/JhAL+oMFvyekmCmvwzuqbRWBMmxz3US+yevv++lwyAfEgkc7H/Q
         vYDz9+ZMtY8SSDqgVZB/LTMBB0+C6FwPQcBuTzaTPIBUxjVrYaBZ0jzb2rlH93o7haUe
         2JOw==
X-Forwarded-Encrypted: i=1; AJvYcCX1wIHFbgzRTCfZPbQwLLkFzgH2WURyyYpWf6fBUo5KRnVFlmBHrrtwYoxG3+NVEdw1G5UcW9IetCQkXLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxad8Wzlrv2YgIUtg5r1Dr08Swlo8C0oydAfqa8shQ/sLdp0ckp
	EmNJG4mfIiRG1ioBlhXPou+KIHPwZn/MwHFTjr05711YmPkjn11t0EdvmjcL/90dQcTNshbK0gJ
	hA7K26stUKToOoqEJzBQjqdAw273MLLVMP1hwHTimZKAjzcQkfiMC1TZu8JR/zTw0gga14H7dji
	iOLK3anTFL2gwkL+Jc0EUAzs8BInedUhQwV0ol
X-Received: by 2002:a2e:be91:0:b0:2ef:243b:6dca with SMTP id 38308e7fff4ca-2f62655049fmr43333771fa.10.1725266453794;
        Mon, 02 Sep 2024 01:40:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWoPbW2vEbt4bQQu9HHXrrhRz5ki11xyLwkc7wATlshvmFUJK+DbWZW8YlFc2GbP6BMa3FeImFYnHAnj+adas=
X-Received: by 2002:a2e:be91:0:b0:2ef:243b:6dca with SMTP id
 38308e7fff4ca-2f62655049fmr43333561fa.10.1725266453239; Mon, 02 Sep 2024
 01:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827160256.2446626-2-dtatulea@nvidia.com> <CACGkMEuRvqu8W9-OqPBRhn1DG-+DO6TCzFdHqc7zB74GkNDkAQ@mail.gmail.com>
 <CACLfguXjiyp+Ya4mUKXu6Dmb3Wx5wW0bbNGRSFWE-Z0E5gALTA@mail.gmail.com>
 <8daf221f-8d87-4da1-944c-3bcd0edea604@nvidia.com> <CACLfguVr1bd6=bkGn6hX3W7xBr45qydaCpQ1mNpsATeWFqe2ZA@mail.gmail.com>
 <55b7ae23-6000-4699-9bac-5e72fbdcd803@nvidia.com> <CACLfguUZVDGaY4MD+_tDqM9DQC-C6cuPfCf34X59e2RkMztEkA@mail.gmail.com>
 <cfece74e-a979-4f74-8a6a-fc8869e354f7@nvidia.com> <750da215-adea-422c-8130-7524671a8779@nvidia.com>
In-Reply-To: <750da215-adea-422c-8130-7524671a8779@nvidia.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 2 Sep 2024 16:40:15 +0800
Message-ID: <CACLfguWu=1aZ=mhtzMGXGG2s3iG-SVAFB8QkObWfg+npdV0X9g@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC address when no nic vport MAC set
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	si-wei.liu@oracle.com, Jiri Pirko <jiri@nvidia.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Aug 2024 at 22:46, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>
> Hi Cindy,
>
> On 30.08.24 15:52, Dragos Tatulea wrote:
> >
> >
> > On 30.08.24 11:12, Cindy Lu wrote:
> >> On Thu, 29 Aug 2024 at 18:00, Dragos Tatulea <dtatulea@nvidia.com> wro=
te:
> >>>
> >>>
> >>>
> >>> On 29.08.24 11:05, Cindy Lu wrote:
> >>>> On Wed, 28 Aug 2024 at 17:37, Dragos Tatulea <dtatulea@nvidia.com> w=
rote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 28.08.24 11:00, Cindy Lu wrote:
> >>>>>> On Wed, 28 Aug 2024 at 09:51, Jason Wang <jasowang@redhat.com> wro=
te:
> >>>>>>>
> >>>>>>> On Wed, Aug 28, 2024 at 12:03=E2=80=AFAM Dragos Tatulea <dtatulea=
@nvidia.com> wrote:
> >>>>>>>>
> >>>>>>>> When the vdpa device is configured without a specific MAC
> >>>>>>>> address, the vport MAC address is used. However, this
> >>>>>>>> address can be 0 which prevents the driver from properly
> >>>>>>>> configuring the MPFS and breaks steering.
> >>>>>>>>
> >>>>>>>> The solution is to simply generate a random MAC address
> >>>>>>>> when no MAC is set on the nic vport.
> >>>>>>>>
> >>>>>>>> Now it's possible to create a vdpa device without a
> >>>>>>>> MAC address and run qemu with this device without needing
> >>>>>>>> to configure an explicit MAC address.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> >>>>>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> >>>>>>>
> >>>>>>> Acked-by: Jason Wang <jasowang@redhat.com>
> >>>>>>>
> >>>>>>> (Adding Cindy for double checking if it has any side effect on Qe=
mu side)
> >>>>>>>
> >>>>>>> Thanks
> >>>>>>>
> >>>>>> But Now there is a bug in QEMU: if the hardware MAC address does n=
ot
> >>>>>> match the one in the QEMU command line, it will cause traffic loss=
.
> >>>>>>
> >>>>> Why is this a new issue in qemu? qemu in it's current state won't w=
ork
> >>>>> with a different mac address that the one that is set in HW anyway.
> >>>>>
> >>>> this is not a new bug. We are trying to fix it because it will cause
> >>>> traffic lose without any warning.
> >>>> in my fix , this setting (different mac in device and Qemu) will fai=
l
> >>>> to load the VM.
> >>> Which is a good thing, right? Some feedback to the user that there is
> >>> a misconfig. I got bitten by this so many times... Thank you for addi=
ng it.
> >>>
> >>>>
> >>>>>> So, Just an FYI here: if your patch merged, it may cause traffic l=
oss.
> >>>>>> and now I'm working in the fix it in qemu, the link is
> >>>>>> https://patchew.org/QEMU/20240716011349.821777-1-lulu@redhat.com/
> >>>>>> The idea of this fix is
> >>>>>> There are will only two acceptable situations for qemu:
> >>>>>> 1. The hardware MAC address is the same as the MAC address specifi=
ed
> >>>>>> in the QEMU command line, and both MAC addresses are not 0.
> >>>>>> 2. The hardware MAC address is not 0, and the MAC address in the Q=
EMU
> >>>>>> command line is 0. In this situation, the hardware MAC address wil=
l
> >>>>>> overwrite the QEMU command line address.
> >>>>>>
> >>>>> Why would this not work with this patch? This patch simply sets a M=
AC
> >>>>> if the vport doesn't have one set. Which allows for more scenarios =
to
> >>>>> work.
> >>>>>
> >>>> I do not mean your patch will not work, I just want to make some
> >>>> clarify here.Your patch + my fix may cause the VM to fail to load in
> >>>> some situations, and this is as expected.
> >>>> Your patch is good to merge.
> >>> Ack. Thank you for the clarification.
> >>>
> >>> Thanks,
> >>> Dragos
> >>>
> >> Hi Dragos=EF=BC=8C
> >>  I think we need to hold this patch. Because it may not be working
> >> with upstream qemu.
> >>
> >> MLX will create a random MAC address for your patch. Additionally, if
> >> there is no specific MAC in the QEMU command line, QEMU will also
> >> generate a random MAC.
> >> these two MAC are not the same. and this will cause traffic loss.
> > Ahaa, it turns out that qemu 8.x and 9.x have different behaviour.
> >
> > Initially I was testing this scenario (vdpa device created with no mac
> > and no mac set in qemu cli) with qemu 8.x. There, qemu was not being
> > able to set the qemu generated random mac addres because .set_config()
> > is a nop in mlx5_vdpa.
> >
> > Then I moved to qemu 9.x and saw that this scenario was working because
> > now the CVQ was used instead to configure the mac on the device.
> >
> > So this patch should definitely not be applied.
> >
> > I was thinking if there are ways to fix this for 8.x. The only feasible
> > way is to implement .set_config() in mlx5_vdpa for the mac
> > configuration. But as you previousy said, this is discouraged.
> >
> I just tested your referenced qemu fix from patchwork and I found that
> for the case when a vdpa device doesn't have a mac address (mac address
> 0 and VIRTIO_NET_F_MAC not set) qemu will return an error. So with this
> fix we'd be back to square one where the user always has to set a mac
> somewhere.
>
> Would it be possible to take this case into consideration with your
> fix?
>
> Thanks,
> Dragos
>
Hi Dragos

Thanks for your test and help, I think I can add a check for
VIRTIO_NET_F_MAC in the qemu code. if the device's Mac is 0 and the
VIRTIO_NET_F_MAC is not set. The guest VM will fail to load. I will
double-check this
Thanks

Cindy


