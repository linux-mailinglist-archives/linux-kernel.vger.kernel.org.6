Return-Path: <linux-kernel+bounces-244024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503EE929E21
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0966283B61
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05A125634;
	Mon,  8 Jul 2024 08:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ve6IhAys"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04714374C2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720426522; cv=none; b=Ewjqv+bvnRT1tB11753qE2FPLYE57hYQu5n4PnGWbYDuwBAd5nBTcAk6/AfnJ993c761yxf64rSpE4oXiGux790NYSZyW6MI/lhmzmJjNisXXVDGB3zmRN+0o0dSmHjQjAQa/ri7vqvHoVcb4I0iYUU/sA9icakUNyJ9vMcdqNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720426522; c=relaxed/simple;
	bh=dKXB/G9Ga5mXB9qA2/6q8xshMeS6p7rjRxfC8D2Cmx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtsYYDq4dZBOA9DGjG6IPBJKPm6yfnXgfkfI6HJpKt69CJ1wh/M35r4ra6we/6VgoWsaYGs1zUYAYlxs7Y9/Pk6TqNt6nkZehwwX7oXzSkyiUvk5Fy9AE7Z0zSIi9blxwAdHVHhp+dCplHSHOFs02457P9MFXz6Sw0RuR+EDoWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ve6IhAys; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720426518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OG0AYvDI6pKPkw9PLWzGrpwC8pL8oioT930Qo3BcbHU=;
	b=Ve6IhAysDZy8mqRfY6HM348+pnZQ6NaNWTjtF6Rk74KEjuQaBT/SpwNdcaO8IPw4Vz9UM7
	nOvxmwX2eT8bPo6Jkn3b7siZYEOiquRiLW87VlVMfugtPhoeDfHGRiKo4GNsBBtjx0BYre
	EqqkVvxh3TsIEp8XFwQN9sjCYNanL0s=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-h1UkkeJtOZOUcjM7jl18Iw-1; Mon, 08 Jul 2024 04:15:16 -0400
X-MC-Unique: h1UkkeJtOZOUcjM7jl18Iw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52ea965188eso2256377e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 01:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720426515; x=1721031315;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OG0AYvDI6pKPkw9PLWzGrpwC8pL8oioT930Qo3BcbHU=;
        b=uiB3K5N90d0ueBT1IW6ILIMgPNk+Iu5FqlHLg+WlgGMOj/+Er8J2lkASW58m147+5v
         P3W6OlPBB+yBWak4ASktOLwYscE2O3UbSXVJauU7LPkH+WbaI831KEgaB8Qh5l5UQISS
         GJbbeHrzOZABxRtSImf7kjZDAiWOMAaETr/PGjn3LSGsLGJKQLCC7uTMaP0UPBXlNP/Y
         Q5tY3tKZbWq4hzIKPgU5E7GABuuoodbhLH+kvsme5DfMvuCl0HFeunuUqkR7TZKTB8a6
         mfbHlGIcqiz6VhZ9O5dz7vnxSA6gVy3LZz2eJ5WwCfREru3WAQLgvyr7wWsL2eRxT0mF
         Bldg==
X-Forwarded-Encrypted: i=1; AJvYcCVbgTf0zXL644K4ojhUsh3WUG0tyWzcR0mlkWj1fcSTCGs2JurXbz4YHsYEsefJBLwCbCY7HHNbPqjU+jBhcZPg6+rhBJVpLKf/muwo
X-Gm-Message-State: AOJu0YyHogsWuZ0V08c0C9/MiGqfAPBNBqbX8tEtJkdgSKJ8nBNTLKPH
	Oz/64Q83oCXVCbJyMWksNjpzi12OsBtojBswXSvE0FUBC5zgykTyHIyoo/wjnP5wxqRtZuGjdzk
	QW43O+k1VqbtvCnQ8MpegJhVWJ3G1UbxYGnvDUGBmfoUGOgqBMhUU4++oxQz4tQ==
X-Received: by 2002:a05:6512:3da3:b0:52c:db80:d694 with SMTP id 2adb3069b0e04-52ea0626e92mr9353485e87.20.1720426515241;
        Mon, 08 Jul 2024 01:15:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTCsf/MPTtA5XrBzjkG9uNn3dPW48c8ptW32vLC9R7xU4KNpDQkOGELcZz2l+Dsg4EhRxSnA==
