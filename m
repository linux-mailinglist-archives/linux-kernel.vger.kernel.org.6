Return-Path: <linux-kernel+bounces-306471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF72C963F76
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17211C22460
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8557618C91E;
	Thu, 29 Aug 2024 09:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INt9dyye"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACAB15666A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922381; cv=none; b=J7Bi3S5NH18PnMw6/rGRHkO9Ch01aB/gMoUVkO6SZMKgr90pedjZE0TKJjuMB0rtTkrxEsw1QDiEOq+gaLgHo6LPMDM0+UV87Biih46HgNSZJIcVMScSdX95YvR4ybEo5bYG1BqUxqaAHGQTxlYdTxTDLTwL/Wu5tuJjFdVN90Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922381; c=relaxed/simple;
	bh=dNmgvB0PNie3Ta9wWOJOICrzojenRtlbYkH0WIcuTts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TocCgDcjJG1prDOGTA1E0Gcd5rw5svBQnPjObVvvORUyap5D9KmdseynhJvt4P2zUWevO5ZsFbYXEP7z75dqTHQ7vM281m622ZF0dwz4BIW1AuJb+5Nj/XYOk8lRiHY2KbWLo/mhenxQWWDce1STrxliz2Dz3xlk3PrjHRadLX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=INt9dyye; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724922378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/uYBPSE4scu+k+l3zhOUlQLPU644iSREuuqaqkYhf/E=;
	b=INt9dyyeYASbL7OG22OgQCTw7b7xPPNIsM0dbpEayEx7oGBMpK/y1yF+Vwl1CWvH3tMe2a
	M1MqJdtlFIVF8FVzI9DB2IjDELS8qfGWRqvG5edDrTADqzy2fsIyIBmmZdglabkQDtqGSZ
	R0ki5Q1RHyO2lCiwSAekTVIsIUouZ0A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-ttQGm3d5PjebMEc5k4UK5Q-1; Thu, 29 Aug 2024 05:06:17 -0400
X-MC-Unique: ttQGm3d5PjebMEc5k4UK5Q-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5bedb783849so324238a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724922376; x=1725527176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uYBPSE4scu+k+l3zhOUlQLPU644iSREuuqaqkYhf/E=;
        b=rB0nqtZ8CcQ+yrkBROVJgPJiil3NKXpFNC0B7KcT2n7OtNwp22UJsdrnoxeI6GKo2p
         1L+r8xCZ4keiQk9bwEuAuVs1iSih9jKCM9f3ibQjA6B2WzYigo23JjWlo2t/dJGr5xtr
         oDZTHxRbF2JAxqrJWbGUdZT/LHo1R4vcO8dw5umg1+pGdPwuZC/Pmmnmlbq6C0ulj+e3
         aHYll8Eqm7xk6TNPi3Omb3b/WO3lCurSzLVofBO9/wDHIAVeaDvZkTqSbOhNosXAQtyy
         8dpNRsKQLp7p0vpQeVE8nAoeBJLGJgaEqQf+fNWGXh+g2R8aZj2+L0ukmySV/C2uj0y4
         JOVQ==
X-Forwarded-Encrypted: i=1; AJvYcCViXk8M4+vu49MqU/uFwBoS23geOyEmrolM/FgdvIWznMNWSfyl9RoJSO0JjCtXGhjsQMTxskK3flIWjew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz9HJ0HQv3O5owjO7NRsvdJbpYEGl/GEN5GqOZ+zX4Q4b81MA8
	1wzHumqCdRHv1PiqIoeeMRrQXuZKOJb/BDES964z7YrPZxWcwGh3Onti+CKDhFS0R7N7iR9U1o8
	Ke0ivQ54YwD2/MvXw5kDbqLGd+8oN2AjE6/clVNXtssSdbQRxwJxrPNSlFrfIxT+SZnnvjRg/Gs
	eXLZKgVm5J/keJtnSLbnj/9UqrKl4WWE/JTGtJ
X-Received: by 2002:a05:6402:90b:b0:5be:fbe7:11ac with SMTP id 4fb4d7f45d1cf-5c21ed54d3cmr1826751a12.20.1724922375793;
        Thu, 29 Aug 2024 02:06:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGLm8Hz5ioA0VaJ4JLlmepguUyiuDxm4rTg99EfDG1HDgky7aJfIl1rtVoY3YUHlEK2SJJtzOojwa/4ib/k+8=
