Return-Path: <linux-kernel+bounces-310568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C46EE967E7D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62AC1C218BE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 04:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC3314D702;
	Mon,  2 Sep 2024 04:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XcgqsWm6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9751E50B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 04:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725251289; cv=none; b=COyacVHuh9MwgGDLAfX4y2H6QFoRUZ/e75yuBXgcyyw2pfM75WVMgaOszf8ffKQR7gKKrPUlJhlTiX29H7XUl5y6zXzGZ+ZZuugWWjxJ5Olv5pa7rakpNWyZ4lGNTjS5XBCCoL2wWhFwPv9dMFBOuKMGyvsrLCS9+bhyMlx0Tmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725251289; c=relaxed/simple;
	bh=imrdOP267f9TBBXh8m6wg6kbuBgsSfpHQtnHTBSQ4r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hyCbDFei2EJ9TZEMkpn2e7otwC9pJNVX51nVCtCbG+sQuN8LGeL18SxoDdvp8ga4wgPxYLUHyUovurD+MMrPN6hJMXWbd2YuNyARZXi4BlaEYR5ovCnyvauNYkMJJjMycf897wu4gNwuZ8HGKGsPMJWns1bUwWqhyXjfOhED5h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XcgqsWm6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725251284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/Gj4eDafKoQrJYXOLZ6AuCMbE6RyJc4zifVlDVrlgU=;
	b=XcgqsWm6qWeumgCqsUrLhkyzWE8ePGadig5sggh99aau4LmCHNE/Q4YQyR3lIrq0bhdYs3
	8yYOrQSW+0ISLydpUYIEcy50lA7r/wVkQwLjR6zomkXSkX9yHS5MSSt0zo6UEeflpgBGvF
	BVtFcs4MJtg+0tSa9m6Ijuj8QTwn35A=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-GWH3JfgkN9yHzFY1cdltZw-1; Mon, 02 Sep 2024 00:28:03 -0400
X-MC-Unique: GWH3JfgkN9yHzFY1cdltZw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d89dacf002so1844600a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 21:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725251282; x=1725856082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/Gj4eDafKoQrJYXOLZ6AuCMbE6RyJc4zifVlDVrlgU=;
        b=UiorlX+vyTm60ydlQ/gF/ADmOLo1ZFplfht0xdTjOzQzkt/TBQbMkxowHwExzFh1nv
         LZv22FEZI3pFlisa/DLAB0nCqT+1wHwyy31i0aCsUVyQVjLONhW15bgTpEi5WcCqZWpL
         cEWvZU4yWrB0ytOAgUM2i2f99+SH5cIC47tC1Uzk1oIxZCCZPGJ+OygdO0yz3ZkED4m8
         mp/80SJTEpoFWDuIJNo1f6Tlnpn2j9KBuN9E8uD+gQ1EBxUXAe4wPiCGWMAYfRd6aqyu
         iWMtwk8PxP9s9eqxRT0ZPDblByLxpGDLhKXUKB6akVx5IwxJrqg3bbzc5Vdysj+0u2J7
         r4eA==
X-Forwarded-Encrypted: i=1; AJvYcCU1xvmTmzDDi+x7eCopic09Sm7CZ13elwnamTZOuwEcG9HtTLCFKbvj+al40jZeIbQy0oHd4yld56zmmMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkhRNVkZxyQ9F/dXya1PwhedNoozFUcWloWygvQ0t+TMfxat3I
	VYT9YYKVFJSvnyaJjIa5Bt1LQsJsVy6v66OW5KZWdTH7p5X5uXpwL45RUg3Xb3XHDlTyT+r1yjc
	+d9fwHD2E1IxToOydhHeTDXyhzHihzfe+AfvfrKCnPHEAuSdjyPxNIlPg5wTwrJiMV8CjiSftwl
	BR4tJB6I7T8YwgP3cpkDhrq7zcM50R5A0uUI+A
X-Received: by 2002:a17:90b:2bc6:b0:2d8:99c4:3cd9 with SMTP id 98e67ed59e1d1-2d899c43e12mr6950231a91.3.1725251281964;
        Sun, 01 Sep 2024 21:28:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ70KQouOrad1n8w655Ru1U5qCbR6u/l5jxaDuXmg5lnMyHLK/m9F3iqPdkC3VCTOyETBUITjc0W1iTC600q4=
X-Received: by 2002:a17:90b:2bc6:b0:2d8:99c4:3cd9 with SMTP id
 98e67ed59e1d1-2d899c43e12mr6950211a91.3.1725251281369; Sun, 01 Sep 2024
 21:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829161620.38679-1-carlos.bilbao.osdev@gmail.com>
 <20240829161620.38679-3-carlos.bilbao.osdev@gmail.com> <c15d3682-05ee-437c-b51c-d6a824252d76@nvidia.com>
 <CACGkMEtDSDTS_SVvsf7nwMdabGCN85P-r5WpjgZdVDV5PMdc0g@mail.gmail.com> <f5e3768d-bb16-48eb-96df-ce5f9593b843@digitalocean.com>
