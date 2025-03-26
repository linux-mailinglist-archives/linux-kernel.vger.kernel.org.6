Return-Path: <linux-kernel+bounces-576539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 991B3A710AC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF673AF68E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 06:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67A4190678;
	Wed, 26 Mar 2025 06:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8/sRWYr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BA714B965
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 06:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742971231; cv=none; b=Y5aT8ASMqvMhB8Vygw4NS3f7fFIqoh2qnd9R0MBzxPIdVeMracJ4k6FifcS5glmFSFfGS2cH2yc32i5uuNgm0KupXSGn1dBYw3LBEyrpMfv74bLnne77q7vf2WEOHqnRtWdChc0gunu3XlNI3mpdXeXeYFZHg7l0+c4G5sDr7fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742971231; c=relaxed/simple;
	bh=6q09F5c4pHQQSvnekcl2wDEjLn2OddB7yXpI33oM3j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOvfkORHwZ+riY2iMnVoRtMdNwtOUUVY0PFE6iI9Qxk9AZcHUhM56bvcx/yVXxpTCWnpNaSq/uSisTUtDcr3fafyV/RbpwGW80uG+hm6BlVqWVDQBS/SbBMrl92uRrxI+lwxTsOanG9yOMTjE38lLvASExt9K2KTe0T3vKolCZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N8/sRWYr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742971227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezHVFsZe1v4BDvN1xzAQ5TFbS1moNinE5s1cTaUBmso=;
	b=N8/sRWYr6GVuxCoHLJYJIe2mI3wWQwFMO4fv2Sgpl+19R7ni8BkRRjYRvC9mE67Vl9wABl
	3efV8602h6q8r2OK0n9UsFrNXM4rel/KaaMKemhtk45aXDTExrJnAB3FkqwETXq2xAPlUF
	7o1HzTLnKKziJtePE2qkT1Nklkf31bk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-oeUoUYbLPPSmYuAlgLskSw-1; Wed, 26 Mar 2025 02:40:26 -0400
X-MC-Unique: oeUoUYbLPPSmYuAlgLskSw-1
X-Mimecast-MFC-AGG-ID: oeUoUYbLPPSmYuAlgLskSw_1742971225
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff6af1e264so18402663a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 23:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742971224; x=1743576024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezHVFsZe1v4BDvN1xzAQ5TFbS1moNinE5s1cTaUBmso=;
        b=pyFTa6Ux9fr7FddO9WiFrPYGwPelVagvHu/Aw98/jSu/Ov7PBjA1UwEChgaHthGYHA
         L9H4DGrUFadr2AfRZeXpPdKzcXsiOqVmJP4uCge6+Oc68muVo15+oHd2/s4upyORy8xz
         GzXCos0T5diFRiuSY6V27I7okMDAS2FFMSdPS+yjXLX02fCRv4G0bhHm9NogqUYDFc4k
         IzVX6UtiAcZrYuzNU3gyLfwPaLgLTedYGOBB0zbuXwZ5UarUuCBm7W+NPnYVXps7Kek2
         XGn45v116MeYmE+Lya3BX9VpAIkYUrU+ZDXwU/wKLQP3FtA31E7MkKFiyIEjrEK4qZf8
         kmoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU1AlYrXuZRU3+ET7fTwlcqz/CU5QuIhKTl1RY9/OqxqBRx68R6uKoldI5EVTv2V0o88ReHjF9lujBhk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK1Hzj9bC8ZCsPSGD/XegbDFA6BRboCdg1nxYA5qC5WePc0oBv
	N6QeIuJLsc7aL4eLoiYLjw64E4T/mLzZh1+x2aTOhiywd87MKmEdfsUPUUsRlt+y0ti7PzsDUIR
	CU74JmYNNQmKOjnz21U0PhnOT6V73CdLWOjEjlr70u3zb8SKQHACjrMNWCruDO3JvplCPzCODAP
	DDvyFc/d6xCLg3tGnnQGOjM6n8+xcZ+yiU+olWOIvWstMb
