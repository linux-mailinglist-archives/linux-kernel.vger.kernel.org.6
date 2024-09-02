Return-Path: <linux-kernel+bounces-310904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5CF9682AB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029691F21C86
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BFF187341;
	Mon,  2 Sep 2024 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwpwKArY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF85154C1E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267947; cv=none; b=MxxfI1mTajjxsY1uAn1bhk0lldvFBtm1rXAtyv1qhe1mFi5+b4PIFGRInOVSPDa7lXsNvPkj55Iwtqkom0BiVWlTVTTUSo1UBTpDUnkSbxYC/mQRAowIqJSYT2O7v4IzbnZCra8qVI3S+jZanBfjDsAXMGYRKctlb3pGE9PKxj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267947; c=relaxed/simple;
	bh=jLsXe+caJI4qfPC9maQ8yJiJHKBFxjWKjboGtLFZ44Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAg2MPVtYWPv7kLVXloDrt5Vw5mDigh0NN9LdHRmzDe4RcQcUnY3D+01GL3q1LaHIsgGPCXzBtBy2zz826mAO9kBMaIhRG9eOfwBEWLEFaVKvGUfoQ2VgLGFLnJ5j9lE4xd1BvJ74F7aEPiwQgqFSFs5BLuxX/uKxvgyI4ZYE4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwpwKArY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725267944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yl/+7diA2SKHvAxd7Br7OGqXTfXuQ8DMdZAp+CxC8VE=;
	b=fwpwKArYTSK0VG6NNSFuRTRAXbvB2SbO4G3tJwdnoRU2VfPqZp89tVUKwnSbb1B0Us/Pnu
	K9qF/ut+sOGBI2GC2VX/AwLTTF+F845VlI3xU+uUTs6tqhKZYSmv+vTYZFChmbyLY+/Cby
	haTpqPLzwUe+mtobk41A15pUJBmXotM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-t0YubrDzN0iI_9Ovm8qcyg-1; Mon, 02 Sep 2024 05:05:41 -0400
X-MC-Unique: t0YubrDzN0iI_9Ovm8qcyg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5befa588972so3060781a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 02:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725267940; x=1725872740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yl/+7diA2SKHvAxd7Br7OGqXTfXuQ8DMdZAp+CxC8VE=;
        b=oX5x2Yhi2JtwpILeYNsIrH37kaDgNzWvWO+hfPi/Ndl6i8kobV3k9xxYS7NlwCrn2K
         6S40hgKpqDEJLyNsUNCYn3PANHYUjnUtbGpVop16YEXBvieAgfidW5SjPWrqFS2K22tX
         0EOt9YZA7f3onP2bz9S6JG/XCsz7m68t6bftlbTaEbBE6CaAe7vhpw4U+dZl8aqFiY6o
         lkF72aEdVkuHialwjQUB10hXaSD9CvvrzKZHy+dqrxqCqA58e4qVeuxf9OYKLGcsgLMy
         ukrDeHQV7peJQaXSIgyhKwmU5siG6acs/viLJyqo8bNS6q2BFkk+BYFJLfcpwO7JLBm3
         Y8Tg==
X-Forwarded-Encrypted: i=1; AJvYcCW1tRMe0wNFGTV0AptrEABshf6BD3rLdvJM+IWRP78ESSpncT2oe0GFTY+11KMNvvLx+b9yT1ite1fNKFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZBF1XH/rs1QT8wcNLCs2V/Ubeoh3gNdg3VLHnq3M5tNLANpgo
	MHK63nFaLo/XcrJP7FrnRn971s2qsqVi2MSvesK4Fytm8/Tmr2C7y8vgg7+wAY5+HlkNgJwl+uO
	BXaViLmhk5eCVTwY4zU/pi6/yGW+bGxzHuSbabulihWkiVM+DZcl+z5EeNADcmrUTuo62sea8w2
	vD4TBiILpwb5SDxZq4KijlLK71wbMCUkoxmVDC
