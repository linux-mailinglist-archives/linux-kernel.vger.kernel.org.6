Return-Path: <linux-kernel+bounces-251991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CE3930CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 04:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9B51C20C47
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 02:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EB26FC2;
	Mon, 15 Jul 2024 02:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqYOOEAH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7D0848D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 02:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721010910; cv=none; b=ZZG7tE6qDsV63gGM0eYbeuKrr2yVTfhm/ODVgkbIinHcUC5uMI7FGsnQ8JwGGdiDEu6m48cRRy7OqaPzWHdWJUlif58Xc7uBhA32mkazMrAJTUvCVxvdOuzDYGH5GHCOQ2frSVFP1+0FFuO5o9k7LrA7csAJpzcaZ7LzZ4sqnOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721010910; c=relaxed/simple;
	bh=kB41NnpfhwQpkmS6Ee8KfAI26ATy3gY4gwt3M1klEsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBLL4YbjeUGObwqPPZHoEEHexa9t3eu/eXAvwoTAXcMBG21KqRxgH7DeNILteJHEopjCYtWr0sxp1/nVrZT521rMMCOWSKYtIWy1eb+q5MuYnf7DvPKkWoH1eXplkzyw3DpRKjOoa8jkWysFME5DN9jO3ZTTEr8p8RkxZCTZMq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LqYOOEAH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721010907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=55lW7NJ8ejky4hgV7bfotKSxsKudqxlk6ZTrH104m/o=;
	b=LqYOOEAH5UPICbHgdkJdIt+ii7KUaV/sJhwCgIj3HtyFrCy6hJEU2cEjjjtXpxvmHiKI5i
	v1OxYOXSmZTlD7G+/RP5q8vs2zYvHnxJhy5/jmc5N5fOKqpqV838CrCFFBH51gvSuTTUAy
	TFVx/0KrlYlIYn6dXVuhxE27zPdj+vs=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-RCknSYe_POafvZuA1JUMkA-1; Sun, 14 Jul 2024 22:35:05 -0400
X-MC-Unique: RCknSYe_POafvZuA1JUMkA-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5c68745de0dso3060769eaf.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 19:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721010902; x=1721615702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55lW7NJ8ejky4hgV7bfotKSxsKudqxlk6ZTrH104m/o=;
        b=GF8rrwe9j8P0VS2svLkhozsg3X9Z3Gj7lh6hsjiceThDmOz3bVMrRrUzi/eJk1q7OG
         gvXr5fKjA6TjRhK1SLNi6pPyVnfFy+23RSVhbxAlpr8hfbAFbn3WDlEkF+Am3o96AY5b
         qO4sjktlLhUTMVcUseXwjkL4Nvnm6N7DT32ZcrjszSnGdYWxqNZdCOzZbzyupjd5sSo+
         pqLC7fewYBuVllEBDk+f2LpDsGZYhthxZUvliN7VqCA8d+UmMfop6JocVjQDviQ//byh
         ACEGWB+85/gNX+GJbCeYnUYBuGFv1FDkh30oHFi8he4OmtGSZphhvhiNzTesSTrThM6X
         GAWg==
X-Forwarded-Encrypted: i=1; AJvYcCVM2IjKEtqCRZWPTzw4SEgsfBU8w9Vvo7xZoOraAYm5i/1037K07wA5WyxlCONgt2JocB9VC0ePR7WYbg4Ca509QjRh7sEUjMy96GZR
X-Gm-Message-State: AOJu0YyTiImYboKhz7GgWTtrujKl7TQheUzOHrVEd58KdzizjdyLZchP
	yIp4A8Wrc2tTrctLkQ4mDUcvSl4xbeZfyh3ga/ntSORskl0/8Tg8ZLoHIfBK6bYRTgcGtBc5WHZ
	ubW+9U5SiIomm32DISV5iJ4hWr3SmtTEDFHgrfjERXEUptF7wxnHxtNdRrfvJZWav0kfCGvCD9R
	eI/ixjlJ7NUZk/C0Ttr7MRysTXEPBz602bfVD7D4QPbX/j
X-Received: by 2002:a05:6358:c3a2:b0:1aa:a47a:e377 with SMTP id e5c5f4694b2df-1aade12371emr1339237655d.26.1721010902409;
        Sun, 14 Jul 2024 19:35:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG96a3p14oLy4GL8DbB6MuIRFczhmVFQ6RSraL00N0CU6BYVS+mlAiqGbLqvzwybXhZhjedSoJCg6BC+9j2eT4=
X-Received: by 2002:a05:6358:c3a2:b0:1aa:a47a:e377 with SMTP id
 e5c5f4694b2df-1aade12371emr1339236155d.26.1721010901998; Sun, 14 Jul 2024
 19:35:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com> <1720790333-456232-6-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1720790333-456232-6-git-send-email-steven.sistare@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jul 2024 10:34:51 +0800