X-Received: by 2002:a05:6512:3da3:b0:52c:db80:d694 with SMTP id 2adb3069b0e04-52ea0626e92mr9353456e87.20.1720426514639;
        Mon, 08 Jul 2024 01:15:14 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-153.retail.telecomitalia.it. [82.57.51.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2518f9sm155401225e9.31.2024.07.08.01.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 01:15:14 -0700 (PDT)
Date: Mon, 8 Jul 2024 10:15:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH] vdpa_sim_blk: add `capacity` module parameter
Message-ID: <3f5d33l4c73nudppajvhnjhpdpvft5yolm7vdraikany2tfdjz@i62d45j4ucs5>
References: <20240705112821.144819-1-sgarzare@redhat.com>
 <20240705073017-mutt-send-email-mst@kernel.org>
 <25fehn7xgvqyqgd6zcscsjazzfhktyjrazffyrtbp2oibnhkey@ggobdyv4zxkf>
 <CACLfguWtcdTM-+GjiXWC-s=d-bvkUedHbCimzsfvYXWJ-=3iDQ@mail.gmail.com>
 <CACGkMEurseUpMKaiLpJEkcT9U_tmqm4yqp3OgR--6XnAY=C9WQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEurseUpMKaiLpJEkcT9U_tmqm4yqp3OgR--6XnAY=C9WQ@mail.gmail.com>

Hi Cindy, Jason,

On Mon, Jul 08, 2024 at 03:59:34PM GMT, Jason Wang wrote:
>On Mon, Jul 8, 2024 at 3:06 PM Cindy Lu <lulu@redhat.com> wrote:
>>
>> On Fri, 5 Jul 2024 at 20:42, Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >
>> > On Fri, Jul 05, 2024 at 07:30:51AM GMT, Michael S. Tsirkin wrote:
>> > >On Fri, Jul 05, 2024 at 01:28:21PM +0200, Stefano Garzarella wrote:
>> > >> The vDPA block simulator always allocated a 128 MiB ram-disk, but some
>> > >> filesystems (e.g. XFS) may require larger minimum sizes (see
>> > >> https://issues.redhat.com/browse/RHEL-45951).
>> > >>
>> > >> So to allow us to test these filesystems, let's add a module parameter
>> > >> to control the size of the simulated virtio-blk devices.
>> > >> The value is mapped directly to the `capacity` field of the virtio-blk
>> > >> configuration space, so it must be expressed in sector numbers of 512
>> > >> bytes.
>> > >>
>> > >> The default value (0x40000) is the same as the previous value, so the
>> > >> behavior without setting `capacity` remains unchanged.
>> > >>
>> > >> Before this patch or with this patch without setting `capacity`:
>> > >>   $ modprobe vdpa-sim-blk
>> > >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
>> > >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
>> > >>   virtio_blk virtio6: [vdb] 262144 512-byte logical blocks (134 MB/128 MiB)
>> > >>
>> > >> After this patch:
>> > >>   $ modprobe vdpa-sim-blk capacity=614400
>> > >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
>> > >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
>> > >>   virtio_blk virtio6: [vdb] 614400 512-byte logical blocks (315 MB/300 MiB)
>> > >>
>> > >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > >
>> > >What a hack. Cindy was working on adding control over config
>> > >space, why can't that be used?
>> >
>> > If it can be used easily with virtio-blk device too, it will be great.
>> > @Cindy do you plan to support that changes for a virtio-blk device too?
>> >
>> Hi Stefano
>> I plan to add support to change the vdpa device's configuration after
>> it is created.
>
>I think for Stefano's case, we can just implement it via provisioning
>parameters?

Yep, I think we don't need to change it after creation, but specifying 
while creating should be enough.

So, IIUC we can already do it, implementing something similar to 
vdpasim_net_setup_config() to call during vdpasim_blk_dev_add(), right?

What about when we have `shared_backend` set to true for the 
vdpa_sim_blk.ko? In this case the backend is supposed to be shared 
between all the devices to test live migration.

Maybe we can just change the size of the shared ramdisk to be reflected 
to all devices.

Suggestions?

@Cindy do you want to work on this for blk as well?
If you don't have time, I'll look at it when I can allocate some time.

>
>Thanks
>
>> In the first step, I want to use the vdpa tool to add
>> support for changing the MAC address for the network device. the next
>> step will also add MTU settings etc
>> here is the link
>> https://lore.kernel.org/all/20240708064820.88955-1-lulu@redhat.com/T/#t
>>

I'll take a look, thanks for ccing me!

Stefano

>> in the device part, the device needs to implement its function of
>> int (*dev_set_attr)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev,
>>        const struct vdpa_dev_set_config *config);
>> the configuration will be passed by struct vdpa_dev_set_config. I'm
>> not sure if this kind of design is suitable for you? Really thanks and
>> any comments are welcome
>> thanks
>> Cindy
>>
>>
>> > In the mean time, for the simulator I thought that this change was fine.
>> > It's just used for testing and debugging...
>> >
>> > My main question is how to use that when we have `shared_backend` set to
>> > true, since we use that setting to test for example live migration. In
>> > that case, how do we handle the size of the shared ramdisk between
>> > devices?
>> >
>> > Thanks,
>> > Stefano
>> >
>>
>


