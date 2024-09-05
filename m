Return-Path: <linux-kernel+bounces-316208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5728896CC96
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 04:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736F61C22D40
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA55C131E38;
	Thu,  5 Sep 2024 02:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+EpqoZN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E25D138490
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 02:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725503041; cv=none; b=DGq3B/mLsEwxAtxVgJ/8zsD6SFrtgF+osZpOD4jPFLxukBG8Yq9eJv89oM+4tiuQYqMdaI0cZ7KpG+6i9JFJ8K9gYjuceKYTPK/KAJCwaRznW4hUjyHLGCXpVavusu1y/LrwSxzxzECq8ylfG4qa8pE9DqUUIqbEYQ4tmAOozPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725503041; c=relaxed/simple;
	bh=a6s7qQ3k+HcZs8eL+uK/csotPie51XK3iW4gPhvjzLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtsY+LqMR5pxD49F89lz0Ejy4CTey7x4Nvj+9TO80TLicbAXlW7itEs/LwIKajVynK5QrQwz1slQSHfk4F7rsw7Ca11491aMB81JUSMNMiDAM798XPW/FdRJEPfonONgcdUApVpMv2XnkPcLzw5/BJsofVNZKw2lftSkpsT7i00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+EpqoZN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725503037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6s7qQ3k+HcZs8eL+uK/csotPie51XK3iW4gPhvjzLs=;
	b=D+EpqoZNhv+CMaoTAdfo5Cu3qaEN4+XBBdBymOkz7jwLN0ELNpw+vpymeEOjtfdMvvut4z
	Z7ozYRMVQMIKNb8+XFvVy2l+NdeX13PtgrRl9n7sY021sko4grJ2WJK7Fz4BFLn2UwZzpD
	3SB+VvzYZzrIjYYoYHZZkr8NSoUNnHM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-mniIG-CbPEWQHy2GqLdlDQ-1; Wed, 04 Sep 2024 22:23:56 -0400
X-MC-Unique: mniIG-CbPEWQHy2GqLdlDQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d876431c4aso274324a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 19:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725503035; x=1726107835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6s7qQ3k+HcZs8eL+uK/csotPie51XK3iW4gPhvjzLs=;
        b=CdkmLHJrY+zGK4rbPNwzcHKu80TPIi0HhUvaq5ZmJJxc3r8evpGoYuiNJvhgIOvqCk
         AwTIKO9LOfKZMl+TMZ+2/JiM7rQvtqKsMLjLSlpfLj5Kmw7wF63TizUWMcwWoBMSiw+M
         FIu80pytZ3yQ7YQD5EyEH7Klml5/6NDdRRvGWAc5f9Ph9eYAmcDRk00BOC2cZIR91rHq
         0TFwnnMvMmPyv+SFmyjxYhz/MxTDvoQtU5xZc3CWCj3RS8z0OfcWfDC83h9Mhr44klVs
         oc3RQb2L6+mMhgqqYv4HJ/Va3v9vmZ362354SQOCF1iDTM0AcjQuPaNzhTq65e2EP4il
         IfZg==
X-Forwarded-Encrypted: i=1; AJvYcCVwrDg0X7UhJ5bw+taRNgEZICBjoNHcIy7XotBBFoRcCENmMVwaTcUs2MGob0CGkVwpMP670jlXeOQogbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCRu9Nce9oHO2b+TD8Ju2d1xdAySuGczwWBcAQmXPGgx5CLycZ
	ZRj6cBhyFhbqgp1dZdh1VQE80cGGyzO/pSXvYPkWsGurxOXXPBDJRL8/2MgQqeYsifmsBUt37XA
	+mEdx0PC46r2a/R0fe4JCUrUhpQf1D1x2tCEwXSBCdFEQ59NLHmZOf6MuPRfoyARNBh11NcpAKF
	ty5SkM2la9pzgXf4TwSnScSvkOSFJk6mJ+QOCB
X-Received: by 2002:a17:90a:fd8b:b0:2c5:10a6:e989 with SMTP id 98e67ed59e1d1-2da6344ce5bmr7804066a91.35.1725503035425;
        Wed, 04 Sep 2024 19:23:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG23zHXhEHTjyKBW3CywgbRBX6O92NrUsGkTQ5WvgrENGy5961jGcrmiJ4JtIcJZJk6DZcvqrJ35iW8k8+jExs=
