Return-Path: <linux-kernel+bounces-247145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C7592CBDA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578F1280C2D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF8A82D70;
	Wed, 10 Jul 2024 07:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHdfOBj6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725118249A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720595949; cv=none; b=cYJSLgnSH2XiZ2oNDpp+ridAVGRwzcpY6uqUWjBBpW9dLZyn9s9mEgyDxDnFEHa7KlBtnzV3XNlPemksLCo83dhwSl2eq645QlZhpeZuxexIAaMf+0TY7orYRsFn8TqxN6Any0bNeBDr60BRoDWsMat+aRtVfLghc4dF3t+iLCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720595949; c=relaxed/simple;
	bh=d5SmteKdijXNKNXepTPp/qqswuos8L86pRIxVWE0EuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9Ma2R9fjKMsVtYPMRNmJd5gTAPwIZJZ2mv7HZnTVsnd/0Bo5X3M+VAQ46bkxOq/VdLyFseR6wU+GiGVhLB2Sta8EBkhdUveKp1iGidh3tBNHEzBKrlE9L1HA6Qxvtmh27dnWsszVAfJgIIJ7ZQT1dUl869owj/C7fL6ztM4rT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dHdfOBj6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720595946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwB3FghmzewQWwlaMcX6DM12u56ZQGZiY3dsETV7srI=;
	b=dHdfOBj6SGdd6hpVN+xZtxpVzRmxCFrwtSTCyVxsTx8c96SOdlqYW360Xjg5MTt6/Sdgtc
	JxgU59luwqjKzpQHbHXi2TjnT93xDZJDy2kbaXT5TP1FOTzixgyi+h4V4YXWfmi/RojU8F
	WleI0orshtmqL8g86jlMonvfhfQUzGk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-N5B3m-SoPJ2HO_FR5h_E6Q-1; Wed, 10 Jul 2024 03:19:04 -0400
X-MC-Unique: N5B3m-SoPJ2HO_FR5h_E6Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a77b2edfe06so495083466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 00:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720595943; x=1721200743;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XwB3FghmzewQWwlaMcX6DM12u56ZQGZiY3dsETV7srI=;
        b=WtczhvIw8/0IbOv2TFaCrVx4SJDo7s1f8aATZTUULRupObIdfvWAHst6JFjiPxafkv
         xsMdOguLbYIEQSX92EXBfSxX9Z7v3H61dyh5/AeGA+Q9hOegixB54V9nmUKvt2PhSPJ5
         Bll8Lox4tyu4ssloQ+Kg0Gdtpb1mDkxlO+h3eNjDEcdz8EeleiU5EixLscoFzlgmEx5U
         sCO3911VkzlYjObS3Pw2MPtt9iFxyuww1tEihmbdgelxjyLffpJGpK5mTzKvfp5seWyU
         JNozTE2FaNVnEDNUIT1rGvT1NDjAtyOuWlbYFhwuw7vDqqGrPgbk4/FuN7dbiFxyugxz
         YzPw==
X-Forwarded-Encrypted: i=1; AJvYcCV6TAyemryQpLR454kVv3KDzHzMDVE7OsuxwWcqqqR4gEPKlolULiQgILLRaq1MuPGWh2yCwEehJlJoQXsRF3QxY3kVGKie6PWQD04p
X-Gm-Message-State: AOJu0YxfwTOiiw4kmbQW8HHACbowseV2LqMGYRk230ZfOWgMMNX1dGy/
	sqSwY/MOgwuxHGzKu+nMGFPNYDEB1WePR9VnbSr3hS9VWhtDUJoMmjdyWrEH6CTkT+4WNaopP6c
	Qkn4a7w4BQKVKlSZMn7kGcNNmEqNearGH3/d0gZtx1AsR5lj0ygCgNS1KVWp4mQ==
