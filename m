Return-Path: <linux-kernel+bounces-557118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8FDA5D3E1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF42817A85E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00873137C37;
	Wed, 12 Mar 2025 01:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bBSHUltn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E18912BF24
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 01:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741741952; cv=none; b=QGFqetSdhJdhafpI/eafoI31h+5Pgy8WJ22ZG6TUusYYPKm3Lys1c/sZvHRrfB2ujT862qB08RsSaiWIhqiYtJ9NHiTX7G4+hrfFPEcHEVL0d9UPy8y8RCjYXz9U/MoEFXiRzoTVg7+XsY19hzV+k4xqySNaldwHsxLiv6YhHpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741741952; c=relaxed/simple;
	bh=b8YvkgQKYVv+zLA/vOzQnYgkvVS/E8Xw0N70YVJ357g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ps+kgEQl/iG//5+2IIaA7fH3xn8HwkpMv+a8CJVzZEThsI1j/T7uhBLU553QDneIl6+iOftizan8yoJEEOesOJULnAPsdwxn1nDPLxBBcsGxlOVCQaY5ttgTqQq+FXIEeaj2ly246HLX00ksb8BtHO6FuS6sbrAaHqGQtXIxoUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bBSHUltn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741741949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CnGRCv9ZSKqoVhTk7F0JHtO98tD/stwqbpbExfdFqNU=;
	b=bBSHUltnV6SWixo5SnnitPvWWkgWw+hobZNQfr0eN7pFzLI4HddYs80JrxwkAqoW5Yo0iq
	/oMRzcwJXy7UveutBuBjNCxon41Tn5sRhWHfFKE+yCB1R77+obdj67O6N+X/lK6wu/nxXv
	6pRmOIXsV72OoPRrsVLwKWadqwyqnfA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-w4K6TLgSPTm9Wazrvkk6Jg-1; Tue, 11 Mar 2025 21:12:27 -0400
X-MC-Unique: w4K6TLgSPTm9Wazrvkk6Jg-1
X-Mimecast-MFC-AGG-ID: w4K6TLgSPTm9Wazrvkk6Jg_1741741947
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3f6ff6a9fe9so246641b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741741944; x=1742346744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnGRCv9ZSKqoVhTk7F0JHtO98tD/stwqbpbExfdFqNU=;
        b=iDHBeAPMCA1NCXXU2hSwe3KXZmmV+XDu8rMIri1xdfiLG5YA1qiBcAif4Rvt7Ompj7
         VY7x7kVc1OhvO5AFURBfno52A72aiJVSCwvaSwmJ+Jx1usv7EoYUGY19rOxKmBpqLYg6
         b7u9CwQk5h3FFPTCO23sxWaIJuN5OF8pEyS2cXAcwx8nSNGUFU76JwCGWTISROUO1eM5
         hekvY/sLDbOVfVLCTN5NDnwZxG+P2o6T4ziVgl4oH5EAhA5kg6TmLrEbeW8YM0BWDF7P
         tLcHonyNfBgtYAk6xDU6cchsT31OXdYDlJUqe+af66drdsPGLCIBAqe2p7F6Ms7ZITzb
         OH/A==
X-Forwarded-Encrypted: i=1; AJvYcCVXCW++dMYr0cU0cRuWDBYy4pUAQIqpTrR+7SmWQnSRsXKPVBky8Y0FTGCsli24jCmdIefmcZllZwqcgcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA1BjJLVfrmOrGkNnNa1p1Ucf5+X/8E9ObUY92GKIsoY94Sr8J
	1xkfK2Qfo66LD2HcFWZBlxQ08fKRoyui5sELNFeYNapZPELVTRb2pbwWPbAOO4jJo6qYF3LvVuL
	d8b3O3omWguw7PF68SXqKlfN0N22Lu2TEl21y2DwC+3mR9fwYQE5Kte3SgajQkjcSjLB3ypWhie
	KRVt5RdfgqFBhmkVDoN8dwG6ynCvA3RFaeqpwI6tXumMfdB1Wthw==
X-Gm-Gg: ASbGncuFXyIJmNV76ihmu+957LA1AkESTyMt1UKNd2Recye5Izeb1EZHos7+H2MIQBw
	FVakHbRDpA1MWNmyUXBB65AXQBr0iCaw4sBQy4OdTQ6Ar34NdwP25dmM6b1TS2LhxvpzTuw==
X-Received: by 2002:a05:6808:2286:b0:3f1:ccc5:26b5 with SMTP id 5614622812f47-3fa2b7eda77mr3177977b6e.6.1741741944396;
        Tue, 11 Mar 2025 18:12:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3mKhM/9eEonh3FegBD10LQ8+pNQN7eeRuLw2+1ljK27jMzqq4OXLt3z/dyqYGa0+Ls1Odf3vt/DlfXnV4aKk=
X-Received: by 2002:a67:fe83:0:b0:4bd:379c:4037 with SMTP id
 ada2fe7eead31-4c34de502dcmr3195470137.9.1741741933287; Tue, 11 Mar 2025
 18:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67c7761a.050a0220.15b4b9.0018.GAE@google.com> <20250311131735.3205493-1-quic_zhonhan@quicinc.com>
In-Reply-To: <20250311131735.3205493-1-quic_zhonhan@quicinc.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Mar 2025 09:11:59 +0800
X-Gm-Features: AQ5f1JqQ5BnESGxfl6--tmcJtmtJPjIXrmidjQzfdxxMN_7gILNNc9hyAqgz1Ao
Message-ID: <CACGkMEvK6adr6m-LpWxFxAz+pTPYpnA3gO4sLhs0Gc52nrbYLw@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: Fix data race when accessing the
 event_triggered field of vring_virtqueue
