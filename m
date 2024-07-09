Return-Path: <linux-kernel+bounces-245810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FF892B9B2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC6F2859A2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894AD158DCD;
	Tue,  9 Jul 2024 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ckcGj7KF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E8115821E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528872; cv=none; b=ezeswOMVlMaqa2YRC+fbcDx2wShPSGFrXKgrHY8w0nkbWWWn5EK9o7ReGoBOuaJVuDlubGhBKX8sVNKS3JRr8Fa2ISVM47Wc/WxTN7pbU/SMtGXI50GovgPY9NmzhdBi5U1tlUejMKNTb1WC15UIdcSOwRPeW7g4dSN2usJV16s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528872; c=relaxed/simple;
	bh=ze9AOLrz+ICxdMDLy84M9GybEld7okXJb1nQIVXTDwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnpOkpefQCMPOL/szjT3dvwUGXP0ADw1HtdsqIJMCqhRBu8IScam+QyAYjooABXCk84nPs0hdPOdoWigizYN1ZHxQa90KDF2vaFAgQYL+nsFQlwfHD14QOD+h7Jx2G6go6MB8L9h8ZXEs+3RqFwGyu1NVBFIs8oDcHbJEAwN3A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ckcGj7KF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720528869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q27EruAvCtnaYOsHGXrH845lUZXaPs+eeac1z+AiToY=;
	b=ckcGj7KFcvjlz9qTYcDhYjkACG/zqZsxeoSakb0jv8L7MQVnzkPy6mMg8cUS+O8kYblV9N
	lCYA6Vs5LYhagFuFfOQGlnpHgnuM/DHEGGEXWWKpktrV6hUT6AT1Px4x6Fpkdtf6xW1YLl
	GZ85JjZELt2Vrz4e3FanmYDnXQZKmRk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-h_j5GCLxMh6sEnQud5GO8g-1; Tue, 09 Jul 2024 08:41:07 -0400
X-MC-Unique: h_j5GCLxMh6sEnQud5GO8g-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a77c589d819so385426066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 05:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720528866; x=1721133666;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q27EruAvCtnaYOsHGXrH845lUZXaPs+eeac1z+AiToY=;
        b=ZJX0YS0Sso6tlbHt33qwvLO3+y4NbvvJPPvmA5DPYPYjPmhnxrJouHPpBNCy/xVQoK
         g++nALfHYXh+M2hf81fbbjL0+pL2wzYoQw5/R43OoWITAS7EHkL6m6JpZT+vXxA2HxtZ
         S1ZOdKem1vgQRHYFQnwb1QKmTAGSGKRuG0cDi+LB8AM7STmFyMoVOFdQhw49o7nPWf89
         coUKJpD5JNSLSWo5tqnaa8z4Z2FYrhpYF+0vydE9tmt7aTee4e9Otagq7TXEIt63N/5U
         zYPsoWkUMyVWAkO4nJTy3/9ReIEu2H5QmqWKRvwjKp73Su4n6LfIY9GSBe/Dn5fDB9sA
         Gmdw==
X-Forwarded-Encrypted: i=1; AJvYcCW0dfgZupxzVjJ4J6zXlLDet6abQxEshCB1zwFY9ZY1EpxoHdawdk/EJeyVYoStPRaplTzbo6GKGWMwD7rXfiFif5Was3+IdXok+mwB
X-Gm-Message-State: AOJu0Ywh8mpfyrAMBUVwQHds76yf5l3HnYiG1QB/0Un/tRPd2W5Qi64L
	GQO7YY19Q8nA2MqnK3BkxHqgf0P3hTsgdN5Pu8OsFQ1PCKViG9iW2qaNSbzxDd4Xy5FG02KQnqP
	w06GetcElOs9fSZx3N25A2BTSWEx3oy/WrHh1qsbQN2hZAJA4E4+QDPyHhb7jaqk1zbHUbw==
X-Received: by 2002:a17:906:260d:b0:a72:b287:1e04 with SMTP id a640c23a62f3a-a780b70106fmr152227666b.34.1720528866422;
        Tue, 09 Jul 2024 05:41:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNZGGmkkPI3KvvxS+NzWsyjgFEi+4Hfd0wCUZA4uYxlxSQFOpFm25Vm+Zlvi7CADfxvDpLLA==
X-Received: by 2002:a17:906:260d:b0:a72:b287:1e04 with SMTP id a640c23a62f3a-a780b70106fmr152225766b.34.1720528865869;
        Tue, 09 Jul 2024 05:41:05 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-153.retail.telecomitalia.it. [82.57.51.153])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bbe2d006sm1016274a12.31.2024.07.09.05.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:41:05 -0700 (PDT)
