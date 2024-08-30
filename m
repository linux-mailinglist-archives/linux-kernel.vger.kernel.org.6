Return-Path: <linux-kernel+bounces-308433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A07E965CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1CB1C23C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA3E171658;
	Fri, 30 Aug 2024 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORjCU3i8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF540763F8
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010197; cv=none; b=m5XgjNCX+rmII/nOd2JMRZ+ErVK1wsu/F/5DhiqtqDvkJpShqv1LWEQ4/Gr31m1KJdtVxQ20sWLckR37Kbg0zSnWUc5z+kwo9XkggumcK6rjPImKK5nztveTltIFK3MT2lLxQ6jqppTKLrMG3lRxfuSNnKrSUzzKzfNyIRpDDgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010197; c=relaxed/simple;
	bh=Gv7wBN/adtHiLwYG4iBw6vLETD41Szc1rDOxGg3AgKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcqt5yLzbYH+pL2aAeoeyvnfFsf8ndscvh/6qkQUaYK39tyuQEG48t3fjfyuiEHsEqG6jK1Kj38t17NTYymV5uMsRDi65qECJTZH2G4WKgmJNNWjJPuIRO1tWbe/LO96H6X8iKv0A63c6Q8w91/bQ9MekZ38mhZF0739216mQxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ORjCU3i8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725010194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zYzh+2rLl49agAW6s5dl1J3mWdr3xNYTK5wo6lWNsTI=;
	b=ORjCU3i8xbT4n1uPn4trfS7rEy0bhPQMQKFz267RcOmjwjH7nERbZLgzHNbr5B1wQ+HPLS
	ti+S293qv6geIsBURTcQogpvG4EHdJigF3ADT0BHhqPgkslmOf1enU+qPp4GJ4r9EUmWsf
	QL6rq/8Q8zssOGnc0ki+KIWuWmJ/FWQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-X9oHI_0bP7uyBrZ2I0JWDw-1; Fri, 30 Aug 2024 05:29:53 -0400
X-MC-Unique: X9oHI_0bP7uyBrZ2I0JWDw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5bebd3e0eb9so1341240a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725010192; x=1725614992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYzh+2rLl49agAW6s5dl1J3mWdr3xNYTK5wo6lWNsTI=;
        b=w7c0wTQSxzbWa7uKSGlMECy9G37aLQm+VpFxVMeZEgH/LdR/ViiHSV4mZWx6VQdh0J
         LD5Ah0Ng21KnobohA8bw9dQmTYKSKtk18Ny+J70kz0Qt7Gmc1N91j2X3FcPNWc9ogH9o
         fcpBJJtiUYnHlZoyG8SuRa36UhcpnTgONWOsCpyyPqEv321u0L3sFIDWlvJc1xrHxoix
         tfpnmkZ6bj3SiQ94/GFWeZ9+trJXJ6L9HSGXqplVznAzA82DfucFl1sYU51H9TsEMKuM
         itN5c6wgYF0DdQ5W5xEKclSbKhmgV967PDNTOqzHmyDgZbGOSl+SoJEbO0LazsZDNpaR
         jsVg==
X-Forwarded-Encrypted: i=1; AJvYcCXfmg9PJq9UGYkc51ZvQa7lYC0exbliHKq+Hw2eUl1ooUXeMyYIXd7kj7CfpLGtoH8ueq+D5SBTx1mzFrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1LrXD5gWpJL/4GzeMqcjqmvx5EuQ6Uc9U1QgSD4UcuUdkgWMW
	7+qLmdjxgFagymbQtRwxMH/EQkKzXUo9Fu6TFB9Tof4CkSTy0cQY8P455/Zc7hKEdebEQnChXMh
	Z65KM+gvij2wNiWbsmRBHRZsEM36ZfYII+bwBxqI37sXn9xYH14McEduskGEufoiOYOCIuKEJxU
	avvqPgy5fP4Wxwfstw60bELXEOp0EVP5KW18P9
X-Received: by 2002:a05:6402:2690:b0:5c0:902c:e191 with SMTP id 4fb4d7f45d1cf-5c21ed45d49mr5272314a12.9.1725010191876;
        Fri, 30 Aug 2024 02:29:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTmSM8RXIQKyW9K1Jlff4Dtk3bQLl42SLNPUg1aYjeaFkdazNnaiNIieVXEwd1OBwUQAAZIG8FuaX7yH2dONA=
X-Received: by 2002:a05:6402:2690:b0:5c0:902c:e191 with SMTP id
 4fb4d7f45d1cf-5c21ed45d49mr5272304a12.9.1725010191370; Fri, 30 Aug 2024
 02:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827160256.2446626-2-dtatulea@nvidia.com> <CACGkMEuRvqu8W9-OqPBRhn1DG-+DO6TCzFdHqc7zB74GkNDkAQ@mail.gmail.com>
 <CACLfguXjiyp+Ya4mUKXu6Dmb3Wx5wW0bbNGRSFWE-Z0E5gALTA@mail.gmail.com>
 <8daf221f-8d87-4da1-944c-3bcd0edea604@nvidia.com> <CACLfguVr1bd6=bkGn6hX3W7xBr45qydaCpQ1mNpsATeWFqe2ZA@mail.gmail.com>
 <55b7ae23-6000-4699-9bac-5e72fbdcd803@nvidia.com> <0648a9d9-a056-4cdb-bfb8-a792bce1e771@nvidia.com>