To: Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	syzbot+efe683d57990864b8c8e@syzkaller.appspotmail.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 9:18=E2=80=AFPM Zhongqiu Han <quic_zhonhan@quicinc.=
com> wrote:
>
> Syzkaller reports a data-race when accessing the event_triggered field of
> vring_virtqueue in virtqueue_disable_cb / virtqueue_enable_cb_delayed.
> Here is the simplified stack when the issue occurred:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: data-race in virtqueue_disable_cb / virtqueue_enable_cb_delay=
ed
>
> write to 0xffff8881025bc452 of 1 bytes by task 3288 on cpu 0:
>  virtqueue_enable_cb_delayed+0x42/0x3c0 drivers/virtio/virtio_ring.c:2653
>  start_xmit+0x230/0x1310 drivers/net/virtio_net.c:3264
>  __netdev_start_xmit include/linux/netdevice.h:5151 [inline]
>  netdev_start_xmit include/linux/netdevice.h:5160 [inline]
>  xmit_one net/core/dev.c:3800 [inline]
>  dev_hard_start_xmit+0x119/0x3f0 net/core/dev.c:3816
>  sch_direct_xmit+0x1a9/0x580 net/sched/sch_generic.c:343
>  __dev_xmit_skb net/core/dev.c:4039 [inline]
>  __dev_queue_xmit+0xf6a/0x2090 net/core/dev.c:4615
>
> read to 0xffff8881025bc452 of 1 bytes by interrupt on cpu 1:
>  virtqueue_disable_cb_split drivers/virtio/virtio_ring.c:880 [inline]
>  virtqueue_disable_cb+0x92/0x180 drivers/virtio/virtio_ring.c:2566
>  skb_xmit_done+0x5f/0x140 drivers/net/virtio_net.c:777
>  vring_interrupt+0x161/0x190 drivers/virtio/virtio_ring.c:2715
>  __handle_irq_event_percpu+0x95/0x490 kernel/irq/handle.c:158
>  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
>  handle_irq_event+0x64/0xf0 kernel/irq/handle.c:210
>  handle_edge_irq+0x16d/0x5b0 kernel/irq/chip.c:831
>  generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
>  handle_irq arch/x86/kernel/irq.c:249 [inline]
>
> value changed: 0x01 -> 0x00
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> After an interrupt is triggered, event_triggered can be set to true in th=
e
> func vring_interrupt(). Then virtqueue_disable_cb_split() will read it as
> true and stop further work of disabling cbs. During this time, if another
> virtqueue processing sets same event_triggered to false in func
> virtqueue_enable_cb_delayed(), a race condition will occur, potentially
> leading to further vq data inconsistency because both
> virtqueue_disable_cb_split() and virtqueue_enable_cb_delayed() can
> continue read/write multiple field members of vring_virtqueue.
>
> Fix this by using smp_load_acquire() and smp_store_release().
>
> Additionally, virtqueue_disable_cb_packed() may be called in the same
> stack as virtqueue_disable_cb_split() while vq->packed_ring is true in
> func virtqueue_disable_cb(), so event_triggered should also be protected
> in it.
>
> Reported-by: syzbot+efe683d57990864b8c8e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67c7761a.050a0220.15b4b9.0018.GAE@goo=
gle.com/
> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>

Do we have performance numbers for this change?

Btw event_triggered is just a hint, using barriers seems to be an overkill.

What's more the current implementation is buggy:

1) event_triggered should be only called when event idx is used
2) the assumption of device won't raise the interrupt is not ture,
this is especially obvious in the case of packed ring, when the
wrap_counter warps twice, we could still get an interrupt from the
device. This means when the virtqueue size is 256 we will get 1
unnecessary notification every 512 packets etc.

So I wonder just a data_race() hint would be more than sufficient.

Thanks

> ---
>  drivers/virtio/virtio_ring.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index fdd2d2b07b5a..b8ff82730618 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -875,9 +875,10 @@ static void virtqueue_disable_cb_split(struct virtqu=
eue *_vq)
>
>                 /*
>                  * If device triggered an event already it won't trigger =
one again:
> -                * no need to disable.
> +                * no need to disable. smp_load_acquire pairs with smp_st=
ore_release()
> +                * in virtqueue_enable_cb_delayed()
>                  */
> -               if (vq->event_triggered)
> +               if (smp_load_acquire(&vq->event_triggered))
>                         return;
>
>                 if (vq->event)
> @@ -1802,9 +1803,10 @@ static void virtqueue_disable_cb_packed(struct vir=
tqueue *_vq)
>
>                 /*
>                  * If device triggered an event already it won't trigger =
one again:
> -                * no need to disable.
> +                * no need to disable. smp_load_acquire pairs with smp_st=
ore_release()
> +                * in virtqueue_enable_cb_delayed()
>                  */
> -               if (vq->event_triggered)
> +               if (smp_load_acquire(&vq->event_triggered))
>                         return;
>
>                 vq->packed.vring.driver->flags =3D
> @@ -2650,7 +2652,8 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *=
_vq)
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
>         if (vq->event_triggered)
> -               vq->event_triggered =3D false;
> +               /* Pairs with smp_load_acquire in virtqueue_disable_cb_sp=
lit/packed() */
> +               smp_store_release(&vq->event_triggered, false);
>
>         return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(_vq) =
:
>                                  virtqueue_enable_cb_delayed_split(_vq);
> --
> 2.25.1
>