X-Received: by 2002:a05:6402:90b:b0:5be:fbe7:11ac with SMTP id
 4fb4d7f45d1cf-5c21ed54d3cmr1826728a12.20.1724922375297; Thu, 29 Aug 2024
 02:06:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827160256.2446626-2-dtatulea@nvidia.com> <CACGkMEuRvqu8W9-OqPBRhn1DG-+DO6TCzFdHqc7zB74GkNDkAQ@mail.gmail.com>
 <CACLfguXjiyp+Ya4mUKXu6Dmb3Wx5wW0bbNGRSFWE-Z0E5gALTA@mail.gmail.com> <8daf221f-8d87-4da1-944c-3bcd0edea604@nvidia.com>
In-Reply-To: <8daf221f-8d87-4da1-944c-3bcd0edea604@nvidia.com>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 29 Aug 2024 17:05:38 +0800
Message-ID: <CACLfguVr1bd6=bkGn6hX3W7xBr45qydaCpQ1mNpsATeWFqe2ZA@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC address when no nic vport MAC set
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	si-wei.liu@oracle.com, Jiri Pirko <jiri@nvidia.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Aug 2024 at 17:37, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>
>
>
> On 28.08.24 11:00, Cindy Lu wrote:
> > On Wed, 28 Aug 2024 at 09:51, Jason Wang <jasowang@redhat.com> wrote:
> >>
> >> On Wed, Aug 28, 2024 at 12:03=E2=80=AFAM Dragos Tatulea <dtatulea@nvid=
ia.com> wrote:
> >>>
> >>> When the vdpa device is configured without a specific MAC
> >>> address, the vport MAC address is used. However, this
> >>> address can be 0 which prevents the driver from properly
> >>> configuring the MPFS and breaks steering.
> >>>
> >>> The solution is to simply generate a random MAC address
> >>> when no MAC is set on the nic vport.
> >>>
> >>> Now it's possible to create a vdpa device without a
> >>> MAC address and run qemu with this device without needing
> >>> to configure an explicit MAC address.
> >>>
> >>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> >>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> >>
> >> Acked-by: Jason Wang <jasowang@redhat.com>
> >>
> >> (Adding Cindy for double checking if it has any side effect on Qemu si=
de)
> >>
> >> Thanks
> >>
> > But Now there is a bug in QEMU: if the hardware MAC address does not
> > match the one in the QEMU command line, it will cause traffic loss.
> >
> Why is this a new issue in qemu? qemu in it's current state won't work
> with a different mac address that the one that is set in HW anyway.
>
this is not a new bug. We are trying to fix it because it will cause
traffic lose without any warning.
in my fix , this setting (different mac in device and Qemu) will fail
to load the VM.

> > So, Just an FYI here: if your patch merged, it may cause traffic loss.
> > and now I'm working in the fix it in qemu, the link is
> > https://patchew.org/QEMU/20240716011349.821777-1-lulu@redhat.com/
> > The idea of this fix is
> > There are will only two acceptable situations for qemu:
> > 1. The hardware MAC address is the same as the MAC address specified
> > in the QEMU command line, and both MAC addresses are not 0.
> > 2. The hardware MAC address is not 0, and the MAC address in the QEMU
> > command line is 0. In this situation, the hardware MAC address will
> > overwrite the QEMU command line address.
> >
> Why would this not work with this patch? This patch simply sets a MAC
> if the vport doesn't have one set. Which allows for more scenarios to
> work.
>
I do not mean your patch will not work, I just want to make some
clarify here.Your patch + my fix may cause the VM to fail to load in
some situations, and this is as expected.
Your patch is good to merge.
Thanks
cindy

> Thanks,
> Dragos
>
> > Thanks
> > Cindy
> >
> >
> >>> ---
> >>>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/ne=
t/mlx5_vnet.c
> >>> index fa78e8288ebb..1c26139d02fe 100644
> >>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >>> @@ -3824,6 +3824,9 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_d=
ev *v_mdev, const char *name,
> >>>                 err =3D mlx5_query_nic_vport_mac_address(mdev, 0, 0, =
config->mac);
> >>>                 if (err)
> >>>                         goto err_alloc;
> >>> +
> >>> +               if (is_zero_ether_addr(config->mac))
> >>> +                       eth_random_addr(config->mac);
> >>>         }
> >>>
> >>>         if (!is_zero_ether_addr(config->mac)) {
> >>> --
> >>> 2.45.1
> >>>
> >>
> >
>


