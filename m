Return-Path: <linux-kernel+bounces-243941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52514929CC2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE751F21B33
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFA51CA96;
	Mon,  8 Jul 2024 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7S/rDm2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A17A1B974
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720422386; cv=none; b=Hqxl5wGFZM4NzfS1oI0YWvbhfhgBkB0+zl5xMUaiKaY/xvazkG1vrbOVJXp+9S7kKSXmt8rAlflnUAVhA5WnoceGDT9FBdmzPW64BOwFEcrIHXl3IvBSGCPR4l/225qNLhlVHmZr4EkUbKsz9i/Pik4Y9G+fkVIlvJ1+E6anaFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720422386; c=relaxed/simple;
	bh=THNdkBV6zSeKbGJ+rU746rP1p4hHLxTftUqiTNAVfmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b9CIRsrLEohtUX9U3jNvhv+zm1YM13obS3ZFHedh9mrx1U14apDboESf7HHMRoHn+wjcw0WOd42hJxrufNvRBO2SoIN6fkz5AyVJJt6mPqbP2/aAlz+tu9RcKojXgAEW3PUi0fKw6CzxYdh9OE+tpXZL7avUKcKQ6ebkR5ElTY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7S/rDm2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720422384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zyIJppIdQ0nDVMjomTHHFokVZU/AX+NHjK5GMHRTEbg=;
	b=L7S/rDm2NgAR1NfbmT7U43uZY0fbW3RAunbNNyMheVDAnWhhsGLsQgPe+8KMG4XdzZChim
	KFyWmC6xCucOHJI+Kwfu9yLgJ8kbd8U+po9en/2GGi5oJGNoALS6YFna834kDfcNvj5HH2
	YxnUTLprfLMVe39DnxJ7TffUfKcasGs=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-x4sXc2vkPlWh5yTGLY5h1A-1; Mon, 08 Jul 2024 03:06:22 -0400
X-MC-Unique: x4sXc2vkPlWh5yTGLY5h1A-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-81032cef053so1201869241.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 00:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720422382; x=1721027182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyIJppIdQ0nDVMjomTHHFokVZU/AX+NHjK5GMHRTEbg=;
        b=skmGOFgqe0KBaMX0UJVBw9wuKjSGMCN5Jf0Vof6mCNN881SGy/5kJMT2Ytyxh0/Tbo
         XILhcq+VoJehYtWCtTbK9McgCe7sb8OQdOO00siBoM69+7yWTgONjtaadOYcITOpPcE7
         2VPKESEDHsXCHaVsbLLu57v/w0FTbysSPSCl9LJ3Hxz8Caqj4YhwxtUfD35CQF7at9C+
         P0tH2+6rgG+aaBuL7lqxUFMUt7ZllaowprFRnVZUKrKFZL2eJcGV+fIn+7U8gWcB2Wa2
         a8sDV2GzVcwfaBMsdc5qdoaBuT5FnjIJ/PGrp+sgsG0OqaKpVx3DnTpeGG//wRSKTBLR
         09sA==
X-Forwarded-Encrypted: i=1; AJvYcCXUCQ1DWC/lxOAr/HbuL2xA51xYC128ebq6mq6NA3Eij5amtj/aBKMNNlWVDKJ/TB3D52eXZEri957VUJ+7RyBOeIirjoO2pyOxh7l/
X-Gm-Message-State: AOJu0YwTqQQUzumNT+NVHDOAd1B0UJcJO/wbxWc2Z+jMjAxeTXdE/8N7
	BmxUoDZfjRnfSmpR6g6BF/clKHV8aY5MW7cwnUVCvM5tBe6I/zLS1xXQDYWLFFtd+sgutkfaLiS
	ZN2CtvJcRlaOkJKd6VLY8Hx2Ywm9nLImoUqN97IqA7Kon1fd81r/dOEAJbGQqBdZpNZxu56Lb9Z
	7CoeMnfy1c34rVpNlpWAKxesDPxXdTBy4aXTzE
X-Received: by 2002:a67:fc49:0:b0:48f:95c4:d534 with SMTP id ada2fe7eead31-48fee85607dmr10714729137.3.1720422381815;
        Mon, 08 Jul 2024 00:06:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO1uc/RoshDkfTco0M6SeXuaFTZdF5eVYjCvZPJyHOCO2f2BCvZGt1Bk00xuZa9uB5eVL5bqHsQrA5BAFqNEk=
X-Received: by 2002:a67:fc49:0:b0:48f:95c4:d534 with SMTP id
 ada2fe7eead31-48fee85607dmr10714708137.3.1720422381475; Mon, 08 Jul 2024
 00:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708064820.88955-1-lulu@redhat.com> <20240708064820.88955-3-lulu@redhat.com>
In-Reply-To: <20240708064820.88955-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 15:06:05 +0800
Message-ID: <CACGkMEum7Ufgkez9p4-o9tfYBqfvPUA+BPrxZD8gF7PmWVhE2g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vdpa_sim_net: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 2:48=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the function to support setting the MAC address.
> For vdpa_sim_net, the driver will write the MAC address
> to the config space, and other devices can implement
> their own functions to support this.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim_net.c
> index cfe962911804..a472c3c43bfd 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -414,6 +414,22 @@ static void vdpasim_net_get_config(struct vdpasim *v=
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
> +
> +       struct virtio_net_config *vio_config =3D vdpasim->config;
> +       if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> +               if (!is_zero_ether_addr(config->net.mac)) {
> +                       memcpy(vio_config->mac, config->net.mac, ETH_ALEN=
);
> +                       return 0;
> +               }
> +       }
> +       return -EINVAL;

I think in the previous version, we agreed to have a lock to
synchronize the writing here?

Thanks

> +}
> +
>  static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
>                                      const struct vdpa_dev_set_config *co=
nfig)
>  {
> @@ -510,7 +526,8 @@ static void vdpasim_net_dev_del(struct vdpa_mgmt_dev =
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


