Return-Path: <linux-kernel+bounces-306192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BA5963AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E53D1C23DAD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA79816B754;
	Thu, 29 Aug 2024 06:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ktl5uYVH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B50215C142
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724911700; cv=none; b=f1QTQqm9IjS3AfcChQLn2KihFn2Qd1YnT09eemuasYYD1ymN3D9LbF1XOJkZ8Eesco92+KG7vhXEUxi8Dfn82+DfyFacntQbaUQYi3kF9VFBrB/TzCh2zyK24oCczIzCBXCwDqToa0fYjQDVdR3EgHlDKzq/D7sNoDfVEqABl1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724911700; c=relaxed/simple;
	bh=ga+jYeH1TU6uNqm5JY3Rm7iQDELtJjgqOfvTKzzVqXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQIEy9T48eX8WTbPSDi66H86+d1pqERRipadV7I83qcvSyW0FcDlG2guCrr8ZuC+cQTmNv2CdJg8bEVTxQtsGIFdO/Jq20J9d5AxhShwh/xR8mqwAHTwtFyAw8mE9UoR+MsIdhRU3l4HRWt58mYJM66XymfKQkLZ9ZpzVOl0QYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ktl5uYVH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724911697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XF95Iuxjl7jZwsQ+wprRFd/8JK8pjee56X/zTcOwmHQ=;
	b=Ktl5uYVH23UyjpZUK9gbIoXTFTPitK+IkgUD3PncEGuXTJKcGmQXFTGMWeG+yzJmOsCwEy
	suFCtfVOO8CKYqUWtf+J7W0NCzbvURDi4ZfphYmiCYEgVNo8ae+lz5CjY8j2q6T42nP2pV
	vecy0eMn/0ltPjtRBqFh49Bt982m1wM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-KhYdan2wOxmDZGYTbJ0nDA-1; Thu, 29 Aug 2024 02:08:13 -0400
X-MC-Unique: KhYdan2wOxmDZGYTbJ0nDA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5bee75ca694so212186a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 23:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724911691; x=1725516491;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XF95Iuxjl7jZwsQ+wprRFd/8JK8pjee56X/zTcOwmHQ=;
        b=BazLZz65pFF7B+iYI0kccpzcK/bUta/5FYpjSt9C7/1etbqa8WpwWxmcFqS1qiFksf
         Pk+6fMhbETnXFbXdY5oYjrW6vOqGUaez8DsiiSBp0CsOuf25V9viegL1aBx7nEE5XMIu
         Pj26GeWFDdQ+waxrNd/f0SxcLuWI/0vPkspw4fwNc5gcNlqgyNVTKr5uKu72oUfzLngw
         BwTwId/KLxB2DRXy5AuDh+v2yh6yBCBpAih2DXKLPRhafP6V4G1CUAyB8sPpVnm+DuwB
         VpKPjc0n371nIYqgskr0JtR/Fgp1zPf+iA5Z1AgUBKsVgO2LnlKgIcnVr8icRp/6WWoD
         KtXw==
X-Forwarded-Encrypted: i=1; AJvYcCVOmrtR2+WOxIqwysJhL8fFhp+Y/vjkrtgzhOFXSFZEkyW7Kef13OIEvyX6u8tWWFuInVNRxj8AvuCAt+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIeFGY97iH8SQnuFXQDBt6CRoQKaEKTvOZoXY6W4MkEo91G32Q
	js33RpoyQRyIrIxtptlxl1rbpREvNYQHq9BNJAR3eRpKPkmVHxk33v7fU3ly/kjCeFXT2MiAIp8
	t3ZO/vSiucKhAYUxk08LD+q7jyyVn6KCgYm+N4Y5vX/3JcvSEyUuIQO8FDyz9iQ==
X-Received: by 2002:a05:6402:5214:b0:5c0:c061:1ca1 with SMTP id 4fb4d7f45d1cf-5c21ed96c98mr1441312a12.23.1724911690744;
        Wed, 28 Aug 2024 23:08:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECQPpZhHJB3j7Rn9Va2KKM/cbroeKIYc6cgbC2BR3FpqVVTtWx6hi0AaPMJLfN4p9+jBOZdA==
X-Received: by 2002:a05:6402:5214:b0:5c0:c061:1ca1 with SMTP id 4fb4d7f45d1cf-5c21ed96c98mr1441239a12.23.1724911689645;
        Wed, 28 Aug 2024 23:08:09 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ed:a269:8195:851e:f4b1:ff5d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226ccfe8fsm276741a12.62.2024.08.28.23.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 23:08:09 -0700 (PDT)
Date: Thu, 29 Aug 2024 02:08:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, dtatulea@nvidia.com,
	bilbao@vt.edu, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	cratiu@nvidia.com, lingshan.zhu@intel.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Carlos Bilbao <cbilbao@digitalocean.com>
