Return-Path: <linux-kernel+bounces-308399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 683BB965C72
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D6F28881C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EBF16F8FE;
	Fri, 30 Aug 2024 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AX+IJh/D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D36014BFB4
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009167; cv=none; b=m+IpLB6g8aHmn70Q4A0Wro1TnQyC1zfl+1AyMMQ6LF08cMPjS0wmKSqBEYlXpNyQK8S7bUnyD2A9SwJGZIEsLz71h36U+BY3fu0GXB77GGgRbI4081H4f0iDRGU58ICnZOHwxwNYzTXoOukrynbfhnkdwUWUNN2W0e5zZkyhHmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009167; c=relaxed/simple;
	bh=SINFdJPoipSq6B0XzZXAT/MZKOd7H6FH7GZhOdBLBz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKB2S17ArdeKuU0XW1+DiVPgqBkBbyUhMXq4pHEoU3gwscHbDiBST0NFw6ELZATdZa0njhejSbcGRKkGWfknhFx4OiXrvyyBK+Q/sy6xYvwkNA9DjJfWEJbAvADLGV+4FfFb/gFSK88P7iR4Exy+mVRd7TXQqiMYI90iiTphYt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AX+IJh/D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725009164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SINFdJPoipSq6B0XzZXAT/MZKOd7H6FH7GZhOdBLBz0=;
	b=AX+IJh/Dis5mCFtwmjNrleT4H7M+LNIYjTB3QE4hSATL/13h18pPJbwyb33LGDExzCoTwS
	4x7rLszqzTkej/kgR3WEAosnxq4jYHHbCc2MNtebSyXR4cgsffHnlOqAAZufk1gHOZ19wR
	kDt01u6TVTbC41FCSFGOsiFb3HOCcN0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-3rtgLd8sNGS6ClADoHAo5Q-1; Fri, 30 Aug 2024 05:12:42 -0400
X-MC-Unique: 3rtgLd8sNGS6ClADoHAo5Q-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f3f1bbe2e2so14548731fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725009160; x=1725613960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SINFdJPoipSq6B0XzZXAT/MZKOd7H6FH7GZhOdBLBz0=;
        b=tlPz/bAGx6im2RudeTF6CLUOjduzsNZZPCkDKmx5l/1RWFhvGNzNA/ShAat3y1FC/e
         aQIF/hXRXe/kzJNA/JY490n4tIFVopXiwFKCHa2fGuaLi2cnIQxpV9T0cC4eBQtpFpAI
         Ww+77Zq3VuUjSXG8SE1ko5thRH0oSkKqTqaaXzWBgJtDqQJkWyXi9GiVsN0f8f3Cc2bQ
         wttltoCYpglcJHfX8AuR19MDa8K5Vf8+XT2LoU3YernowIgRFoAJ+psiUe8MhRtngAqK
         k9qtO/xpYDtJEEqDfvHFGHgvRfUD+gjx2vroAR3ug+0n5woajcFPyA/xUl+Eb4PSLVtN
         4n/g==
X-Forwarded-Encrypted: i=1; AJvYcCXdXVRwuSYJKfFbTAcVawj741CENyOd4mnO6V6LzbcE6Hh8wulSqr38ikRfrdkSQU3rUEJ5ehOobUQSmsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx79MlAeHLS/D1ROi+FlyW3Hh1nXyTnH3WP82g+M7HGro0q8a4f
	p6xsagGO8DKZVpnalrKrkhVodzxTn5NeVsWo1UY+2CYQDkYIIFuCsmB1xXP/ZGLk5b7heA2SaKS
	LzlVfy+U/ZmkL77aHII8zwiTSoulIkcjTLT2zuvLfAVg4sBiX5zj3iCza5rmxst3hbzMGaRcYOH
	qupLQFkZYu4MxrXprYbTwGOiuhwhjoOxiK70LkbMuI5m7Q9hQ=
X-Received: by 2002:a05:651c:222c:b0:2f5:6b4:1d2b with SMTP id 38308e7fff4ca-2f61e034615mr13954171fa.13.1725009159835;
        Fri, 30 Aug 2024 02:12:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx+7zpNw5wyC7zeqxZI3w14nDhLouIpkuw8Id9KoCYeso6ZNcL7RMONv+ns76dIfFrNIHKuz8bUc8RmQN9dXA=
