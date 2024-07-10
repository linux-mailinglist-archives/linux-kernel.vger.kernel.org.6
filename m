Return-Path: <linux-kernel+bounces-247152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 598FE92CBED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B44A1C22B12
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A835882C63;
	Wed, 10 Jul 2024 07:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsOda2py"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F7982D66
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720596537; cv=none; b=fDDZiX/Vn56yTxB7k2mJncnOiJ1AUBNSd3vXVFKjHjuXrkr+cuwPI2f0lVxAL2WpfoN5k+JKt+YHiIomHaQE0zDHGzjcg5jQepzGtn2c7DtEvkVNAW1H8DKG4KlsqwvMZSjDwj44TTogFOrGw23S/uRh8IM4FdAXiPAsRLLdJ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720596537; c=relaxed/simple;
	bh=xQh5HU5tluzMTaHOeOkGuFGYbA1Vq50E5qJn6PoW5Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAeuqKcFVYgTCrmm32U7q1V/N52Sw1Fsd69aZZTxd/DmX6ntsQBXpvkK/+GDCAFJyWP82UlAYvvH+/KcuEM6CQjO8AxIwaRk/+0oT3S294QBcd1YXmMAiddj1XJxnHMYFTpR6USqgHoohlnAYb8r6oNG7uodZm90/xZoaxeTQNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SsOda2py; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720596534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TxCFFb+O+FYVotTIPR8WWbYkloVGsx7sbWOFar1qXXo=;
	b=SsOda2pyMjejK8OnWMr0iVLjxvbIrPL82u+YfLif7/ESI1TBD99DTUzn4DyD0m7+zg9H4P
	MYjo0izuRknOAQPSQw9/oDFYR3KyNAeGclhPxUH0svLeBkME6J7Bwg1dR4qpzeq8mysw0Z
	ZkG7t4EWuSPYbM7XAPcQC5fLb13gZHU=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-WtUfGOnEPAecR85ZWSa3VQ-1; Wed, 10 Jul 2024 03:28:44 -0400
X-MC-Unique: WtUfGOnEPAecR85ZWSa3VQ-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-25e919618c4so2797283fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 00:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720596524; x=1721201324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxCFFb+O+FYVotTIPR8WWbYkloVGsx7sbWOFar1qXXo=;
        b=GqdJJuq2V3a87OTOktOcyMIGdki9vqCGtWeJ9tXESfuA5ckXeCC14ZlKL1kCLuhIfo
         9Eyio6iFfaDn3znzbWG0DbM7Y/i2ywcwGfACq5Sh/FPWYI7kEnDRmsDSAF9DMU6tb3kE
         Gs+5j9U8MDcGu+g1vjQ9Xh3ASLgj6DX7eOAQjgFwbTSI1zbREAhvOnGDzyt6ZQodroae
         jklY/V8i7qX408CtF5kJ1R80hplP86wnC7sCW1KJSJBkRRK6wvhOHXYj58oLefGR1lLe
         dH0g6xJ9J9CMbsiTbcm3uvaKG0CboN3VF6qLoDrF8F7UE/G94IvyYnwRP/n5fTVyK5GT
         5paw==
X-Forwarded-Encrypted: i=1; AJvYcCU2XGK7mhWHucOM+9GM+UZpjpwhcJ6IAIgB4511XZeyWnBv0z2ns/svNppQeZgGatbzJlbGqaEDcXAjcQHIHf4MjqXFjvj5BVCiaQ5p
X-Gm-Message-State: AOJu0YwPZEl5BSGUZ6hOm0qFZoNHzRLzexss5RWCqifh2+Hq/WQkwJmM
	X4FB5X5kEbzgfHKEbWhIhtfBS33kPx7pjCs8l/oeDBc2/9/rDvlMmN7mOY7wMaVzeNbtbsE77nS
	+XaZxIIObMzz7bqH1FGrzIri0iSGZYpY8jCmR8VhWW/MgecIGvjFBuw+szfmRN6nY7z7oo6NZdn
	6gxOknry87mG8Fr5Uf6otP769/qMZfhSNuUzP0
X-Received: by 2002:a05:6870:71c9:b0:25e:ebb:b4f4 with SMTP id 586e51a60fabf-25eae75fa03mr3659220fac.2.1720596524025;
        Wed, 10 Jul 2024 00:28:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOTIeMcESujn8AqeMOf7hlU3PPNIoV11WktqFb+Dz6M9e/IfuDLcZm0kQUi5duDpXKsbY8UOxkXk1JPmgkqvQ=
