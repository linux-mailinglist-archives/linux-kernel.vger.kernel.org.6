Return-Path: <linux-kernel+bounces-244012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AE7929DD9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731241C21C46
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6363B2A2;
	Mon,  8 Jul 2024 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A541Ds1U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529716FB6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425698; cv=none; b=j/vkrK/YO3glNjuroU3FndYXF4BbIm4OOvD8rKiue9Wjr7A2oap9A6gIbgvGICx81nJsSU+vPMOyhjZXK/+35jOsiCJdHg/GnsLAb4zbhZibLwXB/k98U123kig0sBtjJq8emkdFtpS1DhgvrNOAvAZHwhjDRVfCVYsvyTx23ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425698; c=relaxed/simple;
	bh=nlLhLflDa5bMvjhaApP9IsLVRkmOHEF5QWS4D2zNHw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qkpE8zsrcCmD0nYh4zql5zbWS8byiTWt1ePsNKVZjrLhn4Pskdt1ksgTSO8pucVfUjRPGSaxnppMWZ1ANQk1ZSV7QSMU0tl/1b7gbgy6yj9TGi0m0KXSJhVnzyqgurjrK3Kr50YqUewRtvav15V/GO4pSydatc5Zw9tyk3UiemM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A541Ds1U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720425696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=27lMaNCb81p4YFFh+LEEn0k8qDHH12ozaV7hZRSJBCA=;
	b=A541Ds1UNKLuuKJascZpBcI80MUldrG4DCXZb5Yx8tfuXw10eFM9cMhWLcHEW1Zz+shOra
	uPC/9J+NaLfKWAq/Drza7eSdFVDaEGVafNmQDzLOBSlSbV2TkjOPTGyKvPTsioUJOtZty9
	DaRjtBy2g7gRXRIao9Jlf9wmD0LQJTQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-m2uWCiRbPvK08OXI7YCTUg-1; Mon, 08 Jul 2024 04:01:34 -0400
X-MC-Unique: m2uWCiRbPvK08OXI7YCTUg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1fb4e7cc5d5so10704125ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 01:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720425693; x=1721030493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27lMaNCb81p4YFFh+LEEn0k8qDHH12ozaV7hZRSJBCA=;
        b=V4GNDSXsWquKJ7zpOfkIUSn1pcggfGHIHM0dfO5s0/ieUBU9M74C0bJgnm2zaRd5UJ
         3iqlINZIXPwnixQ7YSN2IlJcGhwwRH6fGoa77XeVYxItJ9Iyrf77mOO7y2Cnlh+DnqTp
         2pzYPwaEPHtoUt30FPGHO9fmLNRkl4YmMkBw/QA9YvSCSGmAV97ZO94iWzo6UsWhzO1T
         L/4pYw6K0PP1BhkB/yD/Dme/NhqvRrP8BfkJ6M2IGDrwIOO+S+IChAiTEt1tBIl2v9SG
         xsHioRR9Z9/I2IxxDeofcWjQUcI5DTs24bch8NSZL6a9aK+ON0LlyjJ0+mxc62ciulrE
         kmtA==
X-Forwarded-Encrypted: i=1; AJvYcCX0fBMtQurmA3x5xvU+wnet4IMR5mJgYXxVWqsXD0/yceIPjzCQGZj/4cUF0atzU965L3FECq1xGofLr0zqHd5J7oxVe4xJab0NLhj2
X-Gm-Message-State: AOJu0YympQTNGMjomuxp1PFPSoxGF/FRIqg6b9no8LkWWc0+jis5VXuO
	bZNb1M7XmwPAAt7VcoNzf3PtqyEbx0ByUfIC6DiWXHC+V07qjRMfh5iIF+uV2YsELLY8hVCMvLa
	P6crfPah7Kj1O40KLTJ6Vmb523AuW2OVE6D/d0V1UOamA0YscRtRal0Igoa7Vr1a+FeL1xnWrEw
	lI0Iq5pBFa6oGvyTcuT5FLPvKOgOvqlsOhlXEC
X-Received: by 2002:a17:903:1252:b0:1fb:a1c6:db75 with SMTP id d9443c01a7336-1fba1c6de04mr6881665ad.6.1720425693354;
        Mon, 08 Jul 2024 01:01:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7tEwJUQ3jL/FURLCL1Fmxt7rfHgT6zXgifTSPRjjPgC0FTxqJiDiptLT5gVxmpCf9aR+PWLt24EtwHzQHJqA=