X-Received: by 2002:a05:651c:222c:b0:2f5:6b4:1d2b with SMTP id
 38308e7fff4ca-2f61e034615mr13953781fa.13.1725009159238; Fri, 30 Aug 2024
 02:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827160256.2446626-2-dtatulea@nvidia.com> <CACGkMEuRvqu8W9-OqPBRhn1DG-+DO6TCzFdHqc7zB74GkNDkAQ@mail.gmail.com>
 <CACLfguXjiyp+Ya4mUKXu6Dmb3Wx5wW0bbNGRSFWE-Z0E5gALTA@mail.gmail.com>
 <8daf221f-8d87-4da1-944c-3bcd0edea604@nvidia.com> <CACLfguVr1bd6=bkGn6hX3W7xBr45qydaCpQ1mNpsATeWFqe2ZA@mail.gmail.com>
 <55b7ae23-6000-4699-9bac-5e72fbdcd803@nvidia.com>
In-Reply-To: <55b7ae23-6000-4699-9bac-5e72fbdcd803@nvidia.com>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 30 Aug 2024 17:12:01 +0800
Message-ID: <CACLfguUZVDGaY4MD+_tDqM9DQC-C6cuPfCf34X59e2RkMztEkA@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC address when no nic vport MAC set
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	si-wei.liu@oracle.com, Jiri Pirko <jiri@nvidia.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Aug 2024 at 18:00, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>
>
>
> On 29.08.24 11:05, Cindy Lu wrote:
> > On Wed, 28 Aug 2024 at 17:37, Dragos Tatulea <dtatulea@nvidia.com> wrot=
e:
> >>
> >>
> >>
> >> On 28.08.24 11:00, Cindy Lu wrote:
> >>> On Wed, 28 Aug 2024 at 09:51, Jason Wang <jasowang@redhat.com> wrote:
> >>>>
> >>>> On Wed, Aug 28, 2024 at 12:03=E2=80=AFAM Dragos Tatulea <dtatulea@nv=
idia.com> wrote:
> >>>>>
> >>>>> When the vdpa device is configured without a specific MAC
> >>>>> address, the vport MAC address is used. However, this
> >>>>> address can be 0 which prevents the driver from properly
> >>>>> configuring the MPFS and breaks steering.
> >>>>>
> >>>>> The solution is to simply generate a random MAC address
> >>>>> when no MAC is set on the nic vport.
> >>>>>
> >>>>> Now it's possible to create a vdpa device without a
> >>>>> MAC address and run qemu with this device without needing
> >>>>> to configure an explicit MAC address.
> >>>>>
> >>>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> >>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> >>>>
> >>>> Acked-by: Jason Wang <jasowang@redhat.com>
> >>>>
> >>>> (Adding Cindy for double checking if it has any side effect on Qemu =
side)
> >>>>
> >>>> Thanks
> >>>>
> >>> But Now there is a bug in QEMU: if the hardware MAC address does not
> >>> match the one in the QEMU command line, it will cause traffic loss.
> >>>
> >> Why is this a new issue in qemu? qemu in it's current state won't work
> >> with a different mac address that the one that is set in HW anyway.
> >>
> > this is not a new bug. We are trying to fix it because it will cause
> > traffic lose without any warning.
> > in my fix , this setting (different mac in device and Qemu) will fail
> > to load the VM.
> Which is a good thing, right? Some feedback to the user that there is
> a misconfig. I got bitten by this so many times... Thank you for adding i=
t.
>
> >
> >>> So, Just an FYI here: if your patch merged, it may cause traffic loss=
.
> >>> and now I'm working in the fix it in qemu, the link is
> >>> https://patchew.org/QEMU/20240716011349.821777-1-lulu@redhat.com/
> >>> The idea of this fix is
> >>> There are will only two acceptable situations for qemu:
> >>> 1. The hardware MAC address is the same as the MAC address specified
> >>> in the QEMU command line, and both MAC addresses are not 0.
> >>> 2. The hardware MAC address is not 0, and the MAC address in the QEMU
> >>> command line is 0. In this situation, the hardware MAC address will
> >>> overwrite the QEMU command line address.
> >>>
> >> Why would this not work with this patch? This patch simply sets a MAC
> >> if the vport doesn't have one set. Which allows for more scenarios to
> >> work.
> >>
> > I do not mean your patch will not work, I just want to make some
> > clarify here.Your patch + my fix may cause the VM to fail to load in
> > some situations, and this is as expected.
> > Your patch is good to merge.
> Ack. Thank you for the clarification.
>
> Thanks,
> Dragos
>
Hi Dragos=EF=BC=8C
 I think we need to hold this patch. Because it may not be working
with upstream qemu.

MLX will create a random MAC address for your patch. Additionally, if
there is no specific MAC in the QEMU command line, QEMU will also
generate a random MAC.
these two MAC are not the same. and this will cause traffic loss.
As I mentioned before, this is a bug in QEMU, and I'm working on fixing it.

Thanks
Cindy