In-Reply-To: <0648a9d9-a056-4cdb-bfb8-a792bce1e771@nvidia.com>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 30 Aug 2024 17:29:14 +0800
Message-ID: <CACLfguXM97JAdWcYO17+H6pu7MWLu2QqBgu_PypGxU_Ab+OUOQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC address when no nic vport MAC set
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	si-wei.liu@oracle.com, Jiri Pirko <jiri@nvidia.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Aug 2024 at 03:03, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>
>
>
> On 29.08.24 12:00, Dragos Tatulea wrote:
> >
> >
> > On 29.08.24 11:05, Cindy Lu wrote:
> >> On Wed, 28 Aug 2024 at 17:37, Dragos Tatulea <dtatulea@nvidia.com> wro=
te:
> >>>
> >>>
> >>>
> >>> On 28.08.24 11:00, Cindy Lu wrote:
> >>>> On Wed, 28 Aug 2024 at 09:51, Jason Wang <jasowang@redhat.com> wrote=
:
> >>>>>
> >>>>> On Wed, Aug 28, 2024 at 12:03=E2=80=AFAM Dragos Tatulea <dtatulea@n=
vidia.com> wrote:
> >>>>>>
> >>>>>> When the vdpa device is configured without a specific MAC
> >>>>>> address, the vport MAC address is used. However, this
> >>>>>> address can be 0 which prevents the driver from properly
> >>>>>> configuring the MPFS and breaks steering.
> >>>>>>
> >>>>>> The solution is to simply generate a random MAC address
> >>>>>> when no MAC is set on the nic vport.
> >>>>>>
> >>>>>> Now it's possible to create a vdpa device without a
> >>>>>> MAC address and run qemu with this device without needing
> >>>>>> to configure an explicit MAC address.
> >>>>>>
> >>>>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> >>>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> >>>>>
> >>>>> Acked-by: Jason Wang <jasowang@redhat.com>
> >>>>>
> >>>>> (Adding Cindy for double checking if it has any side effect on Qemu=
 side)
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>> But Now there is a bug in QEMU: if the hardware MAC address does not
> >>>> match the one in the QEMU command line, it will cause traffic loss.
> >>>>
> >>> Why is this a new issue in qemu? qemu in it's current state won't wor=
k
> >>> with a different mac address that the one that is set in HW anyway.
> >>>
> >> this is not a new bug. We are trying to fix it because it will cause
> >> traffic lose without any warning.
> >> in my fix , this setting (different mac in device and Qemu) will fail
> >> to load the VM.
> > Which is a good thing, right? Some feedback to the user that there is
> > a misconfig. I got bitten by this so many times... Thank you for adding=
 it.
> >
> >>
> >>>> So, Just an FYI here: if your patch merged, it may cause traffic los=
s.
> >>>> and now I'm working in the fix it in qemu, the link is
> >>>> https://patchew.org/QEMU/20240716011349.821777-1-lulu@redhat.com/
> >>>> The idea of this fix is
> >>>> There are will only two acceptable situations for qemu:
> >>>> 1. The hardware MAC address is the same as the MAC address specified
> >>>> in the QEMU command line, and both MAC addresses are not 0.
> >>>> 2. The hardware MAC address is not 0, and the MAC address in the QEM=
U
> >>>> command line is 0. In this situation, the hardware MAC address will
> >>>> overwrite the QEMU command line address.
> >>>>
> >>> Why would this not work with this patch? This patch simply sets a MAC
> >>> if the vport doesn't have one set. Which allows for more scenarios to
> >>> work.
> >>>
> >> I do not mean your patch will not work, I just want to make some
> >> clarify here.Your patch + my fix may cause the VM to fail to load in
> >> some situations, and this is as expected.
> >> Your patch is good to merge.
> > Ack. Thank you for the clarification.
> (Side note)
> While looking at another issue I discovered that it's possible to
> configure a random MAC on the mlx5_vdpa device at VM boot time if
> device MAC configuration is implemented during during .set_config(). So
> I was able to boot up a VM with a random MAC address coming from qemu
> and the traffic worked with this new MAC.
>
> So now I'm not sure if this is just by luck or if the .set_config()
> op should be implemented for the MAC part in our device.
>
> Thanks,
> Dragos
>
Hi Dragos=EF=BC=8C
For qemu part, I think this is not set from set_config()?  it should
be from the CVQ?
Usually, we don't recommend using the set_config() function because
the configuration space should be read-only for modern devices.

Now there is a bug in this part of qemu, and we plan to remove the
code to set_config() in virtio_net_device_realize(), here is the patch
https://lore.kernel.org/all/CACGkMEvCSKfahpBQLAMmSzdFN-QPhg5Zx+UQVrFX0HsWyb=
ZZNA@mail.gmail.com/T/
and this is still under review

thanks
cindy