X-Received: by 2002:a17:90a:fd8b:b0:2c5:10a6:e989 with SMTP id
 98e67ed59e1d1-2da6344ce5bmr7804048a91.35.1725503034966; Wed, 04 Sep 2024
 19:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903171514.201569-1-carlos.bilbao.osdev@gmail.com>
 <20240903171514.201569-3-carlos.bilbao.osdev@gmail.com> <CACGkMEvHU0VnOEZbVnEr1SvmOF5PhMtKk=M2o7Wwq-DUO9p7Uw@mail.gmail.com>
 <faafc28a-23a9-4dff-8223-1c72acb42443@nvidia.com> <CACGkMEtZHnkBj2JKaEp=7xURtkUFy=vFQEO8LZ7z7hoFafDMVg@mail.gmail.com>
 <ea0010cc-1028-4fe6-9f95-26677142fe42@nvidia.com>
In-Reply-To: <ea0010cc-1028-4fe6-9f95-26677142fe42@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Sep 2024 10:23:43 +0800
Message-ID: <CACGkMEvfdUYLjx-Z+oB11XW-54ErJsQMKcnu2p=dsj5N_BiEKw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vdpa: Remove ioctl VHOST_VDPA_SET_CONFIG per spec compliance
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, mst@redhat.com, shannon.nelson@amd.com, 
	sashal@kernel.org, alvaro.karsz@solid-run.com, christophe.jaillet@wanadoo.fr, 
	steven.sistare@oracle.com, bilbao@vt.edu, xuanzhuo@linux.alibaba.com, 
	johnah.palmer@oracle.com, eperezma@redhat.com, cratiu@nvidia.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Carlos Bilbao <cbilbao@digitalocean.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 1:48=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
>
>
> On 04.09.24 08:34, Jason Wang wrote:
> > On Wed, Sep 4, 2024 at 1:59=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.=
com> wrote:
> >>
> >>
> >>
> >> On 04.09.24 05:38, Jason Wang wrote:
> >>> On Wed, Sep 4, 2024 at 1:15=E2=80=AFAM Carlos Bilbao
> >>> <carlos.bilbao.osdev@gmail.com> wrote:
> >>>>
> >>>> From: Carlos Bilbao <cbilbao@digitalocean.com>
> >>>>
> >>>> Remove invalid ioctl VHOST_VDPA_SET_CONFIG and all its implementatio=
ns
> >>>> with vdpa_config_ops->set_config(). This is needed per virtio spec
> >>>> requirements; virtio-spec v3.1 Sec 5.1.4 states that "All of the dev=
ice
> >>>> configuration fields are read-only for the driver."
> >>>>
> >>>> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
> >>>
> >>> Note that only the config space of the modern device is read only. So
> >>> it should be fine to remove vp_vdpa which only works for modern
> >>> devices.
> >> Just out of curiosity: how will this work for devices that are not
> >> v1.3 compliant but are v1.2 compliant?
> >
> > Devices don't know the version of the spec, it works with features.
> > For example, most devices mandate ACCESS_PLATFORM which implies a
> > mandatory VERSION_1. So they are modern devices.
> >
> And modern devices should not write to the device config space.

It depends on the type of the device.

For example, for blocking device, write_back could be modified by
guest if VIRTIO_BLK_F_CONFIG_WCE is neogitated:

"""
If the VIRTIO_BLK_F_CONFIG_WCE feature is negotiated, the cache mode
can be read or set through the writeback field. 0 corresponds to a
writethrough cache, 1 to a writeback cache13. The cache mode after
reset can be either writeback or writethrough. The actual mode can be
determined by reading writeback after feature negotiation.
"""

> This
> was discouraged in v1.x until v1.3 which now prohibits it. Did I get
> this right?

It really depends on the semantics of the field. My understanding is
that, from 1.0 to 1.3 there's no writable fields defined in the spec.
But it doesn't mean we can't have one in the future.

Thanks

>
> Thanks,
> Dragos
>
> >> Or is this true of all devices
> >> except eni?
> >
> > ENI depends on the virtio-pci legacy library, so we know it's a legacy
> > device implementation which allows mac address setting via config
> > space.
> >
> > Thanks
> >
> >>
> >> Thanks,
> >> Dragos
> >>>
> >>> And for eni, it is a legacy only device, so we should not move the
> >>> set_config there.
> >>>
> >>> For the rest, we need the acks for those maintainers.
> >>>
> >>> Thanks
> >>>
> >>
> >
>