X-Received: by 2002:a05:6402:26d2:b0:5c2:1298:35ee with SMTP id 4fb4d7f45d1cf-5c243724727mr4288529a12.2.1725267939784;
        Mon, 02 Sep 2024 02:05:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPJNx7l/OE5XOyhaGq5fVqlPbzCCg0Nm7WCBI69Iyu75oP5ZB/jcx4ZvNGdTQOPhcLxJnyLBPqTnG/xY3ey+4=
X-Received: by 2002:a05:6402:26d2:b0:5c2:1298:35ee with SMTP id
 4fb4d7f45d1cf-5c243724727mr4288513a12.2.1725267939247; Mon, 02 Sep 2024
 02:05:39 -0700 (PDT)
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
 <CACLfguWu=1aZ=mhtzMGXGG2s3iG-SVAFB8QkObWfg+npdV0X9g@mail.gmail.com> <4936c228-a3e6-4dc3-a8b4-0f9706e7541f@nvidia.com>
In-Reply-To: <4936c228-a3e6-4dc3-a8b4-0f9706e7541f@nvidia.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 2 Sep 2024 17:05:01 +0800
Message-ID: <CACLfguVibPU_WzvRKJ7oVN+SaFy1YYysPbmBWEfdYgFjYc-h0Q@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC address when no nic vport MAC set
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	si-wei.liu@oracle.com, Jiri Pirko <jiri@nvidia.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Sept 2024 at 16:54, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>
>
>
> On 02.09.24 10:40, Cindy Lu wrote:
> > On Fri, 30 Aug 2024 at 22:46, Dragos Tatulea <dtatulea@nvidia.com> wrot=
e:
> >>
> >> Hi Cindy,
> >>
> >> On 30.08.24 15:52, Dragos Tatulea wrote:
> >>>
> >>>
> >>> On 30.08.24 11:12, Cindy Lu wrote:
> >>>> On Thu, 29 Aug 2024 at 18:00, Dragos Tatulea <dtatulea@nvidia.com> w=
rote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 29.08.24 11:05, Cindy Lu wrote:
> >>>>>> On Wed, 28 Aug 2024 at 17:37, Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> On 28.08.24 11:00, Cindy Lu wrote:
> >>>>>>>> On Wed, 28 Aug 2024 at 09:51, Jason Wang <jasowang@redhat.com> w=
rote:
> >>>>>>>>>
> >>>>>>>>> On Wed, Aug 28, 2024 at 12:03=E2=80=AFAM Dragos Tatulea <dtatul=
ea@nvidia.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> When the vdpa device is configured without a specific MAC
> >>>>>>>>>> address, the vport MAC address is used. However, this
> >>>>>>>>>> address can be 0 which prevents the driver from properly
> >>>>>>>>>> configuring the MPFS and breaks steering.
> >>>>>>>>>>
> >>>>>>>>>> The solution is to simply generate a random MAC address
> >>>>>>>>>> when no MAC is set on the nic vport.
> >>>>>>>>>>
> >>>>>>>>>> Now it's possible to create a vdpa device without a
> >>>>>>>>>> MAC address and run qemu with this device without needing
> >>>>>>>>>> to configure an explicit MAC address.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> >>>>>>>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> >>>>>>>>>
> >>>>>>>>> Acked-by: Jason Wang <jasowang@redhat.com>
> >>>>>>>>>
> >>>>>>>>> (Adding Cindy for double checking if it has any side effect on =
Qemu side)
> >>>>>>>>>
> >>>>>>>>> Thanks
> >>>>>>>>>
> >>>>>>>> But Now there is a bug in QEMU: if the hardware MAC address does=
 not
> >>>>>>>> match the one in the QEMU command line, it will cause traffic lo=
ss.
> >>>>>>>>
> >>>>>>> Why is this a new issue in qemu? qemu in it's current state won't=
 work
> >>>>>>> with a different mac address that the one that is set in HW anywa=
y.
> >>>>>>>
> >>>>>> this is not a new bug. We are trying to fix it because it will cau=
se
> >>>>>> traffic lose without any warning.
> >>>>>> in my fix , this setting (different mac in device and Qemu) will f=
ail
> >>>>>> to load the VM.
> >>>>> Which is a good thing, right? Some feedback to the user that there =
is
> >>>>> a misconfig. I got bitten by this so many times... Thank you for ad=
ding it.
> >>>>>
> >>>>>>
> >>>>>>>> So, Just an FYI here: if your patch merged, it may cause traffic=
 loss.