X-Received: by 2002:a05:6870:71c9:b0:25e:ebb:b4f4 with SMTP id
 586e51a60fabf-25eae75fa03mr3659213fac.2.1720596523579; Wed, 10 Jul 2024
 00:28:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705112821.144819-1-sgarzare@redhat.com> <20240705073017-mutt-send-email-mst@kernel.org>
 <25fehn7xgvqyqgd6zcscsjazzfhktyjrazffyrtbp2oibnhkey@ggobdyv4zxkf>
 <CACLfguWtcdTM-+GjiXWC-s=d-bvkUedHbCimzsfvYXWJ-=3iDQ@mail.gmail.com>
 <CACGkMEurseUpMKaiLpJEkcT9U_tmqm4yqp3OgR--6XnAY=C9WQ@mail.gmail.com>
 <3f5d33l4c73nudppajvhnjhpdpvft5yolm7vdraikany2tfdjz@i62d45j4ucs5>
 <CACGkMEuqiAx-a0sPJf0Xpvmr=5wbzbuOr0-w+9ZcwQMTWFU1rw@mail.gmail.com>
 <xuruyrbkago7w7tjbvqmfvjoqy665srurqozbenfayagfxl72y@wqy56jenfo2u>
 <CACGkMEtB1maGywWRPNHgVGJog+rbowXvKG0nEDXPn_9-VB0Azw@mail.gmail.com> <emhlvvttkq5yqcbphdkyrcmcxpyk22uxe2eiohmrapmjrv4vsz@zbiixmblizcj>
