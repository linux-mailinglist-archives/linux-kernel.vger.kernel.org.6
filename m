Return-Path: <linux-kernel+bounces-413041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F142E9D12A7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34FB2832D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A271A0B0C;
	Mon, 18 Nov 2024 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYFko4Wz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF83819A298
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731938885; cv=none; b=KWG5C9VcV4JE8ZAXN+/tMPZGSbUdWzdfR2HCFEakf0j7M3Oo+9jeFOPbg8l6e6FGhJxzoGR/yVk001GMyP4Okbp8xRJB2aTn6lcgb3osfEjPGjxNCp0tWRaSe6LL/hwfcwimGEfCAfJXYeGccqLmpSkLP5Odffbl5PYLtzOx4F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731938885; c=relaxed/simple;
	bh=SL4Y1eNf3axA4/FlExJQffOT+e+k7+y6DPFaDWJm9qA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnk5WRLA108k/7ASxpmmy1wEx4aLga5golEVZZXyM/esW81bk7RAxto1e+JPkTX1StdLw7330WyEU+3LBa+m5nvzt+J7nEU7fpiZ/o8PP8NSChT/EtUN341yJlAEMRPyZ3EaM1s/VUT8NZA8CvRPYyJGYXFywI9JOw/qzpT6PRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YYFko4Wz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731938882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ls0eS4Y3YVz07IP+EhoUsET0PplclqIr8lu3ktk+u5k=;
	b=YYFko4WzCA0HG3gA+n2Pe4tI+TNaNJahhDuOKqEbETCyp1G50FDeyQhxe7Cci8yl/odXrH
	bGzfd1cZnmiIe1cHSvVDMce1PIyCduKT3Qw/MQa+Y2VMHS7PN70GXr6S3jc8tAFL2lolmJ
	C5fFcVZlJfGr7Bp0dcLT8rmqTQqkeOw=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-_mtqyBnpM-qaqJQNgrARwg-1; Mon, 18 Nov 2024 09:07:56 -0500
X-MC-Unique: _mtqyBnpM-qaqJQNgrARwg-1
X-Mimecast-MFC-AGG-ID: _mtqyBnpM-qaqJQNgrARwg
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-6ee5790da08so30620907b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 06:07:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731938876; x=1732543676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ls0eS4Y3YVz07IP+EhoUsET0PplclqIr8lu3ktk+u5k=;
        b=hgfimfSVxJGpvI2Z3w4MGJ7M6AbIRSAmDbrS6+vuY6IBQal5Tkmy/U/NcouVw04+nP
         nPuvZmQeWKCEy8A442eLQJpGonAd2VfqdttiofXEmaHMxhmjOO4BkWKEiw9jSPm8/om4
         aC1TtUs3WHh9ncrw/QA7TBLB7uMwgbaFlg78Nvup2+Rz5vlOXL1BZ34TPfoIqIdCrvca
         +aXfE7wPaHi6QV0by1DX+CdfR/VBSjFMPQjsVh/7i3G8S/w65BG6ae5708wkFOu2gqkg
         iBAB1cO1cf+EBHcJfrE54xJMrQqforfKf/GcNxPFDi5l0TLZ8B4yhevwNOrc886OdbTe
         KW9w==
X-Forwarded-Encrypted: i=1; AJvYcCWce67tbqhVueABUjSU3LEnkjxelXrkOEw6XWEhZDtyfXbRQ8fMqO5iPbgGvnJi8kxXo3PaHfioJYIW8BE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6qWezzfv+Ot3cY0NRPnoocn7HEuvZWUgpaRsManvtVmSMqvh0
	7l5RM2yZq2dhjXjpNn8fM4SSExOVOz5kYPenQs/tXVxpLYtjrdCOsME6T9uFLTgtCLwI/Lf4lZt
	c6ziAdsctJ+fDlxY5hXf8gnE9W5hb5NKuoNkEOEgyDvDh0RdZlEAxFdMvC3KM9qbnp/2QKgep41
	JSUNzUjDctN+XzTF2pSRU/z/KqZZB4Xna4rT9R
X-Received: by 2002:a05:690c:6802:b0:6ee:87f2:d23e with SMTP id 00721157ae682-6ee87f2d39bmr43332697b3.22.1731938875693;
        Mon, 18 Nov 2024 06:07:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiqpbTcWqehqFgM8ZzDzeKjZvPeGxXveks1ivMQC2hfyk0PbNu/4N9hBB3ApxvIxF0JoJLwcnAe9iB6nd1xJo=
X-Received: by 2002:a05:690c:6802:b0:6ee:87f2:d23e with SMTP id
 00721157ae682-6ee87f2d39bmr43332237b3.22.1731938875266; Mon, 18 Nov 2024
 06:07:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115103016.86461-1-graf@amazon.com> <yjhfe5bsnfpqbnibxl2urrnuowzitxnrbodlihz4y5csig7e7p@drgxxxxgokfo>
 <dca2f6ff-b586-461d-936d-e0b9edbe7642@amazon.com>
