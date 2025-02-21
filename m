Return-Path: <linux-kernel+bounces-525002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B621A3E9B6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24DB57A31C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A8E381A3;
	Fri, 21 Feb 2025 01:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqUYzsqc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92AE32C8E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100330; cv=none; b=hI9Gj9Y8F5ej4MhEcfoAKxv2bm3OVRwI05HiGKxW320iA1B9Rn2KF3HuhX89CiaiNJivWmxI4qRnGsxApWekHCX0zIOtvZnBsVvKtYVgmYcqjeNOwZ9NojyGt2NXI11fQOzIGH+1Me9Xu0yLih0OV52RSXukyfFBl0Eih1ZbD1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100330; c=relaxed/simple;
	bh=h8JtG26W+tN9sES1ZrmYwA3n0UnbXfgd8hcuR8Dzeu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u1wGbNzv1KhXj00eD/UlxIMCrwYkXqRnbZlVskaTIXJmntxA2MQkGslguG33IwY3cZwDHzs8r7IH9vpXGbh7/uwXOggOKrUUM4wAih1zi16/XwsdBipUqNuS+824xbiXRvppXTr9bxpwSXnM58xr49ZT5O2p9QzHnTG7FaemrZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CqUYzsqc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740100327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V2uP5OmbuFiEulUjSxw5yqkOeT8xFildQfqqZOxiLFk=;
	b=CqUYzsqcQN+yFrhBPbTExFMa5rNS5a1FDSIQv/AbCKFB0KuZ33WmsFMHGMlpaVqCX/MXDl
	3NP1JUSsYSoJqXvs5tRajPXhtt1Vn0Qjag1wyjlESUDClRfdVR0Fq3mra3ayTE/GULSg+G
	Nz2qa2o7fkCsrs9bGBCbrQ9CciQViug=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-3zUlpHQYPMijTPs3bnv9wQ-1; Thu, 20 Feb 2025 20:12:06 -0500
X-MC-Unique: 3zUlpHQYPMijTPs3bnv9wQ-1
X-Mimecast-MFC-AGG-ID: 3zUlpHQYPMijTPs3bnv9wQ_1740100325
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc1a70935fso3336422a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:12:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740100324; x=1740705124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2uP5OmbuFiEulUjSxw5yqkOeT8xFildQfqqZOxiLFk=;
        b=Psa/S7HE8obdOzlyqqUaUS+SRkr0WZKr7cIBIxwzuz9jkmJlRq+mHMa62hpzkDalj/
         YQcC0y8P8uK8j4ENo0UyF7MWpRIvEaZr3myhhs4WW3L1n/DGXGP3vsC4BgQc6UmjcWvH
         cxTeZY9bwL7fIeAlrRH5oWBVV51gBy4uKZjcRsRXGSxdNt8kx9WdCDNvBPfjDVLmp9VT
         LG4ILHE2mG7VVt3pI7uCilqVsoMJ92zJXWiBXf2E4N3fhYDVhqIu5YDX1EgBnXcxYIxh
         H8LGiuyFbFfSXHxnUDj/LWgiRFouWWzp60yUSa8R8KT68XljxtXZNwjEBuVUZQlUfMhS
         tplA==
X-Gm-Message-State: AOJu0Yz5yMgoLF2AdI8vKLVMf86DEXDkw0Y8BczyeFtp0sxwPzIC5cHb
	1eehQegn1hrowu8hiEIi9DCXkE+QPQS5Dx5iNiBnS0nTV/r/GHyva+K8ELcGO9yxtwbTprKIaxr
	61eXrXERPuGCTfR/TPdfr0RhM159pao2h+9dnub0H/1TOWp+R9eezvWfmfndktpZ/nNbz+G8TmJ
	MwnQkRZ0kB41cCTqjD5l5GOjpt8q6sTRZwfoZHYMc7itFP01jZWQWF
X-Gm-Gg: ASbGncv2eY9NK6vFnOXQJIoxrNjJ8aH71InF+ojxxpLCDaoyNu+SduXY3KkLPb0nb9Q
	aQbDN/CXLbcQp9QwpG3tVQmbBiCjso51M27uB/V3jcZbU9kTkWNlyPr7Cz1tscNw=
X-Received: by 2002:a17:90b:5292:b0:2ee:5bc9:75c7 with SMTP id 98e67ed59e1d1-2fce789e6acmr2105445a91.5.1740100324202;
        Thu, 20 Feb 2025 17:12:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IER+iSiuMQxunbjUmcStknwXYKOZqYWuiH5hTUxEg7WTxwgtt+csCQnXrUZ6sQ++5Rorm/la/GU9ouQSpBNGEU=
