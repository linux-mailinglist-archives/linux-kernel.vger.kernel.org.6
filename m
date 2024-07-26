Return-Path: <linux-kernel+bounces-263304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B17F93D413
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF9B1C23603
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C961F17C22A;
	Fri, 26 Jul 2024 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJf/WL7y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAFF17BB1D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722000080; cv=none; b=NbjTtCjueB9Nbgr2GWwNzP6/mOXlf7X01q1fmxBRvn8j5yTTsRtHKcgzF2ksFHFmQRc9B0W38NVvYAF2VGJ0xsYuBInplTotci3gPtQ/hagdlDpfmPbJYSnLmuqZB8mRGlJJLmX7ElyEir4SHY37ZVUW8qMsN3hLF42AtUC4ESs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722000080; c=relaxed/simple;
	bh=K65IvizrkiF4Iqqucr2Z1Xdr6ozHH4a8FmSnlkgup3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Ci/hznonT28LYVng+Ptc49YayUe1Vb260ayVD7oU1gH+24J2Qf7O5BGqMG/7iR/ZQPpiUl4yERgLgsr3djLWmKMYKHfmkXwZM9wVPsIyvjxZF4GHjFu+XMuoApkfTLVmL1yzO1wDtMoD4wcjBJZl+cal5+PJRVPk1JFTIMOr2qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJf/WL7y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722000077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xfF8kA8g/5K/XYp2vCMWS52kuH2/f1toD92MP8xAumA=;
	b=EJf/WL7yD8rl1NmoZIWvWS9qWHkCEDjEp+4RyZqZpi4PMZsWBz+ICyL613tm5aUOYZdivR
	8pOIHqNIB2QMKD/lcOojeMIX/p3Q18V+sVY6Kxjod84mPcaWLTvYrCbO7DfgV1ARHg9EjG
	BA05gEbvhO79V5GlUVGzCGKeQKUpDeU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-sz_zmvGAOFO-pBUBQXUlfw-1; Fri, 26 Jul 2024 09:21:16 -0400
X-MC-Unique: sz_zmvGAOFO-pBUBQXUlfw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5a25d0755f3so1865454a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 06:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722000074; x=1722604874;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfF8kA8g/5K/XYp2vCMWS52kuH2/f1toD92MP8xAumA=;
        b=uaTxTcD2VDQij2L01/zTOoo4A5DeavvP0BxjildcsIBaf0w3FARPx0qQ1cuguwSm98
         e0+cyDEDxc2acz7XYiHIAH3jFqVlImiqGwBT+jiPQLWdHXjFU4WWvHZfWxnLyKC6BT5Y
         Qj5Jh147aGdl7+Rj69IIVk9cnnqXLcl+ZXGQWlaGtm7x6tcIqiT+r8vDM5aSv6GmQ2u8
         Ij06AIthmDhxepI2MNvw8KisToYxuO0/+QRMOjUR1x0UuZgwkMy05u+TCFb8CZmmr3zt
         aFgACX+FngkYPfv79F/8yEP4ZnAMExMFXTAVBvb6I1gh2QU0Vjzf5XSHIE8IpzhdkUMm
         /IQg==
X-Forwarded-Encrypted: i=1; AJvYcCXe6X/iUZgfrvqhtEXPed6GmsyxOy+gvwTK7qbvbHPakah381mfeyJzDELtaD7baQjrrrxi2BHqEDVgCo5L/r+0fJIqeHUB4ME05sQJ
X-Gm-Message-State: AOJu0YxFKUN9PcSp79Nx2WSBRaRh04DvZh0NX1HsLJewpu8oAto66CZW
	SteEJqsfYZzKF9vLRZjn8IoQX/hvHhEyResarPefPy0RFBquQyx+TggoaOY5KuIrCaOKoku58nL
	EhxJsd0vjfivqtwtObYhU6fJX6yWxkVnpgvxYW+S4ZwQ3nGscb7lOmmIrmlnSmzUnbK3UqIjfE6
	qzzJvQMutFgDs0lTVVwSUThhJ+Ky42kI82R74Ug1EwppTNqW8=
X-Received: by 2002:a50:c04d:0:b0:5a3:b45:3970 with SMTP id 4fb4d7f45d1cf-5ac27750881mr3155025a12.0.1722000074170;
        Fri, 26 Jul 2024 06:21:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWDnNKpy4OxfBSVuSmYdRoaFihsPhdouxRuwt/96M7BlYl2KRazN2ZOfpWIg1WDgG3Um4QtyroVHGsGBXWCXw=
X-Received: by 2002:a50:c04d:0:b0:5a3:b45:3970 with SMTP id
 4fb4d7f45d1cf-5ac27750881mr3154998a12.0.1722000073790; Fri, 26 Jul 2024
 06:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725013217.1124704-1-lulu@redhat.com> <20240725013217.1124704-4-lulu@redhat.com>
 <ZqKMEoDIZx8XFhlq@LQ3V64L9R2>
In-Reply-To: <ZqKMEoDIZx8XFhlq@LQ3V64L9R2>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 26 Jul 2024 21:20:36 +0800
Message-ID: <CACLfguX7_Nvfy2wZ8WTNPOnBZxi43VKRLdhm-axUdE=m3ZsTVw@mail.gmail.com>
Subject: Re: [PATH v6 3/3] vdpa/mlx5: Add the support of set mac address
To: Joe Damato <jdamato@fastly.com>, Cindy Lu <lulu@redhat.com>, dtatulea@nvidia.com, 
	mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jul 2024 at 01:32, Joe Damato <jdamato@fastly.com> wrote:
>
> On Thu, Jul 25, 2024 at 09:31:04AM +0800, Cindy Lu wrote:
> > Add the function to support setting the MAC address.
> > For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> > to set the mac address
> >
> > Tested in ConnectX-6 Dx device
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index ecfc16151d61..d7e5e30e9ef4 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -3785,10 +3785,38 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
> >       destroy_workqueue(wq);
> >       mgtdev->ndev = NULL;
> >  }
>
> Nit: Other code in this file separates functions with newlines,
> perhaps one is needed here?
>
> > +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
> > +                           struct vdpa_device *dev,
> > +                           const struct vdpa_dev_set_config *add_config)
>
> Nit: it appears that the alignment is off on these parameters. Did
> checkpatch.pl --strict pass on this?
>
sure, will check  this
thanks
> > +{
> > +     struct virtio_net_config *config;
> > +     struct mlx5_core_dev *pfmdev;
> > +     struct mlx5_vdpa_dev *mvdev;
> > +     struct mlx5_vdpa_net *ndev;
>
> [...]
>