X-Gm-Gg: ASbGncvFVyRAy5tS77YPuFIS3lkOZYgI3L7IQS1evojNkDmKW62v14ohrJYQcYwS9Pf
	T93NapuTK9msETnjjGIwDbcFkZAiekr615DvJwNtAjftDjkYStDwWkd+3NnG8jUXaXUR5URM=
X-Received: by 2002:a17:90b:1d51:b0:2ff:62f3:5b31 with SMTP id 98e67ed59e1d1-3030ff06711mr31920768a91.29.1742971224331;
        Tue, 25 Mar 2025 23:40:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFUGcW4JXSeMZI46/HJNxiBTQIzR50w5i1JUFe2fdLyrEXV1sMUCl3RQeMRWq9Y5cXb5aVu+LPH0QeOT9MfrA=
X-Received: by 2002:a17:90b:1d51:b0:2ff:62f3:5b31 with SMTP id
 98e67ed59e1d1-3030ff06711mr31920735a91.29.1742971223830; Tue, 25 Mar 2025
 23:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <CAPpAL=x4BWNh__YpzkzpErkseh04FT7WNLmg=xMXtfZ0S9BabQ@mail.gmail.com>
In-Reply-To: <CAPpAL=x4BWNh__YpzkzpErkseh04FT7WNLmg=xMXtfZ0S9BabQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 07:39:47 +0100
X-Gm-Features: AQ5f1JqS06N3aPblaGlfScL2r-BwUXS_ZG-zwaqN3wVN6CTRzZJOuSitX0ZLN4Q
Message-ID: <CAJaqyWdtKEYiY2tBB0F477LqxVs8fzaix96551WSMa=KdT3C5Q@mail.gmail.com>
Subject: Re: [PATCH 00/19] virtio_ring in order support
To: Lei Yang <leiyang@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 3:44=E2=80=AFPM Lei Yang <leiyang@redhat.com> wrote=
:
>
> QE tested this series of patches with virtio-net regression tests,
> everything works fine.
>

Hi Lei,

Is it possible to test this series also with virtio-net-pci,...,in_order=3D=
on?

Thanks!

> Tested-by: Lei Yang <leiyang@redhat.com>
>
> On Mon, Mar 24, 2025 at 1:45=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > Hello all:
> >
> > This sereis tries to implement the VIRTIO_F_IN_ORDER to
> > virtio_ring. This is done by introducing virtqueue ops so we can
> > implement separate helpers for different virtqueue layout/features
> > then the in-order were implmeented on top.
> >
> > Tests shows 5% imporvemnt in RX PPS with KVM guest + testpmd on the
> > host.
> >
> > Please review.
> >
> > Thanks
> >
> > Jason Wang (19):
> >   virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
> >   virtio_ring: switch to use vring_virtqueue in virtqueue_poll variants
> >   virtio_ring: unify logic of virtqueue_poll() and more_used()
> >   virtio_ring: switch to use vring_virtqueue for virtqueue resize
> >     variants
> >   virtio_ring: switch to use vring_virtqueue for virtqueue_kick_prepare
> >     variants
> >   virtio_ring: switch to use vring_virtqueue for virtqueue_add variants
> >   virtio: switch to use vring_virtqueue for virtqueue_add variants
> >   virtio_ring: switch to use vring_virtqueue for enable_cb_prepare
> >     variants
> >   virtio_ring: use vring_virtqueue for enable_cb_delayed variants
> >   virtio_ring: switch to use vring_virtqueue for disable_cb variants
> >   virtio_ring: switch to use vring_virtqueue for detach_unused_buf
> >     variants
> >   virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
> >   virtio_ring: introduce virtqueue ops
> >   virtio_ring: determine descriptor flags at one time
> >   virtio_ring: factor out core logic of buffer detaching
> >   virtio_ring: factor out core logic for updating last_used_idx
> >   virtio_ring: move next_avail_idx to vring_virtqueue
> >   virtio_ring: factor out split indirect detaching logic
> >   virtio_ring: add in order support
> >
> >  drivers/virtio/virtio_ring.c | 856 ++++++++++++++++++++++++++---------
> >  1 file changed, 653 insertions(+), 203 deletions(-)
> >
> > --
> > 2.42.0
> >
> >
>