Subject: Re: [PATCH] vdpa: Set speed and duplex of mlx5_vnet to UNKNOWN
Message-ID: <20240829020710-mutt-send-email-mst@kernel.org>
References: <20240828181625.7831-1-carlos.bilbao.osdev@gmail.com>
 <CACGkMEs2wDLBq3_5KDOHou3g8Cxhm9Dx8eXy7JnX0R8ZYqinZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEs2wDLBq3_5KDOHou3g8Cxhm9Dx8eXy7JnX0R8ZYqinZA@mail.gmail.com>

On Thu, Aug 29, 2024 at 12:49:24PM +0800, Jason Wang wrote:
> On Thu, Aug 29, 2024 at 2:16 AM Carlos Bilbao
> <carlos.bilbao.osdev@gmail.com> wrote:
> >
> > From: Carlos Bilbao <cbilbao@digitalocean.com>
> >
> > mlx5_vdpa vDPA devices currently don't support reporting or setting the
> > speed and duplex and hence should be UNKNOWN instead of zero.
> >
> > Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c |  7 +++++++
> >  drivers/vdpa/vdpa.c               | 23 +++++++++++++++++++++++
> >  include/uapi/linux/vdpa.h         |  2 ++
> >  3 files changed, 32 insertions(+)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index fa78e8288ebb..319f5c6121de 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -3795,6 +3795,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> >         init_rwsem(&ndev->reslock);
> >         config = &ndev->config;
> >
> > +       /*
> > +        * mlx5_vdpa vDPA devices currently don't support reporting or
> > +        * setting the speed or duplex.
> > +        */
> > +       config->speed  = SPEED_UNKNOWN;
> > +       config->duplex = DUPLEX_UNKNOWN;
> > +
> >         if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
> >                 err = config_func_mtu(mdev, add_config->net.mtu);
> >                 if (err)
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index 4dbd2e55a288..abde23e0041d 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -15,6 +15,7 @@
> >  #include <net/genetlink.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/virtio_ids.h>
> > +#include <uapi/linux/ethtool.h>
> >
> >  static LIST_HEAD(mdev_head);
> >  /* A global mutex that protects vdpa management device and device level operations. */
> > @@ -919,6 +920,22 @@ static int vdpa_dev_net_status_config_fill(struct sk_buff *msg, u64 features,
> >         return nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16);
> >  }
> >
> > +static int vdpa_dev_net_speed_config_fill(struct sk_buff *msg, u64 features,
> > +                                       struct virtio_net_config *config)
> > +{
> > +       __le32 speed = cpu_to_le32(SPEED_UNKNOWN);
> > +
> > +       return nla_put(msg, VDPA_ATTR_DEV_NET_CFG_SPEED, sizeof(speed), &speed);
> > +}
> > +
> > +static int vdpa_dev_net_duplex_config_fill(struct sk_buff *msg, u64 features,
> > +                                       struct virtio_net_config *config)
> > +{
> > +       u8 duplex = DUPLEX_UNKNOWN;
> > +
> > +       return nla_put(msg, VDPA_ATTR_DEV_NET_CFG_DUPLEX, sizeof(duplex), &duplex);
> > +}
> > +
> >  static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *msg)
> >  {
> >         struct virtio_net_config config = {};
> > @@ -941,6 +958,12 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> >         if (vdpa_dev_net_status_config_fill(msg, features_device, &config))
> >                 return -EMSGSIZE;
> >
> > +       if (vdpa_dev_net_speed_config_fill(msg, features_device, &config))
> > +               return -EMSGSIZE;
> > +
> > +       if (vdpa_dev_net_duplex_config_fill(msg, features_device, &config))
> > +               return -EMSGSIZE;
> > +
> >         return vdpa_dev_net_mq_config_fill(msg, features_device, &config);
> >  }
> >
> > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > index 842bf1201ac4..1c64ee0dd7b1 100644
> > --- a/include/uapi/linux/vdpa.h
> > +++ b/include/uapi/linux/vdpa.h
> > @@ -43,6 +43,8 @@ enum vdpa_attr {
> >         VDPA_ATTR_DEV_NET_STATUS,               /* u8 */
> >         VDPA_ATTR_DEV_NET_CFG_MAX_VQP,          /* u16 */
> >         VDPA_ATTR_DEV_NET_CFG_MTU,              /* u16 */
> > +       VDPA_ATTR_DEV_NET_CFG_SPEED,            /* u32 */
> > +       VDPA_ATTR_DEV_NET_CFG_DUPLEX,           /* u8 */
> 
> This should be an independent patch as it allows vdpa tool to
> provision speed and duplex.

or same patch, but document this more clearly:
when subj starts with mlx5 I expect it only affects mlx5.



> But a fundamental question is if we need such provisioning?

why not?

> Thanks
> 
> >
> >         VDPA_ATTR_DEV_NEGOTIATED_FEATURES,      /* u64 */
> >         VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,          /* u32 */
> > --
> > 2.34.1
> >