In-Reply-To: <f5e3768d-bb16-48eb-96df-ce5f9593b843@digitalocean.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 2 Sep 2024 12:27:50 +0800
Message-ID: <CACGkMEtsNeL+o6Rgb=ehj8OJpfkoojasPK1ZMp4S5bMKBjwcng@mail.gmail.com>
Subject: Re: [PATCH 2/2] vdpa: Add support to update speed/duplex in vDPA/mlx5_vnet
To: Carlos Bilbao <cbilbao@digitalocean.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, mst@redhat.com, 
	bilbao@vt.edu, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	cratiu@nvidia.com, lingshan.zhu@intel.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 9:15=E2=80=AFPM Carlos Bilbao <cbilbao@digitalocean=
.com> wrote:
>
> Hello,
>
> On 8/29/24 9:31 PM, Jason Wang wrote:
> > On Fri, Aug 30, 2024 at 5:08=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia=
.com> wrote:
> >> (resending as I accidentally replied only to Carlos)
> >>
> >> On 29.08.24 18:16, Carlos Bilbao wrote:
> >>> From: Carlos Bilbao <cbilbao@digitalocean.com>
> >>>
> >>> Include support to update the vDPA configuration fields of speed and
> >>> duplex (as needed by VHOST_VDPA_SET_CONFIG). This includes function
> >>> mlx5_vdpa_set_config() as well as changes in vdpa.c to fill the initi=
al
> >>> values to UNKNOWN. Also add a warning message for when
> >>> mlx5_vdpa_get_config() receives offset and length out of bounds.
> >>>
> >>> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
> >>> ---
> >>>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 34 +++++++++++++++++++++++++++++=
+-
> >>>  drivers/vdpa/vdpa.c               | 27 ++++++++++++++++++++++++
> >>>  include/uapi/linux/vdpa.h         |  2 ++
> >>>  3 files changed, 62 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/ne=
t/mlx5_vnet.c
> >>> index c47009a8b472..a44bb2072eec 100644
> >>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >>> @@ -3221,12 +3221,44 @@ static void mlx5_vdpa_get_config(struct vdpa_=
device *vdev, unsigned int offset,
> >>>
> >>>       if (offset + len <=3D sizeof(struct virtio_net_config))
> >>>               memcpy(buf, (u8 *)&ndev->config + offset, len);
> >>> +     else
> >>> +             mlx5_vdpa_warn(mvdev, "Offset and length out of bounds\=
n");
> >>>  }
> >>>
> >>>  static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned =
int offset, const void *buf,
> >>>                                unsigned int len)
> >>>  {
> >>> -     /* not supported */
> >>> +     struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> >>> +     struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> >>> +
> >>> +     if (offset + len > sizeof(struct virtio_net_config)) {
> >>> +             mlx5_vdpa_warn(mvdev, "Offset and length out of bounds\=
n");
> >>> +             return;
> >>> +     }
> >>> +
> >>> +     /*
> >>> +      * Note that this will update the speed/duplex configuration fi=
elds
> >>> +      * but the hardware support to actually perform this change doe=
s
> >>> +      * not exist yet.
> >>> +      */
> >>> +     switch (offset) {
> >>> +     case offsetof(struct virtio_net_config, speed):
> >>> +             if (len =3D=3D sizeof(((struct virtio_net_config *) 0)-=
>speed))
> >>> +                     memcpy(&ndev->config.speed, buf, len);
> >>> +             else
> >>> +                     mlx5_vdpa_warn(mvdev, "Invalid length for speed=
.\n");
> >>> +             break;
> >>> +
> >>> +     case offsetof(struct virtio_net_config, duplex):
> >>> +             if (len =3D=3D sizeof(((struct virtio_net_config *)0)->=
duplex))
> >>> +                     memcpy(&ndev->config.duplex, buf, len);
> >>> +             else
> >>> +                     mlx5_vdpa_warn(mvdev, "Invalid length for duple=
x.\n");
> >>> +             break;
> >>> +
> >>> +     default:
> >>> +             mlx5_vdpa_warn(mvdev, "Configuration field not supporte=
d.\n");
> >> This will trigger noise in dmesg because there is a MAC configuration =
here.
> >>> +     }
> >> I would prefer that the .set_config remains a stub TBH. Setting the fi=
elds here is
> >> misleading: the user might deduce that the configuration worked when t=
hey read the
> >> values and see that they were updated.
> > Yes, and actually, those fields are read-only according to the spec:
> >
> > """
> > The network device has the following device configuration layout. All
> > of the device configuration fields are read-only for the driver.
> > """
> >
> > Thanks
>
>
> Should I go ahead and remove the ioctl then?

If you meant mlx5_vdpa_set_config, I think yes.

Thanks


