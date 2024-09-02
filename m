Return-Path: <linux-kernel+bounces-311004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB209683D5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D8B8B24B1B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E521D279F;
	Mon,  2 Sep 2024 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJrKfMex"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53604187335
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270972; cv=none; b=nZ+OXqkfSPVO0VrzmDDvGRg8GAI7b3tTvWeZtOtCVIj0ErpNmyHkuvocV1Jd+vSHqLEBkjWAhyYgsC9/aZcJkHdG/V2SV5GpLBhqcrVZ4WSaX00sZoNZk5ezaleRgxw5cESX54bB6PEQTfVoTN6MnHkaO5GJ812VsEOInQvBEgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270972; c=relaxed/simple;
	bh=kV8GFG++RaaBCEP6/7hW49kSFBGCuPBSKeMG+g/2Ypc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFQlaQgahhJjIDD2F1u+j3HOf1S+kbAOHXePlSKcjhinS2gvQs8bLSN0wMktDrpYM1XZyGSvT9F6tLIqctpp/D3RSPQ4Ez6Zwh1QCEtc1YZnecUG+u0a8xnBlMrKwBq6leqAUgrMhNU8VQGEz2p8gQkCeNjQC7nWMGgQ3q4rRK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJrKfMex; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725270969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Hxuy7nxxFJKkwMiUTcDUdREPM6hh6QhSwYBkqKlx2c=;
	b=WJrKfMexUaDj2tUCwdEzCPZazOcPxnYjrw0ASjiW7Mfq4/NGQOYg0TRSC/pEaaMt/pDK1L
	NIluyvV7UgETOSEhWJe0t65w/50hML6KH+jBbPykY0wL3vdwaAlppx2woUDHvxE7Iz7J8Z
	1v97gxCkZUoFokaHJxbByGQ/e2PJCWw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-uj6AygklOsGAy_C68yYw4g-1; Mon, 02 Sep 2024 05:56:07 -0400
X-MC-Unique: uj6AygklOsGAy_C68yYw4g-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f4f8aa3856so37178591fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 02:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725270966; x=1725875766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Hxuy7nxxFJKkwMiUTcDUdREPM6hh6QhSwYBkqKlx2c=;
        b=ThdzpKto6+gEC+4uZcSQchYGcsGFbzlOy4+jaAA8aI87LawrdCdMK3ehYEk8PtebTO
         QG5D/BKZ7ZUgn3KZQnNfs92ysYWGGM6U5/0B9X+AR/rPcE9kko16L0DUo6JSrKNU1lU/
         4h4WYkMgXkVh9kV4kEukif0BZMyarifbaH59UC5PpXitaMCNxmpdTkg0z86Bl196fPWk
         IDBDJ/b6tfmzflfC5tvpaVoD64WVY3GML5KuCynXfBuHzBWZ42dI2bSQkILiStoLOQzk
         J4aatLnnffsM+M+051KD1/dXCTxwzvEOCHeYkN75eTqS5wXXVMYXHqUzrM6rEwo49pwv
         0IoA==
X-Forwarded-Encrypted: i=1; AJvYcCVFZtQx/f5S/4ZQ4/J2LsxGgMumvzB+1+i0hIWXtkdta91kkkFN4IXQbpj8l6XeTCmqWTLZtG/tsDXvFxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSZNziI+kz6h5v0gvzf//3pzsAdrc4AMWve8JeZQ2QN/vVNSJF
	LU/TXr8I1/qvtfSamFTjOHTLpO3qaVoPOMWPS9CszlBOPw4E4lZ1HjcAdNiR4pyF40ieqyNPKuk
	++WXQ5oPpooNsXhOw+FVzoR7jzbAG8OsxSZZEso+MSuyi0bgf78BAwkugMhueFCJNARn9rXMEon
	+I+uvZBudWdfTiXlERJI2NP3vl1xWZxU67zA1c
X-Received: by 2002:a05:651c:b24:b0:2ef:2dc7:a8f6 with SMTP id 38308e7fff4ca-2f62903f97dmr50977091fa.13.1725270966067;
        Mon, 02 Sep 2024 02:56:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzeOLvsXNoMvOifaQjOvbimoOBIPmu3unrgxdch7eTc5cP16ueig+KVeJk8Reb0ILjM8ucdhhIMPOBQwXYBYQ=
X-Received: by 2002:a05:651c:b24:b0:2ef:2dc7:a8f6 with SMTP id
 38308e7fff4ca-2f62903f97dmr50976771fa.13.1725270965459; Mon, 02 Sep 2024
 02:56:05 -0700 (PDT)
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
 <CACLfguXM97JAdWcYO17+H6pu7MWLu2QqBgu_PypGxU_Ab+OUOQ@mail.gmail.com> <20240901144739-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240901144739-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 2 Sep 2024 17:55:28 +0800
