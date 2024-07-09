Return-Path: <linux-kernel+bounces-245101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D04B492AE59
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 04:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43DA31F22606
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B7C40856;
	Tue,  9 Jul 2024 02:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dewLOMZ/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D337163A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 02:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720493793; cv=none; b=CGYGYqXVXsSgvWtvx/vRJ4XkSxgYOrGpbJOkBf271SksQUg+xiWs2ZQTzTYmsNzAqOmpuiqDlSLKrbVdikUkvDPzNGPYHVruONqatOqoR9RAPBaIPl4fKGODNZjmXIxCUroNC/mSKpBtv9Q2tVSgvCxlY3/bfw6GCDMmbvMmGMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720493793; c=relaxed/simple;
	bh=N+XTVxs+QnQqIh4zTMz3kJHiUrAHsvw06NWUYsO9IOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xgtn+TJ+tDjuFeIwMmshL+dZoe3FIp3naCN4arWNKoNAq+LQQdgKTv012R6AIdRglnCHEoxwQY2+PiiO96NwJoxO9Q0fYIiDvXO7ISp+IetSsgstYoSZJaLaCYpZq7qTiI4YHJmrSHg/JvQvUx17a/dAcGIc+a3O6+OqezNzFPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dewLOMZ/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720493790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vTng96XdisraOc8AWV9UDvrNuZOXIjZnrGjTq93nz8I=;
	b=dewLOMZ/hcr329IsXF05ZR2LF684ohezj/VT63r7AMIYDnoE7JPcA3x9HF7DxkGN2UPAb9
	CDAm1UXdXsCXanirlEYwKnemZsU4MfoRWVRYe8JX6PCjlBo4hYFhbLfaK13peqp3428IXO
	QyHfcsVclgP++nC2h6iZ5vISjVoT7XU=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-EVjicj-BO6KQKBxfgIM4FQ-1; Mon, 08 Jul 2024 22:56:29 -0400
X-MC-Unique: EVjicj-BO6KQKBxfgIM4FQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-70af0dff5c5so2721628b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 19:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720493788; x=1721098588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTng96XdisraOc8AWV9UDvrNuZOXIjZnrGjTq93nz8I=;
        b=nYsbMxYWt8poHlxZjpKVah36wWhgeiTlnGC3lbBRDcep0tZmSd+RfsIp5yeAmsj/3H
         9oR74MSrPmBaaSF6dIfpVokbfaMOA+JvgEaVo7dbfy23QJr17fLOHoecTHcHsas05Shy
         XtQjgBG3PVUHk9/Ka3IZhOi/bvDm0JZwaloJlasu2jRlAi+7skBINhN63civc2BCWx1t
         U6ZVyAzrGEKu5Pk2otwr0ra0FD0110zWQo2VuBmTRIMI0ka7/mjmxJx/92oujkjijrjB
         34cT2gtye00k5RYN8H5Ima5Synj94aiEoADkxSR+QECgRkb8VEFv6CH2LJ0yv70bx8tF
         Stow==
X-Forwarded-Encrypted: i=1; AJvYcCXchggZ8O0Sg0kC30o2NEZSH00cPIUDDkEYciMIAG9yHWHc9UzCfYc+sLvM8OmW9ie4789sHKbCHUUuflVpm67YNJbDr7pAh9vN/EGr
X-Gm-Message-State: AOJu0YwYzIlGgscEaVqubFD035HJI704P0Bfs9+jyLgLwS2aazRiV7DR
	fDSwprGvvtkfhGxsEH7vPFQQW4Sl5LNesouYxu+gnO1xGFo5Ubevob3JS1SuCKBkIBMWvglWtc0
	6fweQnyCiVfKKm4/p8TJsfWsiyJ6hs9frt5FXXVtOc/gBTr7s25tMnhedNHGnODfpET5unRDfHL
	E2TRoGztNCiiGflL0lbAfkRPON4JayHTBe/i6hqLYWyPk7ufxQWA==
X-Received: by 2002:a05:6a00:b87:b0:705:9b04:71b with SMTP id d2e1a72fcca58-70b43664bd9mr1571099b3a.31.1720493788354;
        Mon, 08 Jul 2024 19:56:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhK9BmZSJsOmkhsPkGQ5uDjeC+binYH7qnVpn/VZV9HKetBL5xdgRnxqJtOc7yRx6VH3Mw8noAj+9wLv0Ezd8=
X-Received: by 2002:a05:6a00:b87:b0:705:9b04:71b with SMTP id
 d2e1a72fcca58-70b43664bd9mr1571084b3a.31.1720493787880; Mon, 08 Jul 2024
 19:56:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705112821.144819-1-sgarzare@redhat.com> <20240705073017-mutt-send-email-mst@kernel.org>
 <25fehn7xgvqyqgd6zcscsjazzfhktyjrazffyrtbp2oibnhkey@ggobdyv4zxkf>
 <CACLfguWtcdTM-+GjiXWC-s=d-bvkUedHbCimzsfvYXWJ-=3iDQ@mail.gmail.com>
 <CACGkMEurseUpMKaiLpJEkcT9U_tmqm4yqp3OgR--6XnAY=C9WQ@mail.gmail.com> <3f5d33l4c73nudppajvhnjhpdpvft5yolm7vdraikany2tfdjz@i62d45j4ucs5>
