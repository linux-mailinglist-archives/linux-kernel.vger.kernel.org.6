Return-Path: <linux-kernel+bounces-243955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C91929CFF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E9C28106D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFC0225AF;
	Mon,  8 Jul 2024 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9MdByrt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6584D224F2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720423155; cv=none; b=ViKt44vwViZUj5awM/ReOtZgYSVHmTVXgCnN54LF54DHxd0Qio5R1r/ZWU8faoe5K4qRq6EuQMTaqtzp7sxkHJVhlS0PQOhjMOUYW2/0319pGEKxpctsY04VAmeXhkFY7F2qoexiAf+j4c0uuul4Hltt64TH4AoXzaDzL9Yzj7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720423155; c=relaxed/simple;
	bh=BCpNb63WRewgJB37gIEoqo5egyIJUDlpbkKJgwO8OHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRJSwlFfWLuJiTIZVt+coOLHbg6kaVHwR05iek2HKwPbY/+0yVmBOPH6Dw8O4s7SIV2a11Fw9y43MjI2quJ+/7b1X2aLNJud4kOmdcMfV3lK7DhO07CGMBs7d8z/0T16yG7ugKabrI2lAtE+DrXhvtizWSg05lSi71erl4pGFUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R9MdByrt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720423152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jqM73JSLXU66f0uRVT9WU+gkf5AyrsxUM3dUDMhxBT4=;
	b=R9MdByrtVbjqdnDxj6k98BnLA/j3PI1gj0PvHWOEPI9bn+2WdO+H7V/eCT/nxvJNGeH9Jc
	upn9CRou1hJUl9Y65BKxsJKi4LMoSNnVzSCMaxQmGXUAshuoecr8ZpwTcYKnU2tnw+S2VD
	6KVBc0SwXB9pXo5jiRJATmbAYWf7JVs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-7g24U4EjOoaNPM3pfon5oA-1; Mon, 08 Jul 2024 03:19:10 -0400
X-MC-Unique: 7g24U4EjOoaNPM3pfon5oA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a77e024eaa4so147362866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 00:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720423148; x=1721027948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqM73JSLXU66f0uRVT9WU+gkf5AyrsxUM3dUDMhxBT4=;
        b=Ne5IfIjnaAfqq5tazVIxhg/c+OR0an2y1nsOuPbsdGmVn5BidlHZiVYFkfZtjYD2xL
         0sOXvYBNsDf2cIZvhVerfnlBmL/lu/q2NCAcJtpUSeYTwMwK0Wt75dqM1remjeMv0co8
         Cjuw3HN50SmFetapjqjjqHe8I+amsqlQGi7IxRhCHNUJOYH3/JvkHjCMAu133qXoCTNj
         vQ+lRdPh4AeJ9eGCbfP1AazIg1FwqrET3iSiJqCA26UJIOIM7SY0OQ2wYZXTbnjamOEV
         u4NJLZ4x12h2GZNdlG4yCWFl6xY0Qu5IReBW/9YtrX+AMT1Vx+AgU9A9dvl1la9VBydp
         bHKA==
X-Forwarded-Encrypted: i=1; AJvYcCUXi8RDwQ3/EbUITTa4pMBpJuYQgED0gHz3yqLJp+jEzgz5zBIgn2V2E1+0UiqO7JaSXlcDVPmkNpEKZEYWu9Maeyw9hSyv8UQ+2cnm
X-Gm-Message-State: AOJu0YxxCcrpLUEtlLmh0zX2h2VfEccW03zelrV/EZyLAIb3MKrAF6af
	dLEootF3sR37xvaASuBOQ9avqisZwXg0M50jillZSJ7WXyUu/frYnN3V/kXsXmRuZBazjEPbd4h
	FhNTyrm8fQBHzn//T/8wGUtFDvmhCzSp1oTaPMnW3viUyIq0QTPTgW164HeDgaHQCcwBthWz34E
	PfVwErzZbD8RPztZUwJyFWE7A3ZKzqifmG6V5VXOoE3pfkcf4=