X-Received: by 2002:a17:906:b319:b0:a72:676a:7d7b with SMTP id a640c23a62f3a-a780b688906mr377457366b.9.1720595943196;
        Wed, 10 Jul 2024 00:19:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaYbj6AlwOsRGMJSHv+OMYoFX90NzF2RHNNM6mqpAN440N/+mypYGNwX8+Or/DJS0szrPulQ==
X-Received: by 2002:a17:906:b319:b0:a72:676a:7d7b with SMTP id a640c23a62f3a-a780b688906mr377453766b.9.1720595942504;
        Wed, 10 Jul 2024 00:19:02 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-153.retail.telecomitalia.it. [82.57.51.153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a856075sm135910566b.184.2024.07.10.00.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 00:19:01 -0700 (PDT)
Date: Wed, 10 Jul 2024 09:18:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH] vdpa_sim_blk: add `capacity` module parameter
Message-ID: <emhlvvttkq5yqcbphdkyrcmcxpyk22uxe2eiohmrapmjrv4vsz@zbiixmblizcj>
References: <20240705112821.144819-1-sgarzare@redhat.com>
 <20240705073017-mutt-send-email-mst@kernel.org>
 <25fehn7xgvqyqgd6zcscsjazzfhktyjrazffyrtbp2oibnhkey@ggobdyv4zxkf>
 <CACLfguWtcdTM-+GjiXWC-s=d-bvkUedHbCimzsfvYXWJ-=3iDQ@mail.gmail.com>
 <CACGkMEurseUpMKaiLpJEkcT9U_tmqm4yqp3OgR--6XnAY=C9WQ@mail.gmail.com>
 <3f5d33l4c73nudppajvhnjhpdpvft5yolm7vdraikany2tfdjz@i62d45j4ucs5>
 <CACGkMEuqiAx-a0sPJf0Xpvmr=5wbzbuOr0-w+9ZcwQMTWFU1rw@mail.gmail.com>
 <xuruyrbkago7w7tjbvqmfvjoqy665srurqozbenfayagfxl72y@wqy56jenfo2u>
 <CACGkMEtB1maGywWRPNHgVGJog+rbowXvKG0nEDXPn_9-VB0Azw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtB1maGywWRPNHgVGJog+rbowXvKG0nEDXPn_9-VB0Azw@mail.gmail.com>