X-Received: by 2002:a17:903:1252:b0:1fb:a1c6:db75 with SMTP id
 d9443c01a7336-1fba1c6de04mr6881415ad.6.1720425692886; Mon, 08 Jul 2024
 01:01:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708064820.88955-1-lulu@redhat.com> <20240708064820.88955-3-lulu@redhat.com>
 <CACGkMEum7Ufgkez9p4-o9tfYBqfvPUA+BPrxZD8gF7PmWVhE2g@mail.gmail.com> <CACLfguXdL_FvdvReQrzvKvzJrHnE9gcTv+rLYsCNB0HtvXC74w@mail.gmail.com>
In-Reply-To: <CACLfguXdL_FvdvReQrzvKvzJrHnE9gcTv+rLYsCNB0HtvXC74w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 16:01:21 +0800
Message-ID: <CACGkMEuOz_fsBnX8BNnbUHMdNo48S8cEUT4M6O0_oBsSKRJmLQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vdpa_sim_net: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 3:19=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Mon, 8 Jul 2024 at 15:06, Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Jul 8, 2024 at 2:48=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote=
:
> > >
> > > Add the function to support setting the MAC address.
> > > For vdpa_sim_net, the driver will write the MAC address
> > > to the config space, and other devices can implement
> > > their own functions to support this.
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 19 ++++++++++++++++++-
> > >  1 file changed, 18 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa=
_sim/vdpa_sim_net.c
> > > index cfe962911804..a472c3c43bfd 100644
> > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > @@ -414,6 +414,22 @@ static void vdpasim_net_get_config(struct vdpasi=
m *vdpasim, void *config)
> > >         net_config->status =3D cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S=
_LINK_UP);
> > >  }
> > >
> > > +static int vdpasim_net_set_attr(struct vdpa_mgmt_dev *mdev,
> > > +                               struct vdpa_device *dev,
> > > +                               const struct vdpa_dev_set_config *con=
fig)
> > > +{
> > > +       struct vdpasim *vdpasim =3D container_of(dev, struct vdpasim,=
 vdpa);
> > > +
> > > +       struct virtio_net_config *vio_config =3D vdpasim->config;
> > > +       if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > > +               if (!is_zero_ether_addr(config->net.mac)) {
> > > +                       memcpy(vio_config->mac, config->net.mac, ETH_=
ALEN);
> > > +                       return 0;
> > > +               }
> > > +       }
> > > +       return -EINVAL;
> >
> > I think in the previous version, we agreed to have a lock to
> > synchronize the writing here?
> >
> > Thanks
> >
> Hi Jason
> I have moved the down_write(&vdev->cf_lock) and
> up_write(&vdev->cf_lock) to the function vdpa_dev_net_device_attr_set
> in vdpa/vdpa.c. Then the device itself doesn't need to call it again.
> Do you think this is ok?

I meant we have another path to modify the mac:

static virtio_net_ctrl_ack vdpasim_handle_ctrl_mac(struct vdpasim *vdpasim,
                                                   u8 cmd)
{
        struct virtio_net_config *vio_config =3D vdpasim->config;
        struct vdpasim_virtqueue *cvq =3D &vdpasim->vqs[2];
        virtio_net_ctrl_ack status =3D VIRTIO_NET_ERR;
        size_t read;

        switch (cmd) {
case VIRTIO_NET_CTRL_MAC_ADDR_SET:
                read =3D vringh_iov_pull_iotlb(&cvq->vring, &cvq->in_iov,
                                             vio_config->mac, ETH_ALEN);
                if (read =3D=3D ETH_ALEN)
            status =3D VIRTIO_NET_OK;
        break;
        default:
                break;
        }

        return status;
}

We need to serialize between them.

Thanks

> Thanks
> Cindy
> > > +}
> > > +
> > >  static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
> > >                                      const struct vdpa_dev_set_config=
 *config)
> > >  {
> > > @@ -510,7 +526,8 @@ static void vdpasim_net_dev_del(struct vdpa_mgmt_=
dev *mdev,
> > >
> > >  static const struct vdpa_mgmtdev_ops vdpasim_net_mgmtdev_ops =3D {
> > >         .dev_add =3D vdpasim_net_dev_add,
> > > -       .dev_del =3D vdpasim_net_dev_del
> > > +       .dev_del =3D vdpasim_net_dev_del,
> > > +       .dev_set_attr =3D vdpasim_net_set_attr
> > >  };
> > >
> > >  static struct virtio_device_id id_table[] =3D {
> > > --
> > > 2.45.0
> > >
> >
>