Message-ID: <CACGkMEurG88fXiThyainxbuzpgBUzzGkmvyQB5vuXsU7_6XBBw@mail.gmail.com>
Subject: Re: [PATCH V2 5/7] vhost-vdpa: VHOST_IOTLB_REMAP
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 9:19=E2=80=AFPM Steve Sistare <steven.sistare@oracl=
e.com> wrote:
>
> When device ownership is passed to a new process via VHOST_NEW_OWNER,
> some devices need to know the new userland addresses of the dma mappings.
> Define the new iotlb message type VHOST_IOTLB_REMAP to update the uaddr
> of a mapping.  The new uaddr must address the same memory object as
> originally mapped.
>
> The user must suspend the device before the old address is invalidated,
> and cannot resume it until after VHOST_IOTLB_REMAP is called, but this
> requirement is not enforced by the API.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/vhost/vdpa.c             | 58 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/vhost_types.h | 11 +++++-
>  2 files changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 4396fe1a90c4..51f71c45c4a9 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1257,6 +1257,61 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>
>  }
>
> +static int vhost_vdpa_process_iotlb_remap(struct vhost_vdpa *v,
> +                                         struct vhost_iotlb *iotlb,
> +                                         struct vhost_iotlb_msg *msg)
> +{
> +       struct vdpa_device *vdpa =3D v->vdpa;
> +       const struct vdpa_config_ops *ops =3D vdpa->config;
> +       u32 asid =3D iotlb_to_asid(iotlb);
> +       u64 start =3D msg->iova;
> +       u64 last =3D start + msg->size - 1;
> +       struct vhost_iotlb_map *map;
> +       int r =3D 0;
> +
> +       if (msg->perm || !msg->size)
> +               return -EINVAL;
> +
> +       map =3D vhost_iotlb_itree_first(iotlb, start, last);
> +       if (!map)
> +               return -ENOENT;
> +
> +       if (map->start !=3D start || map->last !=3D last)
> +               return -EINVAL;

I had a question here, if a buggy user space that:

1) forget to update some of the mappings
2) address is wrong
3) other cases.

Does this mean the device can DMA to the previous owner? If yes, does
this have security implications?

> +
> +       /*
> +        * The current implementation does not support the platform iommu
> +        * with use_va.  And if !use_va, remap is not necessary.
> +        */
> +       if (!ops->set_map && !ops->dma_map)
> +               return -EINVAL;
> +
> +       /*
> +        * The current implementation supports set_map but not dma_map.
> +        */
> +       if (!ops->set_map)
> +               return -EINVAL;
> +
> +       /*
> +        * Do not verify that the new size@uaddr points to the same physi=
cal
> +        * pages as the old size@uaddr, because that would take time O(np=
ages),
> +        * and would increase guest down time during live update.  If the=
 app
> +        * is buggy and they differ, then the app may corrupt its own mem=
ory,
> +        * but no one else's.
> +        */
> +
> +       /*
> +        * Batch will finish later in BATCH_END by calling set_map for th=
e new
> +        * addresses collected here.  Non-batch must do it now.
> +        */
> +       if (!v->in_batch)
> +               r =3D ops->set_map(vdpa, asid, iotlb);
> +       if (!r)
> +               map->addr =3D msg->uaddr;
> +
> +       return r;
> +}
> +
>  static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>                                            struct vhost_iotlb *iotlb,
>                                            struct vhost_iotlb_msg *msg)
> @@ -1336,6 +1391,9 @@ static int vhost_vdpa_process_iotlb_msg(struct vhos=
t_dev *dev, u32 asid,
>                         ops->set_map(vdpa, asid, iotlb);
>                 v->in_batch =3D false;
>                 break;
> +       case VHOST_IOTLB_REMAP:
> +               r =3D vhost_vdpa_process_iotlb_remap(v, iotlb, msg);
> +               break;
>         default:
>                 r =3D -EINVAL;
>                 break;
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_=
types.h
> index 9177843951e9..35908315ff55 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -79,7 +79,7 @@ struct vhost_iotlb_msg {
>  /*
>   * VHOST_IOTLB_BATCH_BEGIN and VHOST_IOTLB_BATCH_END allow modifying
>   * multiple mappings in one go: beginning with
> - * VHOST_IOTLB_BATCH_BEGIN, followed by any number of
> + * VHOST_IOTLB_BATCH_BEGIN, followed by any number of VHOST_IOTLB_REMAP =
or
>   * VHOST_IOTLB_UPDATE messages, and ending with VHOST_IOTLB_BATCH_END.
>   * When one of these two values is used as the message type, the rest
>   * of the fields in the message are ignored. There's no guarantee that
> @@ -87,6 +87,15 @@ struct vhost_iotlb_msg {
>   */
>  #define VHOST_IOTLB_BATCH_BEGIN    5
>  #define VHOST_IOTLB_BATCH_END      6
> +
> +/*
> + * VHOST_IOTLB_REMAP registers a new uaddr for the existing mapping at i=
ova.
> + * The new uaddr must address the same memory object as originally mappe=
d.
> + * Failure to do so will result in user memory corruption and/or device
> + * misbehavior.  iova and size must match the arguments used to create t=
he
> + * an existing mapping.  Protection is not changed, and perm must be 0.
> + */
> +#define VHOST_IOTLB_REMAP          7
>         __u8 type;
>  };

Thanks

>
> --
> 2.39.3
>