In-Reply-To: <dca2f6ff-b586-461d-936d-e0b9edbe7642@amazon.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 18 Nov 2024 15:07:43 +0100
Message-ID: <CAGxU2F6eJA+vpYVbE0HNW794pF6wLL+o=92NYMQVvmFWnpNPaA@mail.gmail.com>
Subject: Re: [PATCH] vsock/virtio: Remove queued_replies pushback logic
To: Alexander Graf <graf@amazon.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	Asias He <asias@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 4:49=E2=80=AFPM Alexander Graf <graf@amazon.com> wr=
ote:
>
> Hi Stefano,
>
> On 15.11.24 12:59, Stefano Garzarella wrote:
> >
> > On Fri, Nov 15, 2024 at 10:30:16AM +0000, Alexander Graf wrote:
> >> Ever since the introduction of the virtio vsock driver, it included
> >> pushback logic that blocks it from taking any new RX packets until the
> >> TX queue backlog becomes shallower than the virtqueue size.
> >>
> >> This logic works fine when you connect a user space application on the
> >> hypervisor with a virtio-vsock target, because the guest will stop
> >> receiving data until the host pulled all outstanding data from the VM.
> >
> > So, why not skipping this only when talking with a sibling VM?
>
>
> I don't think there is a way to know, is there?
>

I thought about looking into the header and check the dst_cid.
If it's > VMADDR_CID_HOST, we are talking with a sibling VM.

>
> >
> >>
> >> With Nitro Enclaves however, we connect 2 VMs directly via vsock:
> >>
> >>  Parent      Enclave
> >>
> >>    RX -------- TX
> >>    TX -------- RX
> >>
> >> This means we now have 2 virtio-vsock backends that both have the
> >> pushback
> >> logic. If the parent's TX queue runs full at the same time as the
> >> Enclave's, both virtio-vsock drivers fall into the pushback path and
> >> no longer accept RX traffic. However, that RX traffic is TX traffic on
> >> the other side which blocks that driver from making any forward
> >> progress. We're not in a deadlock.
> >>
> >> To resolve this, let's remove that pushback logic altogether and rely =
on
> >> higher levels (like credits) to ensure we do not consume unbounded
> >> memory.
> >
> > I spoke quickly with Stefan who has been following the development from
> > the beginning and actually pointed out that there might be problems
> > with the control packets, since credits only covers data packets, so
> > it doesn't seem like a good idea remove this mechanism completely.
>
>
> Can you help me understand which situations the current mechanism really
> helps with, so we can look at alternatives?

Good question!
I didn't participate in the initial development, so what I'm telling
you is my understanding.
@Stefan feel free to correct me!

The driver uses a single workqueue (virtio_vsock_workqueue) where it
queues several workers. The ones we are interested in are:
1. the one to handle avail buffers in the TX virtqueue (send_pkt_work)
2. the one for used buffers in the RX virtqueue (rx_work)

Assuming that the same kthread executes the different workers, it
seems to be more about making sure that the RX worker (i.e. rx_work)
does not consume all the execution time, leaving no room for TX
(send_pkt_work). Especially when there are a lot of messages queued in
the TX queue that are considered as response for the host. (The
threshold seems to be the size of the virtqueue).

That said, perhaps just adopting a technique like the one in vhost
(byte_weight in vhost_dev_init(), vhost_exceeds_weight(), etc.) where
after a certain number of packets/bytes handled, the worker terminates
its work and reschedules, could give us the same guarantees, in a
simpler way.

>
>
> >
> >>
> >> Fixes: 0ea9e1d3a9e3 ("VSOCK: Introduce virtio_transport.ko")
> >
> > I'm not sure we should add this Fixes tag, this seems very risky
> > backporting on stable branches IMHO.
>
>
> Which situations do you believe it will genuinely break anything in?

The situation for which it was introduced (which I don't know
precisely because I wasn't following vsock yet).
Removing it completely without being sure that what it was developed
for is okay is risky to me.

Support for sibling VMs has only recently been introduced, so I'd be
happier making these changes just for that kind of communication.

That said, the idea of doing like vhost might solve all our problems,
so in that case maybe it might be okay.

> As
> it stands today, if you run upstream parent and enclave and hammer them
> with vsock traffic, you get into a deadlock. Even without the flow
> control, you will never hit a deadlock. But you may get a brown-out like
> situation while Linux is flushing its buffers.
>
> Ideally we want to have actual flow control to mitigate the problem
> altogether. But I'm not quite sure how and where. Just blocking all
> receiving traffic causes problems.
>
>
> > If we cannot find a better mechanism to replace this with something
> > that works both guest <-> host and guest <-> guest, I would prefer
> > to do this just for guest <-> guest communication.
> > Because removing this completely seems too risky for me, at least
> > without a proof that control packets are fine.
>
>
> So your concern is that control packets would not receive pushback, so
> we would allow unbounded traffic to get queued up?

Right, most of `reply` are control packets (reset and response IIUC)
that are not part of the credit mechanism, so I think this confirms
what Stefan was telling me.

> Can you suggest
> options to help with that?

Maybe mimic vhost approach should help, or something similar.

That said, did you really encounter a real problem or is it more of a
patch to avoid future problems.

Because it would be nice to have a test that emphasizes this problem
that we can use to check that everything is okay if we adopt something
different. The same goes for the problem that this mechanism wants to
avoid, I'll try to see if I have time to write a test so we can use
it.


Thanks,
Stefano