In-Reply-To: <3f5d33l4c73nudppajvhnjhpdpvft5yolm7vdraikany2tfdjz@i62d45j4ucs5>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Jul 2024 10:56:16 +0800
Message-ID: <CACGkMEuqiAx-a0sPJf0Xpvmr=5wbzbuOr0-w+9ZcwQMTWFU1rw@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_blk: add `capacity` module parameter
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 4:15=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> Hi Cindy, Jason,
>
> On Mon, Jul 08, 2024 at 03:59:34PM GMT, Jason Wang wrote:
> >On Mon, Jul 8, 2024 at 3:06=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >>
> >> On Fri, 5 Jul 2024 at 20:42, Stefano Garzarella <sgarzare@redhat.com> =
wrote:
> >> >
> >> > On Fri, Jul 05, 2024 at 07:30:51AM GMT, Michael S. Tsirkin wrote:
> >> > >On Fri, Jul 05, 2024 at 01:28:21PM +0200, Stefano Garzarella wrote:
> >> > >> The vDPA block simulator always allocated a 128 MiB ram-disk, but=
 some
> >> > >> filesystems (e.g. XFS) may require larger minimum sizes (see
> >> > >> https://issues.redhat.com/browse/RHEL-45951).
> >> > >>
> >> > >> So to allow us to test these filesystems, let's add a module para=
meter
> >> > >> to control the size of the simulated virtio-blk devices.
> >> > >> The value is mapped directly to the `capacity` field of the virti=
o-blk
> >> > >> configuration space, so it must be expressed in sector numbers of=
 512
> >> > >> bytes.
> >> > >>
> >> > >> The default value (0x40000) is the same as the previous value, so=
 the
> >> > >> behavior without setting `capacity` remains unchanged.
> >> > >>
> >> > >> Before this patch or with this patch without setting `capacity`:
> >> > >>   $ modprobe vdpa-sim-blk
> >> > >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
> >> > >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
> >> > >>   virtio_blk virtio6: [vdb] 262144 512-byte logical blocks (134 M=
B/128 MiB)
> >> > >>
> >> > >> After this patch:
> >> > >>   $ modprobe vdpa-sim-blk capacity=3D614400
> >> > >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
> >> > >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
> >> > >>   virtio_blk virtio6: [vdb] 614400 512-byte logical blocks (315 M=
B/300 MiB)
> >> > >>
> >> > >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> > >
> >> > >What a hack. Cindy was working on adding control over config
> >> > >space, why can't that be used?
> >> >
> >> > If it can be used easily with virtio-blk device too, it will be grea=
t.
> >> > @Cindy do you plan to support that changes for a virtio-blk device t=
oo?
> >> >
> >> Hi Stefano
> >> I plan to add support to change the vdpa device's configuration after
> >> it is created.
> >
> >I think for Stefano's case, we can just implement it via provisioning
> >parameters?
>
> Yep, I think we don't need to change it after creation, but specifying
> while creating should be enough.
>
> So, IIUC we can already do it, implementing something similar to
> vdpasim_net_setup_config() to call during vdpasim_blk_dev_add(), right?

Right.

>
> What about when we have `shared_backend` set to true for the
> vdpa_sim_blk.ko? In this case the backend is supposed to be shared
> between all the devices to test live migration.

This seems to be another topic.

>
> Maybe we can just change the size of the shared ramdisk to be reflected
> to all devices.
>
> Suggestions?

Could we specify the path to tmpfs or others during provisioning
instead?  It seems more general (but more work).

>
> @Cindy do you want to work on this for blk as well?
> If you don't have time, I'll look at it when I can allocate some time.
>
> >
> >Thanks

Thanks

> >
> >> In the first step, I want to use the vdpa tool to add
> >> support for changing the MAC address for the network device. the next
> >> step will also add MTU settings etc
> >> here is the link
> >> https://lore.kernel.org/all/20240708064820.88955-1-lulu@redhat.com/T/#=
t
> >>
>
> I'll take a look, thanks for ccing me!
>
> Stefano
>
> >> in the device part, the device needs to implement its function of
> >> int (*dev_set_attr)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *de=
v,
> >>        const struct vdpa_dev_set_config *config);
> >> the configuration will be passed by struct vdpa_dev_set_config. I'm
> >> not sure if this kind of design is suitable for you? Really thanks and
> >> any comments are welcome
> >> thanks
> >> Cindy
> >>
> >>
> >> > In the mean time, for the simulator I thought that this change was f=
ine.
> >> > It's just used for testing and debugging...
> >> >
> >> > My main question is how to use that when we have `shared_backend` se=
t to
> >> > true, since we use that setting to test for example live migration. =
In
> >> > that case, how do we handle the size of the shared ramdisk between
> >> > devices?
> >> >
> >> > Thanks,
> >> > Stefano
> >> >
> >>
> >
>