Message-ID: <CACLfguWC-gGoY3JmMA-jU1W7OgkAEQ9iJ8TpZbRtE2iJ5++GxQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC address when no nic vport MAC set
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	si-wei.liu@oracle.com, Jiri Pirko <jiri@nvidia.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Sept 2024 at 02:49, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Aug 30, 2024 at 05:29:14PM +0800, Cindy Lu wrote:
> > On Fri, 30 Aug 2024 at 03:03, Dragos Tatulea <dtatulea@nvidia.com> wrot=
e:
> > >
> > >
> > >
> > > On 29.08.24 12:00, Dragos Tatulea wrote:
> > > >
> > > >
> > > > On 29.08.24 11:05, Cindy Lu wrote:
> > > >> On Wed, 28 Aug 2024 at 17:37, Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
> > > >>>
> > > >>>
> > > >>>
> > > >>> On 28.08.24 11:00, Cindy Lu wrote:
> > > >>>> On Wed, 28 Aug 2024 at 09:51, Jason Wang <jasowang@redhat.com> w=
rote:
> > > >>>>>
> > > >>>>> On Wed, Aug 28, 2024 at 12:03=E2=80=AFAM Dragos Tatulea <dtatul=
ea@nvidia.com> wrote:
> > > >>>>>>
> > > >>>>>> When the vdpa device is configured without a specific MAC
> > > >>>>>> address, the vport MAC address is used. However, this
> > > >>>>>> address can be 0 which prevents the driver from properly
> > > >>>>>> configuring the MPFS and breaks steering.
> > > >>>>>>
> > > >>>>>> The solution is to simply generate a random MAC address
> > > >>>>>> when no MAC is set on the nic vport.
> > > >>>>>>
> > > >>>>>> Now it's possible to create a vdpa device without a
> > > >>>>>> MAC address and run qemu with this device without needing
> > > >>>>>> to configure an explicit MAC address.
> > > >>>>>>
> > > >>>>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > >>>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > > >>>>>
> > > >>>>> Acked-by: Jason Wang <jasowang@redhat.com>
> > > >>>>>
> > > >>>>> (Adding Cindy for double checking if it has any side effect on =
Qemu side)
> > > >>>>>
> > > >>>>> Thanks
> > > >>>>>
> > > >>>> But Now there is a bug in QEMU: if the hardware MAC address does=
 not
> > > >>>> match the one in the QEMU command line, it will cause traffic lo=
ss.
> > > >>>>
> > > >>> Why is this a new issue in qemu? qemu in it's current state won't=
 work
> > > >>> with a different mac address that the one that is set in HW anywa=
y.
> > > >>>
> > > >> this is not a new bug. We are trying to fix it because it will cau=
se
> > > >> traffic lose without any warning.
> > > >> in my fix , this setting (different mac in device and Qemu) will f=
ail
> > > >> to load the VM.
> > > > Which is a good thing, right? Some feedback to the user that there =
is
> > > > a misconfig. I got bitten by this so many times... Thank you for ad=
ding it.
> > > >
> > > >>
> > > >>>> So, Just an FYI here: if your patch merged, it may cause traffic=
 loss.
> > > >>>> and now I'm working in the fix it in qemu, the link is
> > > >>>> https://patchew.org/QEMU/20240716011349.821777-1-lulu@redhat.com=
/
> > > >>>> The idea of this fix is
> > > >>>> There are will only two acceptable situations for qemu:
> > > >>>> 1. The hardware MAC address is the same as the MAC address speci=
fied
> > > >>>> in the QEMU command line, and both MAC addresses are not 0.
> > > >>>> 2. The hardware MAC address is not 0, and the MAC address in the=
 QEMU
> > > >>>> command line is 0. In this situation, the hardware MAC address w=
ill
> > > >>>> overwrite the QEMU command line address.
> > > >>>>
> > > >>> Why would this not work with this patch? This patch simply sets a=
 MAC
> > > >>> if the vport doesn't have one set. Which allows for more scenario=
s to
> > > >>> work.
> > > >>>
> > > >> I do not mean your patch will not work, I just want to make some
> > > >> clarify here.Your patch + my fix may cause the VM to fail to load =
in
> > > >> some situations, and this is as expected.
> > > >> Your patch is good to merge.
> > > > Ack. Thank you for the clarification.
> > > (Side note)
> > > While looking at another issue I discovered that it's possible to
> > > configure a random MAC on the mlx5_vdpa device at VM boot time if
> > > device MAC configuration is implemented during during .set_config(). =
So
> > > I was able to boot up a VM with a random MAC address coming from qemu
> > > and the traffic worked with this new MAC.
> > >
> > > So now I'm not sure if this is just by luck or if the .set_config()
> > > op should be implemented for the MAC part in our device.
> > >
> > > Thanks,
> > > Dragos
> > >
> > Hi Dragos=EF=BC=8C
> > For qemu part, I think this is not set from set_config()?  it should
> > be from the CVQ?
>
>
> You are confusing two things.
> Provisioning is not through CVQ.
>
Thanks, Michael. I'm sorry for the confusion. I just meant that maybe
the MAC address is set through CVQ. I will make it clearer next time.
Thanks
Cindy
>
> > Usually, we don't recommend using the set_config() function because
> > the configuration space should be read-only for modern devices.
> >
> > Now there is a bug in this part of qemu, and we plan to remove the
> > code to set_config() in virtio_net_device_realize(), here is the patch
> > https://lore.kernel.org/all/CACGkMEvCSKfahpBQLAMmSzdFN-QPhg5Zx+UQVrFX0H=
sWybZZNA@mail.gmail.com/T/
> > and this is still under review
> >
> > thanks
> > cindy
>


