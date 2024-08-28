Return-Path: <linux-kernel+bounces-304625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF4B9622DD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2AE1285A58
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8552E15C151;
	Wed, 28 Aug 2024 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1vQOzgQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ED8156F4A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724835645; cv=none; b=kLJhPtfhiYD5vXiXAc676C7I3bDfbYYK2wsslU2bda2w8R7jHTcdk2IFcF4OhzRsKj27fCtsP9RvO84yySgwUC3ie3JIhjcMSDeec1QFz9jNpuT47rOzSblWdnmyY9NXBGs/xnPDrmsvIVrqwTqyf39AjzVpVVsDsglM+cfhFE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724835645; c=relaxed/simple;
	bh=EdgBUoaGZipHWYfvkvK5093fnrzFSUyZQUkIgM2yDJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZpXw/31Gg5IPoywm3/jtOc6gNOMSX1BVDIcnEUVrJz3jtpGWv4PvtNRArx1dlJNbeD5Ae5umAVM0XPpaWSWSneUeIgNV14MTC3915G5WY3wKNfCUBhaW7cds5pzTCeXEYJ04m2v5ZzdxdMz2dHKRAaYyvx2aSWf3k8RCx6VQWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q1vQOzgQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724835643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HqJX5Of7GMsCkp8gdgyQDXYdcAwtYT7fpZUnmkWnXRQ=;
	b=Q1vQOzgQnoi7U52/LYt4yQ2dAmLqAaziIiJPDFDy/4pChQZlAz3ZFvsWSANN8eDo4Em85p
	IfLjrzTCuHSQU+QwZjws4aYQnkskOQBXHaV4jZ9EXC7OOl84WAMgcBdWQuBv0n9IcRLfAF
	75MBuDGVpWHO7kMq8G0QjrFiPRWnY1M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-nyMRSnzSOqOCgkOX1M9oTQ-1; Wed, 28 Aug 2024 05:00:41 -0400
X-MC-Unique: nyMRSnzSOqOCgkOX1M9oTQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a86a64eef91so281052766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724835640; x=1725440440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqJX5Of7GMsCkp8gdgyQDXYdcAwtYT7fpZUnmkWnXRQ=;
        b=n+5kO3WL9H94Q8mtW3eFpTm0C/H4F3+8PMgXU5NQRLE89CD5SpEvxxGNvstP2PrJEP
         bx2azy6W285CP5nxz6cvuTQ1NOAidR2HiHGxsqHFQIKrXmQMKAsi6vTdxqVifildHVI3
         PoxWuyvyo2kLezASXWfVumcYdRvHnpUDl90D1IKFJmGZgNuT2yXRjvvaXgeqNoZjcuUl
         60JSHH1fIof5Wq+ZRy/Aqg7d6hPFLoOO9Li7d57e6nmyKnxoxFHzL9YkP/jjBQSXGvQM
         ipz8W523bCC4WebndaUsFVqt0Gj7LcT2IgSuqKYFLQGQXXU9kKhXm3kr5GmZFI0gztIL
         o2jw==
X-Forwarded-Encrypted: i=1; AJvYcCXf7ApODwbWXo1nBZgy+eyYPBFfwUMFeIQIUer9WINihnvfAe/yqiiLVjCc+DSOpb68XbZ2a5TFiDQssZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzex9gWYEf6U9Xn52xX5ulUvIJMn83KFS6E34eq5Z69P6w9/NrD
	d/aK6RncGsHT23dVeQyBX0NXyA+kmTrdAGZizN1dXIWObNJ2AXRd+qNW7/bt1T4L4NDauvOGV5h
	hZcJRX95/6rgT5Cvpk0hsENrcpPMZbNkozXn0b6V0eNZfosTZfN8n2B3pd9D6TVfkTVJRGeZN4v
	KJNTVho3AwY2B1D7S8bh4/BMcJMJJJHBgNLc19
X-Received: by 2002:a05:6402:2549:b0:5be:9bc5:f6b4 with SMTP id 4fb4d7f45d1cf-5c08915b718mr13141127a12.8.1724835639802;
        Wed, 28 Aug 2024 02:00:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmytXQdT7iRj1p5zIwkpTj8uWa2KU8YRy/19fhGY0/5govv3/YWqQfafQc0XnYLqOPYrG90KFWou4s0lULvlk=
X-Received: by 2002:a05:6402:2549:b0:5be:9bc5:f6b4 with SMTP id
 4fb4d7f45d1cf-5c08915b718mr13141084a12.8.1724835639150; Wed, 28 Aug 2024
 02:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827160256.2446626-2-dtatulea@nvidia.com> <CACGkMEuRvqu8W9-OqPBRhn1DG-+DO6TCzFdHqc7zB74GkNDkAQ@mail.gmail.com>
In-Reply-To: <CACGkMEuRvqu8W9-OqPBRhn1DG-+DO6TCzFdHqc7zB74GkNDkAQ@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 28 Aug 2024 17:00:01 +0800
Message-ID: <CACLfguXjiyp+Ya4mUKXu6Dmb3Wx5wW0bbNGRSFWE-Z0E5gALTA@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC address when no nic vport MAC set
To: Jason Wang <jasowang@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	si-wei.liu@oracle.com, Jiri Pirko <jiri@nvidia.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Aug 2024 at 09:51, Jason Wang <jasowang@redhat.com> wrote:
>
> On Wed, Aug 28, 2024 at 12:03=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.=
com> wrote:
> >
> > When the vdpa device is configured without a specific MAC
> > address, the vport MAC address is used. However, this
> > address can be 0 which prevents the driver from properly
> > configuring the MPFS and breaks steering.
> >
> > The solution is to simply generate a random MAC address
> > when no MAC is set on the nic vport.
> >
> > Now it's possible to create a vdpa device without a
> > MAC address and run qemu with this device without needing
> > to configure an explicit MAC address.
> >
> > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> (Adding Cindy for double checking if it has any side effect on Qemu side)
>
> Thanks
>
But Now there is a bug in QEMU: if the hardware MAC address does not
match the one in the QEMU command line, it will cause traffic loss.

So, Just an FYI here: if your patch merged, it may cause traffic loss.
and now I'm working in the fix it in qemu, the link is
https://patchew.org/QEMU/20240716011349.821777-1-lulu@redhat.com/
The idea of this fix is
There are will only two acceptable situations for qemu:
1. The hardware MAC address is the same as the MAC address specified
in the QEMU command line, and both MAC addresses are not 0.
2. The hardware MAC address is not 0, and the MAC address in the QEMU
command line is 0. In this situation, the hardware MAC address will
overwrite the QEMU command line address.

Thanks
Cindy


> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index fa78e8288ebb..1c26139d02fe 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -3824,6 +3824,9 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev=
 *v_mdev, const char *name,
> >                 err =3D mlx5_query_nic_vport_mac_address(mdev, 0, 0, co=
nfig->mac);
> >                 if (err)
> >                         goto err_alloc;
> > +
> > +               if (is_zero_ether_addr(config->mac))
> > +                       eth_random_addr(config->mac);
> >         }
> >
> >         if (!is_zero_ether_addr(config->mac)) {
> > --
> > 2.45.1
> >
>