X-Received: by 2002:a17:90b:5292:b0:2ee:5bc9:75c7 with SMTP id
 98e67ed59e1d1-2fce789e6acmr2105379a91.5.1740100323470; Thu, 20 Feb 2025
 17:12:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c1dbc7dbad9b445245d3348f19e6742b0be07347.1740094946.git.mst@redhat.com>
In-Reply-To: <c1dbc7dbad9b445245d3348f19e6742b0be07347.1740094946.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 21 Feb 2025 09:11:51 +0800
X-Gm-Features: AWEUYZn7Xt5dPTAQ_1hit6NTeptFL4Ci46JoPA4BIky8CLGqgwWNZBKnelGziLY
Message-ID: <CACGkMEsK5Z_5B9Lz46kYYB_ndOG=CrvtZE_tLbRjL7=fT7OxbQ@mail.gmail.com>
Subject: Re: [PATCH] virtio: break and reset virtio devices on device_shutdown()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Eric Auger <eauger@redhat.com>, 
	Hongyu Ning <hongyu.ning@linux.intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 7:42=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
> accesses during the hang.
>
>         Invalid read at addr 0x102877002, size 2, region '(null)', reason=
: rejected
>         Invalid write at addr 0x102877A44, size 2, region '(null)', reaso=
n: rejected
>         ...
>
> It was traced down to virtio-console. Kexec works fine if virtio-console
> is not in use.
>
> The issue is that virtio-console continues to write to the MMIO even afte=
r
> underlying virtio-pci device is reset.

Some of my questions were not answered so I need to post them again.

Do we need to fix vitio-console?

Note that we've already break the device in virtio_pci_remove():

static void virtio_pci_remove(struct pci_dev *pci_dev)
{
  struct virtio_pci_device *vp_dev =3D pci_get_drvdata(pci_dev);
        struct device *dev =3D get_device(&vp_dev->vdev.dev);

        /*
         * Device is marked broken on surprise removal so that virtio upper
         * layers can abort any ongoing operation.
         */
        if (!pci_device_is_present(pci_dev))
                virtio_break_device(&vp_dev->vdev);

...

>
> Additionally, Eric noticed that IOMMUs are reset before devices, if
> devices are not reset on shutdown they continue to poke at guest memory
> and get errors from the IOMMU. Some devices get wedged then.
>
> The problem can be solved by breaking all virtio devices on virtio
> bus shutdown, then resetting them.
>
> Reported-by: Eric Auger <eauger@redhat.com>
> Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index c1cc1157b380..e5b29520d3b2 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -377,6 +377,36 @@ static void virtio_dev_remove(struct device *_d)
>         of_node_put(dev->dev.of_node);
>  }
>
> +static void virtio_dev_shutdown(struct device *_d)
> +{
> +       struct virtio_device *dev =3D dev_to_virtio(_d);
> +       struct virtio_driver *drv =3D drv_to_virtio(dev->dev.driver);
> +
> +       /*
> +        * Stop accesses to or from the device.
> +        * We only need to do it if there's a driver - no accesses otherw=
ise.
> +        */
> +       if (!drv)
> +               return;
> +
> +       /*
> +        * Some devices get wedged if you kick them after they are
> +        * reset. Mark all vqs as broken to make sure we don't.
> +        */
> +       virtio_break_device(dev);
> +       /*
> +        * The below virtio_synchronize_cbs() guarantees that any interru=
pt
> +        * for this line arriving after virtio_synchronize_vqs() has comp=
leted
> +        * is guaranteed to see vq->broken as true.
> +        */
> +       virtio_synchronize_cbs(dev);

This looks like a partial re-introduction of the hardening work, but
the ccw part is still in-completed e.g the synchronization requires a
read_lock() and depends on CONFIG_VIRTIO_HARDEN_NOTIFICATION (which is
marked as broken now).

Should it better to

1) fix the virtio-console
2) simply rest in shutdown
3) wait for the hardening work to be done in the future?

Thanks

> +       /*
> +        * As IOMMUs are reset on shutdown, this will block device access=
 to memory.
> +        * Some devices get wedged if this happens, so reset to make sure=
 it does not.
> +        */
> +       dev->config->reset(dev);
> +}
> +
>  static const struct bus_type virtio_bus =3D {
>         .name  =3D "virtio",
>         .match =3D virtio_dev_match,
> @@ -384,6 +414,7 @@ static const struct bus_type virtio_bus =3D {
>         .uevent =3D virtio_uevent,
>         .probe =3D virtio_dev_probe,
>         .remove =3D virtio_dev_remove,
> +       .shutdown =3D virtio_dev_shutdown,
>  };
>
>  int __register_virtio_driver(struct virtio_driver *driver, struct module=
 *owner)
> --
> MST
>