> >>>>>>>> and now I'm working in the fix it in qemu, the link is
> >>>>>>>> https://patchew.org/QEMU/20240716011349.821777-1-lulu@redhat.com=
/
> >>>>>>>> The idea of this fix is
> >>>>>>>> There are will only two acceptable situations for qemu:
> >>>>>>>> 1. The hardware MAC address is the same as the MAC address speci=
fied
> >>>>>>>> in the QEMU command line, and both MAC addresses are not 0.
> >>>>>>>> 2. The hardware MAC address is not 0, and the MAC address in the=
 QEMU
> >>>>>>>> command line is 0. In this situation, the hardware MAC address w=
ill
> >>>>>>>> overwrite the QEMU command line address.
> >>>>>>>>
> >>>>>>> Why would this not work with this patch? This patch simply sets a=
 MAC
> >>>>>>> if the vport doesn't have one set. Which allows for more scenario=
s to
> >>>>>>> work.
> >>>>>>>
> >>>>>> I do not mean your patch will not work, I just want to make some
> >>>>>> clarify here.Your patch + my fix may cause the VM to fail to load =
in
> >>>>>> some situations, and this is as expected.
> >>>>>> Your patch is good to merge.
> >>>>> Ack. Thank you for the clarification.
> >>>>>
> >>>>> Thanks,
> >>>>> Dragos
> >>>>>
> >>>> Hi Dragos=EF=BC=8C
> >>>>  I think we need to hold this patch. Because it may not be working
> >>>> with upstream qemu.
> >>>>
> >>>> MLX will create a random MAC address for your patch. Additionally, i=
f
> >>>> there is no specific MAC in the QEMU command line, QEMU will also
> >>>> generate a random MAC.
> >>>> these two MAC are not the same. and this will cause traffic loss.
> >>> Ahaa, it turns out that qemu 8.x and 9.x have different behaviour.
> >>>
> >>> Initially I was testing this scenario (vdpa device created with no ma=
c
> >>> and no mac set in qemu cli) with qemu 8.x. There, qemu was not being
> >>> able to set the qemu generated random mac addres because .set_config(=
)
> >>> is a nop in mlx5_vdpa.
> >>>
> >>> Then I moved to qemu 9.x and saw that this scenario was working becau=
se
> >>> now the CVQ was used instead to configure the mac on the device.
> >>>
> >>> So this patch should definitely not be applied.
> >>>
> >>> I was thinking if there are ways to fix this for 8.x. The only feasib=
le
> >>> way is to implement .set_config() in mlx5_vdpa for the mac
> >>> configuration. But as you previousy said, this is discouraged.
> >>>
> >> I just tested your referenced qemu fix from patchwork and I found that
> >> for the case when a vdpa device doesn't have a mac address (mac addres=
s
> >> 0 and VIRTIO_NET_F_MAC not set) qemu will return an error. So with thi=
s
> >> fix we'd be back to square one where the user always has to set a mac
> >> somewhere.
> >>
> >> Would it be possible to take this case into consideration with your
> >> fix?
> >>
> >> Thanks,
> >> Dragos
> >>
> > Hi Dragos
> >
> > Thanks for your test and help, I think I can add a check for
> > VIRTIO_NET_F_MAC in the qemu code. if the device's Mac is 0 and the
> > VIRTIO_NET_F_MAC is not set. The guest VM will fail to load. I will
> > double-check this
> My request was to use the random MAC from qemu in this case. qemu is
> able to configure the device via CVQ. At least this device...
>
Ok, I got it. Sorry for my misunderstanding. I understand what you
mean. Then the device needs to set the bit VIRTIO_NET_F_CTRL_MAC_ADDR
to use CVQ. I will verify this and change my patch.
Thanks
Cindy
> Thanks,
> Dragos
>