In-Reply-To: <emhlvvttkq5yqcbphdkyrcmcxpyk22uxe2eiohmrapmjrv4vsz@zbiixmblizcj>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Jul 2024 15:28:31 +0800
Message-ID: <CACGkMEtT-UeLk6Hv1AFXk_yhiVxx-5tWknqs=OYg8+cAGDmd9w@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_blk: add `capacity` module parameter
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 3:19=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Wed, Jul 10, 2024 at 11:08:48AM GMT, Jason Wang wrote:
> >On Tue, Jul 9, 2024 at 8:41=E2=80=AFPM Stefano Garzarella <sgarzare@redh=
at.com> wrote:
> >>
> >> On Tue, Jul 09, 2024 at 10:56:16AM GMT, Jason Wang wrote:
> >> >On Mon, Jul 8, 2024 at 4:15=E2=80=AFPM Stefano Garzarella <sgarzare@r=
edhat.com> wrote:
> >> >>
> >> >> Hi Cindy, Jason,
> >> >>
> >> >> On Mon, Jul 08, 2024 at 03:59:34PM GMT, Jason Wang wrote:
> >> >> >On Mon, Jul 8, 2024 at 3:06=E2=80=AFPM Cindy Lu <lulu@redhat.com> =
wrote:
> >> >> >>
> >> >> >> On Fri, 5 Jul 2024 at 20:42, Stefano Garzarella <sgarzare@redhat=
.com> wrote:
> >> >> >> >
> >> >> >> > On Fri, Jul 05, 2024 at 07:30:51AM GMT, Michael S. Tsirkin wro=
te:
> >> >> >> > >On Fri, Jul 05, 2024 at 01:28:21PM +0200, Stefano Garzarella =
wrote:
> >> >> >> > >> The vDPA block simulator always allocated a 128 MiB ram-dis=
k, but some
> >> >> >> > >> filesystems (e.g. XFS) may require larger minimum sizes (se=
e
> >> >> >> > >> https://issues.redhat.com/browse/RHEL-45951).
> >> >> >> > >>
> >> >> >> > >> So to allow us to test these filesystems, let's add a modul=
e parameter
> >> >> >> > >> to control the size of the simulated virtio-blk devices.
> >> >> >> > >> The value is mapped directly to the `capacity` field of the=
 virtio-blk
> >> >> >> > >> configuration space, so it must be expressed in sector numb=
ers of 512
> >> >> >> > >> bytes.
> >> >> >> > >>
> >> >> >> > >> The default value (0x40000) is the same as the previous val=
ue, so the
> >> >> >> > >> behavior without setting `capacity` remains unchanged.
> >> >> >> > >>
> >> >> >> > >> Before this patch or with this patch without setting `capac=
ity`:
> >> >> >> > >>   $ modprobe vdpa-sim-blk
> >> >> >> > >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
> >> >> >> > >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
> >> >> >> > >>   virtio_blk virtio6: [vdb] 262144 512-byte logical blocks =
(134 MB/128 MiB)
> >> >> >> > >>
> >> >> >> > >> After this patch:
> >> >> >> > >>   $ modprobe vdpa-sim-blk capacity=3D614400
> >> >> >> > >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
> >> >> >> > >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
> >> >> >> > >>   virtio_blk virtio6: [vdb] 614400 512-byte logical blocks =
(315 MB/300 MiB)
> >> >> >> > >>
> >> >> >> > >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> >> >> > >
> >> >> >> > >What a hack. Cindy was working on adding control over config
> >> >> >> > >space, why can't that be used?
> >> >> >> >
> >> >> >> > If it can be used easily with virtio-blk device too, it will b=
e great.
> >> >> >> > @Cindy do you plan to support that changes for a virtio-blk de=
vice too?
> >> >> >> >
> >> >> >> Hi Stefano
> >> >> >> I plan to add support to change the vdpa device's configuration =
after
> >> >> >> it is created.
> >> >> >
> >> >> >I think for Stefano's case, we can just implement it via provision=
ing
> >> >> >parameters?
> >> >>
> >> >> Yep, I think we don't need to change it after creation, but specify=
ing
> >> >> while creating should be enough.
> >> >>
> >> >> So, IIUC we can already do it, implementing something similar to
> >> >> vdpasim_net_setup_config() to call during vdpasim_blk_dev_add(), ri=
ght?
> >> >
> >> >Right.
> >> >
> >> >>
> >> >> What about when we have `shared_backend` set to true for the
> >> >> vdpa_sim_blk.ko? In this case the backend is supposed to be shared
> >> >> between all the devices to test live migration.
> >> >
> >> >This seems to be another topic.
> >>
> >> Yep, but really related. I think we need to handle that case when
> >> supporting the `capacity` setting.
> >
> >Ok, so if I was not wrong, the goal is to test migration.
>
> Sorry, I was not clear, I try to rephrase:
> vdpa_sim_blk already supports a module parameter called `shared_backend`
> introduced mainly to test live migration on the same host. When that
> parameter is on, all the created devices share the same backend and so
> we can easily do migration from one to another.
>
> With that parameter on or off, the device is always 128 MB, but now
> that's a problem for testing, because it looks like XFS requires at
> least 300 MB: https://issues.redhat.com/browse/RHEL-45951
>
> That's why I sent this patch.
>
> When `shared_backend` is off (default), using the provisioning
> parameters seems feasible to me, but when it's on, how do I deal with
> it?
>
> Being a simulator, we can maybe make it so that only the first device
> can change the size for example, or that all devices control the size,
> but then we would have to handle the size change at runtime, which I
> think is feasible, but it requires some work to send a notification of
> configuration change, etc.

Can we mandate the size parameter to be exactly the same as the first
vDPA block simulator?

>
> >
> >>
> >> >
> >> >>
> >> >> Maybe we can just change the size of the shared ramdisk to be refle=
cted
> >> >> to all devices.
> >> >>
> >> >> Suggestions?
> >> >
> >> >Could we specify the path to tmpfs or others during provisioning
> >> >instead?  It seems more general (but more work).
> >>
> >> Then it would almost become a real device, no longer just a simulator.
> >> It's enough work, though, as you said, but at that point we'd just hav=
e
> >> to specify the backend file to use for the device.
> >>
> >> In that case what API would we need to use to allow the user to set th=
e
> >> backend file?
> >
> >Yes, I think we can allow some vendor specific provisioning parameters.
> >
> >But not sure it's an overkill for the use case here. If others are
> >happy with the shared_backed. I'm fine.
>
> Yeah, maybe it's overkill and I don't have much time these days :-(
>
> I think the easiest way is to merge this patch, but I understand that a
> module parameter is not very beautiful
>
> I'll try to see if I can implement provisioning parameters for
> vdpa_sim_blk. Allowing capacity to be set only to the first device if
> `shared_backend` is on.
>
> WDYT?

Something like this.

When there's no block simulator, allow an arbitrary capacity. When
there is one, fail the creation when the capacity doesn't match. (when
'shared_backend' is on).

Thanks

>
> Thanks,
> Stefano
>