On Wed, Jul 10, 2024 at 11:08:48AM GMT, Jason Wang wrote:
>On Tue, Jul 9, 2024 at 8:41 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Tue, Jul 09, 2024 at 10:56:16AM GMT, Jason Wang wrote:
>> >On Mon, Jul 8, 2024 at 4:15 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >>
>> >> Hi Cindy, Jason,
>> >>
>> >> On Mon, Jul 08, 2024 at 03:59:34PM GMT, Jason Wang wrote:
>> >> >On Mon, Jul 8, 2024 at 3:06 PM Cindy Lu <lulu@redhat.com> wrote:
>> >> >>
>> >> >> On Fri, 5 Jul 2024 at 20:42, Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >> >> >
>> >> >> > On Fri, Jul 05, 2024 at 07:30:51AM GMT, Michael S. Tsirkin wrote:
>> >> >> > >On Fri, Jul 05, 2024 at 01:28:21PM +0200, Stefano Garzarella wrote:
>> >> >> > >> The vDPA block simulator always allocated a 128 MiB ram-disk, but some
>> >> >> > >> filesystems (e.g. XFS) may require larger minimum sizes (see
>> >> >> > >> https://issues.redhat.com/browse/RHEL-45951).
>> >> >> > >>
>> >> >> > >> So to allow us to test these filesystems, let's add a module parameter
>> >> >> > >> to control the size of the simulated virtio-blk devices.
>> >> >> > >> The value is mapped directly to the `capacity` field of the virtio-blk
>> >> >> > >> configuration space, so it must be expressed in sector numbers of 512
>> >> >> > >> bytes.
>> >> >> > >>
>> >> >> > >> The default value (0x40000) is the same as the previous value, so the
>> >> >> > >> behavior without setting `capacity` remains unchanged.
>> >> >> > >>
>> >> >> > >> Before this patch or with this patch without setting `capacity`:
>> >> >> > >>   $ modprobe vdpa-sim-blk
>> >> >> > >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
>> >> >> > >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
>> >> >> > >>   virtio_blk virtio6: [vdb] 262144 512-byte logical blocks (134 MB/128 MiB)
>> >> >> > >>
>> >> >> > >> After this patch:
>> >> >> > >>   $ modprobe vdpa-sim-blk capacity=614400
>> >> >> > >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
>> >> >> > >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
>> >> >> > >>   virtio_blk virtio6: [vdb] 614400 512-byte logical blocks (315 MB/300 MiB)
>> >> >> > >>
>> >> >> > >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> >> >> > >
>> >> >> > >What a hack. Cindy was working on adding control over config
>> >> >> > >space, why can't that be used?
>> >> >> >
>> >> >> > If it can be used easily with virtio-blk device too, it will be great.
>> >> >> > @Cindy do you plan to support that changes for a virtio-blk device too?
>> >> >> >
>> >> >> Hi Stefano
>> >> >> I plan to add support to change the vdpa device's configuration after
>> >> >> it is created.
>> >> >
>> >> >I think for Stefano's case, we can just implement it via provisioning
>> >> >parameters?
>> >>
>> >> Yep, I think we don't need to change it after creation, but specifying
>> >> while creating should be enough.
>> >>
>> >> So, IIUC we can already do it, implementing something similar to
>> >> vdpasim_net_setup_config() to call during vdpasim_blk_dev_add(), right?
>> >
>> >Right.
>> >
>> >>
>> >> What about when we have `shared_backend` set to true for the
>> >> vdpa_sim_blk.ko? In this case the backend is supposed to be shared
>> >> between all the devices to test live migration.
>> >
>> >This seems to be another topic.
>>
>> Yep, but really related. I think we need to handle that case when
>> supporting the `capacity` setting.
>
>Ok, so if I was not wrong, the goal is to test migration.

Sorry, I was not clear, I try to rephrase:
vdpa_sim_blk already supports a module parameter called `shared_backend` 
introduced mainly to test live migration on the same host. When that 
parameter is on, all the created devices share the same backend and so 
we can easily do migration from one to another.

With that parameter on or off, the device is always 128 MB, but now 
that's a problem for testing, because it looks like XFS requires at 
least 300 MB: https://issues.redhat.com/browse/RHEL-45951

That's why I sent this patch.

When `shared_backend` is off (default), using the provisioning 
parameters seems feasible to me, but when it's on, how do I deal with 
it?

Being a simulator, we can maybe make it so that only the first device 
can change the size for example, or that all devices control the size, 
but then we would have to handle the size change at runtime, which I 
think is feasible, but it requires some work to send a notification of 
configuration change, etc.

>
>>
>> >
>> >>
>> >> Maybe we can just change the size of the shared ramdisk to be reflected
>> >> to all devices.
>> >>
>> >> Suggestions?
>> >
>> >Could we specify the path to tmpfs or others during provisioning
>> >instead?  It seems more general (but more work).
>>
>> Then it would almost become a real device, no longer just a simulator.
>> It's enough work, though, as you said, but at that point we'd just have
>> to specify the backend file to use for the device.
>>
>> In that case what API would we need to use to allow the user to set the
>> backend file?
>
>Yes, I think we can allow some vendor specific provisioning parameters.
>
>But not sure it's an overkill for the use case here. If others are
>happy with the shared_backed. I'm fine.

Yeah, maybe it's overkill and I don't have much time these days :-(

I think the easiest way is to merge this patch, but I understand that a 
module parameter is not very beautiful.

I'll try to see if I can implement provisioning parameters for 
vdpa_sim_blk. Allowing capacity to be set only to the first device if 
`shared_backend` is on.

WDYT?

Thanks,
Stefano


