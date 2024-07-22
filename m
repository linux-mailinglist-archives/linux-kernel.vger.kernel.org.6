Return-Path: <linux-kernel+bounces-258602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C709938A5A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1B41C210AD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095101607B4;
	Mon, 22 Jul 2024 07:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YN//Bj54"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE95D1607A5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721634508; cv=none; b=h4cxi7CvhPzKTOwTNDEb9jvHWUDfaY6mspUxpehqHJcfSY+xkq8qjfjJAbDTykOciAIDunAh1kPD0315qH7lP1xrdMddc3daG/xQoBhEv7txVX0O8gwwkdTyz9/08e6hsHrCDn/EpxAqRQsm3slLidK+DEars3iIEmd547hmLlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721634508; c=relaxed/simple;
	bh=qwelGQSOHsBlu5/R+Td9lnRymixbgCg1HZ+vhkQvB5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHoijlzWKG/0hauq9Bt/68BvhLq/fA9/1GTbsOP1hvGEdKhf1N104HuSKSKpiWzYwUDCFANWspy/obu9g0Pyi13E7vZ0Nqk/rvI6DJZsozhra4JHsVIHYodQsqRQalpHPTx88ByA3Tt6Nw5s/OvZcFGWXp14309gfrx85cK7qzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YN//Bj54; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721634505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I/mcqTp3y3xN2oxPQLtpcs5nTeZV7vOd20nAM2VvMok=;
	b=YN//Bj54p78hUtvO2ttcCWFbQuPzBudyHeJvZ8CtXNlGR2Rc8wkJtD4+ozZ0jAeeKSqGsd
	o27CIuQbmu6z4P9fmUrOJPIVVIiwPeMOHvYsJgjyMZba5SA9mTpqhcDerSruhkNfyMKFX4
	VOQ2BJiTUphulSw1UJg7qfzHvR8mD5g=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-17JfleMnOSCnyaa7dUijVw-1; Mon, 22 Jul 2024 03:48:24 -0400
X-MC-Unique: 17JfleMnOSCnyaa7dUijVw-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-81ff8a9ba5aso1289815241.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 00:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721634499; x=1722239299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/mcqTp3y3xN2oxPQLtpcs5nTeZV7vOd20nAM2VvMok=;
        b=jRDs8G6F3VhJGj3lv1qjVmAG1yOklTTa1wl7W5opkodQXQre1ioVW+N6+p1131IV8w
         ZQmVyDJ2RLkuD/az0ttAYAXR8B/KDfPT5Jc00P7asWr8Mh6z6P7CubQjoJB9/Vgf2mvv
         L43O6+BQdgPPvnafgfhyDdx4mhXriVYK8k3TJ+UsmnUmpqv/sv8oLA5mqqk3WtQs9UGx
         n8YQLqi4KqM8x8KRxFlpHyXgkrQPCicepv0IPU1Y4HPsytV63KgI4iv5H7FlJnzIgxFY
         GbaAwmBo5AHAwGlyORdxC3WZqiLwbjwuusBYQJjUMTbGaVCH49EAI55lLHDJzC8M40i1
         l6Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWs4Fov1V/MNeUtgvE4YsLWaJ1+GzPxRhhPsXws5D9whkqae9MhTGDuECoTaDPGRvNt28uCs63cBlvuFgbyvxbpCvxH/rmTk/XHgWtb
X-Gm-Message-State: AOJu0YwF1pT1EYywI+zHg81WN6PXPjB4br+x6b4l9SVwOlnP8Mao8yvI
	XQdk/HkXyiBtPG96IjuvUt9WgqxUIIybw3bLammtlrIPRQtVq450ePxaWX2WUaO1PdPEKhC3QDs
	5mTFA/IzJT1cqw62wsyh8nWYV6NjlHmYcvVj56ZP2PZf7Q1FF2ad9kug2iLG3krHsJkhaBRF5VU
	khPoUHhHLv61ZaHecShGISVTpdfpdE5FQ44Nt08NsR0q+lJdGoMw==
X-Received: by 2002:a05:6102:5e96:b0:48d:a5ff:2f5f with SMTP id ada2fe7eead31-49283e2b004mr4468188137.12.1721634498691;
        Mon, 22 Jul 2024 00:48:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAp5cOsjJMIxSSgdrU2NI/bo+MBLdUDPozloHXQyx7N7sL3/bEoMgtqLF7ISAqIr6HhTEILPOLPhO3xtGIBgs=
X-Received: by 2002:a05:6102:5e96:b0:48d:a5ff:2f5f with SMTP id
 ada2fe7eead31-49283e2b004mr4468168137.12.1721634498275; Mon, 22 Jul 2024
 00:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722010625.1016854-1-lulu@redhat.com> <20240722010625.1016854-3-lulu@redhat.com>
In-Reply-To: <20240722010625.1016854-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jul 2024 15:48:02 +0800
Message-ID: <CACGkMEtq=2yO=4te+qQxwSzi4G-4E_kdq=tCQq_N94Pk8Ro3Zw@mail.gmail.com>
Subject: Re: [PATH v4 2/3] vdpa_sim_net: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the function to support setting the MAC address.
> For vdpa_sim_net, the driver will write the MAC address
> to the config space, and other devices can implement
> their own functions to support this.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim_net.c
> index cfe962911804..936e33e5021a 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -414,6 +414,25 @@ static void vdpasim_net_get_config(struct vdpasim *v=
dpasim, void *config)
>         net_config->status =3D cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LIN=
K_UP);
>  }
>
> +static int vdpasim_net_set_attr(struct vdpa_mgmt_dev *mdev,
> +                               struct vdpa_device *dev,
> +                               const struct vdpa_dev_set_config *config)
> +{
> +       struct vdpasim *vdpasim =3D container_of(dev, struct vdpasim, vdp=
a);
> +       struct virtio_net_config *vio_config =3D vdpasim->config;
> +
> +       mutex_lock(&vdpasim->mutex);
> +
> +       if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> +               memcpy(vio_config->mac, config->net.mac, ETH_ALEN);
> +               mutex_unlock(&vdpasim->mutex);
> +               return 0;
> +       }
> +
> +       mutex_unlock(&vdpasim->mutex);

Do we need to protect:

        case VIRTIO_NET_CTRL_MAC_ADDR_SET:
read =3D vringh_iov_pull_iotlb(&cvq->vring, &cvq->in_iov,
                                             vio_config->mac, ETH_ALEN);
                if (read =3D=3D ETH_ALEN)
                        status =3D VIRTIO_NET_OK;
                break;

As both are modifying vio_config?

Thanks

> +       return -EINVAL;
> +}
> +
>  static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
>                                      const struct vdpa_dev_set_config *co=
nfig)
>  {
> @@ -510,7 +529,8 @@ static void vdpasim_net_dev_del(struct vdpa_mgmt_dev =
*mdev,
>
>  static const struct vdpa_mgmtdev_ops vdpasim_net_mgmtdev_ops =3D {
>         .dev_add =3D vdpasim_net_dev_add,
> -       .dev_del =3D vdpasim_net_dev_del
> +       .dev_del =3D vdpasim_net_dev_del,
> +       .dev_set_attr =3D vdpasim_net_set_attr
>  };
>
>  static struct virtio_device_id id_table[] =3D {
> --
> 2.45.0
>


