Return-Path: <linux-kernel+bounces-185731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7128CB9E3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 05:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2441F2313B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC50674BE0;
	Wed, 22 May 2024 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahoyer2M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB20A6CDCC
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 03:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716349303; cv=none; b=L72VcdgZFCxF0q9OXPN4pAfqsQRowLtcXp4uaG2rNCrAcd1CApXStXnqCqFiKQtGopECHNDZEGYMOX7HbX/iraUFoTcHqSlmKD/Pmx8hsFReGbHxEntYg7KfcmRgWg9ejpXZI1lIb+maNpqRbVSD22YMWGqsajPKzfMXjUphntA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716349303; c=relaxed/simple;
	bh=tDhOr5kYoJBPVbGFQ/5F4YX6f0w+bGwhd66V63gckoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnEq+2kxizyELXsXq/wAyUb3X98+4XNs6kbNstS7eeDECQIQaaGDC1A24V1TdW1Xfa6qVqr969tEX46Zo6tWH32QCVEOC2aMy5rF6JWNrFK+Kvvkur5TcDexb0JubVgu+xccerRDyxhKuGISBfLOo7BhiibbffdNvGBkvBDTIIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ahoyer2M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716349300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1UghrBASr9ke1BFJrNMmDxAz9OCEkeq9HPICdhp1JU=;
	b=ahoyer2MEzajdy86FDrQPbsAWgomzn+mMGxgel3/4ygYo80FK7nyJCV67bxEj+dTCPlh3D
	+SNqIfxunoP73R0wyKQAvgxT17lAzW8FD9PNb7HYN+1CYd+Lh7pEWCANVDTbpz3ZPoT4xq
	RSEMxfGf7s0rXjQKctx+dXKtEx1YjUI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-Z0jpOVkWMhqqqpvur-TpBA-1; Tue, 21 May 2024 23:41:39 -0400
X-MC-Unique: Z0jpOVkWMhqqqpvur-TpBA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2bd72bd5a6aso3168495a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 20:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716349298; x=1716954098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1UghrBASr9ke1BFJrNMmDxAz9OCEkeq9HPICdhp1JU=;
        b=j5cmWR3D4XdVYYYz/vBgq/FdSFIyeVyr6T2TqsxLhvwhgnX0z9O3leDlVsL8HGVkWx
         8OxW1HWd5av4x0b1UjcMJW03KZlG6Vscde72JlLBoDEGyM/j1ZvrmUq2qex5ZeRS4CMW
         +hSxUldaxAOykSTU824TlWXLjod5ab7IcOwbl5zLGxi4INhRaYKZ1RIfA1VyP6mAJFJJ
         2tj9aP4SfNWd8fVbzGYXLKFUt18b8NZljJQROP8m/6YXRbv38UZFu+LgrJ3wGrheYwmQ
         pQi8/Dl5L/frqqGbI+3t7ZDGXLhTLar8TdtrkFGJ2TaoKI1CvNDmWAEK3bYijxBrCdB0
         1maQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQRk+pJiiI/8FLo0DZr7GQW/vbvOeorogaPYTcV5Os9/qS3u0uBGjx/af6SP+1Ce8IkxzDciHYASDYbgyOtbyxllco50rwYUJk9Pqo
X-Gm-Message-State: AOJu0YxS/gOswByrwmwG4/7Ry9iHczuJrtsEF1LKBBnZWlZP0MoLRABH
	DvIHtnOtvH6HDRSZsuHdw8m4qYFedztz+yPEqKToGcCXpR5RPmcEHE1hd+Uustk/a59uLxQPsWV
	tjFKJpvSz/Cg/gUy+Yp1f94WbGnwyRrciKFlNaAe9q3Nkdbhju3XdMZr6yESVrIo9LI394sl89f
	q7KuKjncP6mIA27Yf7HnjvKx35UVRCT+qEFYg2
X-Received: by 2002:a17:90b:1994:b0:2b4:39dc:8639 with SMTP id 98e67ed59e1d1-2bd9f5cc2e8mr895494a91.46.1716349297420;
        Tue, 21 May 2024 20:41:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRbchEQIMvyIRMvxk6QWEiH753Wga+j6LEMLJsBEdaFFXOVWzyqH+OGUN96Vz6pEs1SqT+9zyHuGj3lBxKMa8=
X-Received: by 2002:a17:90b:1994:b0:2b4:39dc:8639 with SMTP id
 98e67ed59e1d1-2bd9f5cc2e8mr895486a91.46.1716349297127; Tue, 21 May 2024
 20:41:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1716218462-84587-1-git-send-email-steven.sistare@oracle.com>
 <1716218462-84587-2-git-send-email-steven.sistare@oracle.com>
 <CACGkMEvhs_-wD4p-i2VCmQnmdNPLsH9FkhkGePB5LxZQf4B30A@mail.gmail.com> <c4b73d50-2896-4bcc-ae61-6d72f9471978@oracle.com>
In-Reply-To: <c4b73d50-2896-4bcc-ae61-6d72f9471978@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 May 2024 11:41:26 +0800
Message-ID: <CACGkMEsgs3YjeeW9Ji5AcVcL4_qs8PAD7+uQ-P3H7MGYRKpEcw@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] vhost-vdpa: flush workers on suspend
To: Steven Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xie Yongji <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 9:39=E2=80=AFPM Steven Sistare
<steven.sistare@oracle.com> wrote:
>
> On 5/20/2024 10:28 PM, Jason Wang wrote:
> > On Mon, May 20, 2024 at 11:21=E2=80=AFPM Steve Sistare
> > <steven.sistare@oracle.com> wrote:
> >>
> >> Flush to guarantee no workers are running when suspend returns.
> >>
> >> Fixes: f345a0143b4d ("vhost-vdpa: uAPI to suspend the device")
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >> ---
> >>   drivers/vhost/vdpa.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >> index ba52d128aeb7..189596caaec9 100644
> >> --- a/drivers/vhost/vdpa.c
> >> +++ b/drivers/vhost/vdpa.c
> >> @@ -594,6 +594,7 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *=
v)
> >>          struct vdpa_device *vdpa =3D v->vdpa;
> >>          const struct vdpa_config_ops *ops =3D vdpa->config;
> >>          int ret;
> >> +       struct vhost_dev *vdev =3D &v->vdev;
> >>
> >>          if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> >>                  return 0;
> >> @@ -601,6 +602,8 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *=
v)
> >>          if (!ops->suspend)
> >>                  return -EOPNOTSUPP;
> >>
> >> +       vhost_dev_flush(vdev);
> >
> > vhost-vDPA doesn't use workers, see:
> >
> >          vhost_dev_init(dev, vqs, nvqs, 0, 0, 0, false,
> >                         vhost_vdpa_process_iotlb_msg);
> >
> > So I wonder if this is a must.
>
> True, but I am adding this to be future proof.  I could instead log a war=
ning
> or an error message if vhost_vdpa_suspend is called and v->vdev.use_worke=
r=3Dtrue,
> but IMO we should just fix it, given that the fix is trivial.

I meant we need to know if it fixes any actual issue or not.

Thanks

>
> - Steve
>
>
>