Date: Tue, 9 Jul 2024 14:41:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH] vdpa_sim_blk: add `capacity` module parameter
Message-ID: <xuruyrbkago7w7tjbvqmfvjoqy665srurqozbenfayagfxl72y@wqy56jenfo2u>
References: <20240705112821.144819-1-sgarzare@redhat.com>
 <20240705073017-mutt-send-email-mst@kernel.org>
 <25fehn7xgvqyqgd6zcscsjazzfhktyjrazffyrtbp2oibnhkey@ggobdyv4zxkf>
 <CACLfguWtcdTM-+GjiXWC-s=d-bvkUedHbCimzsfvYXWJ-=3iDQ@mail.gmail.com>
 <CACGkMEurseUpMKaiLpJEkcT9U_tmqm4yqp3OgR--6XnAY=C9WQ@mail.gmail.com>
 <3f5d33l4c73nudppajvhnjhpdpvft5yolm7vdraikany2tfdjz@i62d45j4ucs5>
 <CACGkMEuqiAx-a0sPJf0Xpvmr=5wbzbuOr0-w+9ZcwQMTWFU1rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuqiAx-a0sPJf0Xpvmr=5wbzbuOr0-w+9ZcwQMTWFU1rw@mail.gmail.com>

On Tue, Jul 09, 2024 at 10:56:16AM GMT, Jason Wang wrote:
>On Mon, Jul 8, 2024 at 4:15 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> Hi Cindy, Jason,
>>
>> On Mon, Jul 08, 2024 at 03:59:34PM GMT, Jason Wang wrote:
>> >On Mon, Jul 8, 2024 at 3:06 PM Cindy Lu <lulu@redhat.com> wrote:
>> >>
>> >> On Fri, 5 Jul 2024 at 20:42, Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >> >
>> >> > On Fri, Jul 05, 2024 at 07:30:51AM GMT, Michael S. Tsirkin wrote:
>> >> > >On Fri, Jul 05, 2024 at 01:28:21PM +0200, Stefano Garzarella wrote:
>> >> > >> The vDPA block simulator always allocated a 128 MiB ram-disk, but some
>> >> > >> filesystems (e.g. XFS) may require larger minimum sizes (see
>> >> > >> https://issues.redhat.com/browse/RHEL-45951).
>> >> > >>
>> >> > >> So to allow us to test these filesystems, let's add a module parameter
>> >> > >> to control the size of the simulated virtio-blk devices.
>> >> > >> The value is mapped directly to the `capacity` field of the virtio-blk
>> >> > >> configuration space, so it must be expressed in sector numbers of 512
>> >> > >> bytes.
>> >> > >>
>> >> > >> The default value (0x40000) is the same as the previous value, so the
>> >> > >> behavior without setting `capacity` remains unchanged.
>> >> > >>
>> >> > >> Before this patch or with this patch without setting `capacity`:
>> >> > >>   $ modprobe vdpa-sim-blk
>> >> > >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
>> >> > >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
>> >> > >>   virtio_blk virtio6: [vdb] 262144 512-byte logical blocks (134 MB/128 MiB)
>> >> > >>
>> >> > >> After this patch:
>> >> > >>   $ modprobe vdpa-sim-blk capacity=614400
>> >> > >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
>> >> > >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
>> >> > >>   virtio_blk virtio6: [vdb] 614400 512-byte logical blocks (315 MB/300 MiB)
>> >> > >>
>> >> > >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> >> > >
>> >> > >What a hack. Cindy was working on adding control over config
>> >> > >space, why can't that be used?
>> >> >
>> >> > If it can be used easily with virtio-blk device too, it will be great.
>> >> > @Cindy do you plan to support that changes for a virtio-blk device too?
>> >> >
>> >> Hi Stefano
>> >> I plan to add support to change the vdpa device's configuration after
>> >> it is created.
>> >
>> >I think for Stefano's case, we can just implement it via provisioning
>> >parameters?
>>
>> Yep, I think we don't need to change it after creation, but specifying
>> while creating should be enough.
>>
>> So, IIUC we can already do it, implementing something similar to
>> vdpasim_net_setup_config() to call during vdpasim_blk_dev_add(), right?
>
>Right.
>
>>
>> What about when we have `shared_backend` set to true for the
>> vdpa_sim_blk.ko? In this case the backend is supposed to be shared
>> between all the devices to test live migration.
>
>This seems to be another topic.

Yep, but really related. I think we need to handle that case when 
supporting the `capacity` setting.

>
>>
>> Maybe we can just change the size of the shared ramdisk to be reflected
>> to all devices.
>>
>> Suggestions?
>
>Could we specify the path to tmpfs or others during provisioning
>instead?  It seems more general (but more work).

Then it would almost become a real device, no longer just a simulator.  
It's enough work, though, as you said, but at that point we'd just have 
to specify the backend file to use for the device.

In that case what API would we need to use to allow the user to set the 
backend file?

Thanks,
Stefano