X-Received: by 2002:a17:906:175b:b0:a77:a630:cf89 with SMTP id a640c23a62f3a-a77b9dee79dmr706515266b.0.1720423148321;
        Mon, 08 Jul 2024 00:19:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGUu1W6MyDpHHXhXDXEq+4hte1tFdv4eIOo7asqiTd/PZmPPhD5t+yUjE3Q9R2KpY/v0HSjx6vJ4Xu91Rb1yY=
X-Received: by 2002:a17:906:175b:b0:a77:a630:cf89 with SMTP id
 a640c23a62f3a-a77b9dee79dmr706512466b.0.1720423147970; Mon, 08 Jul 2024
 00:19:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708064820.88955-1-lulu@redhat.com> <20240708064820.88955-3-lulu@redhat.com>
 <CACGkMEum7Ufgkez9p4-o9tfYBqfvPUA+BPrxZD8gF7PmWVhE2g@mail.gmail.com>
In-Reply-To: <CACGkMEum7Ufgkez9p4-o9tfYBqfvPUA+BPrxZD8gF7PmWVhE2g@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 8 Jul 2024 15:18:31 +0800
Message-ID: <CACLfguXdL_FvdvReQrzvKvzJrHnE9gcTv+rLYsCNB0HtvXC74w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vdpa_sim_net: Add the support of set mac address
To: Jason Wang <jasowang@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jul 2024 at 15:06, Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Jul 8, 2024 at 2:48=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add the function to support setting the MAC address.
> > For vdpa_sim_net, the driver will write the MAC address
> > to the config space, and other devices can implement
> > their own functions to support this.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_s=
im/vdpa_sim_net.c
> > index cfe962911804..a472c3c43bfd 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > @@ -414,6 +414,22 @@ static void vdpasim_net_get_config(struct vdpasim =
*vdpasim, void *config)
> >         net_config->status =3D cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_L=
INK_UP);
> >  }
> >
> > +static int vdpasim_net_set_attr(struct vdpa_mgmt_dev *mdev,
> > +                               struct vdpa_device *dev,
> > +                               const struct vdpa_dev_set_config *confi=
g)
> > +{
> > +       struct vdpasim *vdpasim =3D container_of(dev, struct vdpasim, v=
dpa);
> > +
> > +       struct virtio_net_config *vio_config =3D vdpasim->config;
> > +       if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +               if (!is_zero_ether_addr(config->net.mac)) {
> > +                       memcpy(vio_config->mac, config->net.mac, ETH_AL=
EN);
> > +                       return 0;
> > +               }
> > +       }
> > +       return -EINVAL;
>
> I think in the previous version, we agreed to have a lock to
> synchronize the writing here?
>
> Thanks
>
Hi Jason
I have moved the down_write(&vdev->cf_lock) and
up_write(&vdev->cf_lock) to the function vdpa_dev_net_device_attr_set
in vdpa/vdpa.c. Then the device itself doesn't need to call it again.
Do you think this is ok?
Thanks
Cindy
> > +}
> > +
> >  static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
> >                                      const struct vdpa_dev_set_config *=
config)
> >  {
> > @@ -510,7 +526,8 @@ static void vdpasim_net_dev_del(struct vdpa_mgmt_de=
v *mdev,
> >
> >  static const struct vdpa_mgmtdev_ops vdpasim_net_mgmtdev_ops =3D {
> >         .dev_add =3D vdpasim_net_dev_add,
> > -       .dev_del =3D vdpasim_net_dev_del
> > +       .dev_del =3D vdpasim_net_dev_del,
> > +       .dev_set_attr =3D vdpasim_net_set_attr
> >  };
> >
> >  static struct virtio_device_id id_table[] =3D {
> > --
> > 2.45.0
> >
>


