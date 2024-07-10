Return-Path: <linux-kernel+bounces-247159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E325092CBFF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1FCD1C2142A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C62B83CC8;
	Wed, 10 Jul 2024 07:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hbfg1dV1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9052256458
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720596979; cv=none; b=RSnXL9aJEenCd/PNPcDN7LdDA2X7bZ1LR9jFlIbZtbazIVe0Bgh8ZC8N6nM/nJ5L/TbF2U13EoGCrG/txPRzZxo6+tkTrDPZeOxRR5ljoLB+e73vGTLLukIatwySdlzjaja/rA9FR0QRN3DOsNpX/0BILNpCF2VVZrBHFLSiR/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720596979; c=relaxed/simple;
	bh=ypCiQZ5LiSf6F/LFDVthOPs/ZIZKQgMixvoXswJzNSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A16AibhPAFOnaOgOD6VZCjawNtQKieoLItJNBkBHNKRB+MvEhhYvEehva2BYupOIyVkAMt0q39u37t1QaEstUrFa8tesyo0DvkOK7L8rcck7GvOvygGEPjsLPJZS5AU6PbP7VcHP3mo/LGLTqoyCNXRTTxxJRDcGSY5q58SzAcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hbfg1dV1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720596976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QeA/kvWu6TfORz7jlmkdHb39oyyESvSr8E9IPmMJ0bQ=;
	b=Hbfg1dV1j0av7JqpK912HNqVgy4NhCCGG6ChhWrCqnfZEhsfZj9CNpVrbxg9m0AdCuhMlm
	z1nkyDv5/XaOwvqnHjLQp5rsNwDXjvwBDAMZjhlLfCmSlGHnt1eBMerOyhAoCSKB1qhWFf
	oRHTI7F1lvr1B3scBbhMRVCY1zh9kOc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-4WO-nKfGOqGgEV0bfMW4Uw-1; Wed, 10 Jul 2024 03:36:15 -0400
X-MC-Unique: 4WO-nKfGOqGgEV0bfMW4Uw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-58c38bcd765so5027571a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 00:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720596974; x=1721201774;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QeA/kvWu6TfORz7jlmkdHb39oyyESvSr8E9IPmMJ0bQ=;
        b=ODmFc6NnNchhS0PUMQPk7tcDQNIVehiGrgVCep/zxFB7Rca36iHljo6aERyYClgMoL
         OToyMNG2JwKs2/GkqDVGGmbcCVEtVHcwmnSq85BhE/cccNb4xFEaLY8BGyjjFqXb2d3W
         St74U4aUSBhLedLxs+xDjvEeiqNiVyh/nMruvQsN3JURltauOQKnJS47YGGnFqLQ7NEz
         DyjY1/WEzqJ2mRoDxwDjZg9A9s9WXeMRsfyz4gxN/xhr5XLgu+/ti7OSXhrOPmnlLLoJ
         V2Ejv2+121PGNVaZ/rogzwk2oZfovwiAy430HvPzfq/LgBA6zUE0vvf1LknYxQZ2Dv0l
         mcdA==
X-Forwarded-Encrypted: i=1; AJvYcCVjhn/TRQWAK/Ln2BXSiVsXThqsPJ2cJiU12Zbl53/18o/1zIl8ZaxDCdpBrGPJFwLrcayLte1joC1Vjclz437but2nAu7c28rCJwAt
X-Gm-Message-State: AOJu0Yxtz8vcS4TGg0rxyuHswnsGlB/2TL/Tx+9GM/FeGipU/ESOrncs
	zosoZx4eyi9x1ioi7AtudyxjIeuo0ghX5TIX8ykCRIqVA0+2PsFjNnzwr1C1YtmpAqolyamK1Pe
	iwQwF0A72qhdRIZEC4fR8zNUn7vSqst7SjGLg1eSbymf9OvM3BiEiRYG1VYFijA==
X-Received: by 2002:a50:ef01:0:b0:58b:a92f:2901 with SMTP id 4fb4d7f45d1cf-594baf9181amr2787035a12.17.1720596973984;
        Wed, 10 Jul 2024 00:36:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEq4mcv5ImfV81gELKPAKswXbQv/aNZBA8ebzt8qdGfoCUhgUIB+WbQG8AkfuGyFpKA1cyBQ==
X-Received: by 2002:a50:ef01:0:b0:58b:a92f:2901 with SMTP id 4fb4d7f45d1cf-594baf9181amr2787018a12.17.1720596973228;
        Wed, 10 Jul 2024 00:36:13 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-153.retail.telecomitalia.it. [82.57.51.153])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bc7c8ad4sm1920187a12.56.2024.07.10.00.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 00:36:12 -0700 (PDT)
Date: Wed, 10 Jul 2024 09:36:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH] vdpa_sim_blk: add `capacity` module parameter
Message-ID: <glbjelgjjsebultcvx6hbywo6dz43dxnbnvydlaxgaohwovng4@7plje3qmqvdi>
References: <20240705073017-mutt-send-email-mst@kernel.org>
 <25fehn7xgvqyqgd6zcscsjazzfhktyjrazffyrtbp2oibnhkey@ggobdyv4zxkf>
 <CACLfguWtcdTM-+GjiXWC-s=d-bvkUedHbCimzsfvYXWJ-=3iDQ@mail.gmail.com>
 <CACGkMEurseUpMKaiLpJEkcT9U_tmqm4yqp3OgR--6XnAY=C9WQ@mail.gmail.com>
 <3f5d33l4c73nudppajvhnjhpdpvft5yolm7vdraikany2tfdjz@i62d45j4ucs5>
 <CACGkMEuqiAx-a0sPJf0Xpvmr=5wbzbuOr0-w+9ZcwQMTWFU1rw@mail.gmail.com>
 <xuruyrbkago7w7tjbvqmfvjoqy665srurqozbenfayagfxl72y@wqy56jenfo2u>
 <CACGkMEtB1maGywWRPNHgVGJog+rbowXvKG0nEDXPn_9-VB0Azw@mail.gmail.com>
 <emhlvvttkq5yqcbphdkyrcmcxpyk22uxe2eiohmrapmjrv4vsz@zbiixmblizcj>
 <CACGkMEtT-UeLk6Hv1AFXk_yhiVxx-5tWknqs=OYg8+cAGDmd9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtT-UeLk6Hv1AFXk_yhiVxx-5tWknqs=OYg8+cAGDmd9w@mail.gmail.com>

On Wed, Jul 10, 2024 at 03:28:31PM GMT, Jason Wang wrote:
>On Wed, Jul 10, 2024 at 3:19 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Wed, Jul 10, 2024 at 11:08:48AM GMT, Jason Wang wrote:
>> >On Tue, Jul 9, 2024 at 8:41 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >>
>> >> On Tue, Jul 09, 2024 at 10:56:16AM GMT, Jason Wang wrote:
>> >> >On Mon, Jul 8, 2024 at 4:15 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >> >>
>> >> >> Hi Cindy, Jason,
>> >> >>
>> >> >> On Mon, Jul 08, 2024 at 03:59:34PM GMT, Jason Wang wrote:
>> >> >> >On Mon, Jul 8, 2024 at 3:06 PM Cindy Lu <lulu@redhat.com> wrote:
>> >> >> >>
>> >> >> >> On Fri, 5 Jul 2024 at 20:42, Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >> >> >> >
>> >> >> >> > On Fri, Jul 05, 2024 at 07:30:51AM GMT, Michael S. Tsirkin wrote:
>> >> >> >> > >On Fri, Jul 05, 2024 at 01:28:21PM +0200, Stefano Garzarella wrote:
>> >> >> >> > >> The vDPA block simulator always allocated a 128 MiB ram-disk, but some
>> >> >> >> > >> filesystems (e.g. XFS) may require larger minimum sizes (see
>> >> >> >> > >> https://issues.redhat.com/browse/RHEL-45951).
>> >> >> >> > >>
>> >> >> >> > >> So to allow us to test these filesystems, let's add a module parameter
>> >> >> >> > >> to control the size of the simulated virtio-blk devices.
>> >> >> >> > >> The value is mapped directly to the `capacity` field of the virtio-blk
>> >> >> >> > >> configuration space, so it must be expressed in sector numbers of 512
>> >> >> >> > >> bytes.
>> >> >> >> > >>
>> >> >> >> > >> The default value (0x40000) is the same as the previous value, so the
>> >> >> >> > >> behavior without setting `capacity` remains unchanged.
>> >> >> >> > >>
>> >> >> >> > >> Before this patch or with this patch without setting `capacity`:
>> >> >> >> > >>   $ modprobe vdpa-sim-blk
>> >> >> >> > >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
>> >> >> >> > >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
>> >> >> >> > >>   virtio_blk virtio6: [vdb] 262144 512-byte logical blocks (134 MB/128 MiB)
>> >> >> >> > >>
>> >> >> >> > >> After this patch:
>> >> >> >> > >>   $ modprobe vdpa-sim-blk capacity=614400
>> >> >> >> > >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
>> >> >> >> > >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
>> >> >> >> > >>   virtio_blk virtio6: [vdb] 614400 512-byte logical blocks (315 MB/300 MiB)
>> >> >> >> > >>
>> >> >> >> > >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> >> >> >> > >
>> >> >> >> > >What a hack. Cindy was working on adding control over config
>> >> >> >> > >space, why can't that be used?
>> >> >> >> >
>> >> >> >> > If it can be used easily with virtio-blk device too, it will be great.
>> >> >> >> > @Cindy do you plan to support that changes for a virtio-blk device too?
>> >> >> >> >
>> >> >> >> Hi Stefano
>> >> >> >> I plan to add support to change the vdpa device's configuration after
>> >> >> >> it is created.
>> >> >> >
>> >> >> >I think for Stefano's case, we can just implement it via provisioning
>> >> >> >parameters?
>> >> >>
>> >> >> Yep, I think we don't need to change it after creation, but specifying
>> >> >> while creating should be enough.
>> >> >>
>> >> >> So, IIUC we can already do it, implementing something similar to
>> >> >> vdpasim_net_setup_config() to call during vdpasim_blk_dev_add(), right?
>> >> >
>> >> >Right.
>> >> >
>> >> >>
>> >> >> What about when we have `shared_backend` set to true for the
>> >> >> vdpa_sim_blk.ko? In this case the backend is supposed to be shared
>> >> >> between all the devices to test live migration.
>> >> >
>> >> >This seems to be another topic.
>> >>
>> >> Yep, but really related. I think we need to handle that case when
>> >> supporting the `capacity` setting.
>> >
>> >Ok, so if I was not wrong, the goal is to test migration.
>>
>> Sorry, I was not clear, I try to rephrase:
>> vdpa_sim_blk already supports a module parameter called `shared_backend`
>> introduced mainly to test live migration on the same host. When that
>> parameter is on, all the created devices share the same backend and so
>> we can easily do migration from one to another.
>>
>> With that parameter on or off, the device is always 128 MB, but now
>> that's a problem for testing, because it looks like XFS requires at
>> least 300 MB: https://issues.redhat.com/browse/RHEL-45951
>>
>> That's why I sent this patch.
>>
>> When `shared_backend` is off (default), using the provisioning
>> parameters seems feasible to me, but when it's on, how do I deal with
>> it?
>>
>> Being a simulator, we can maybe make it so that only the first device
>> can change the size for example, or that all devices control the size,
>> but then we would have to handle the size change at runtime, which I
>> think is feasible, but it requires some work to send a notification of
>> configuration change, etc.
>
>Can we mandate the size parameter to be exactly the same as the first
>vDPA block simulator?
>
>>
>> >
>> >>
>> >> >
>> >> >>
>> >> >> Maybe we can just change the size of the shared ramdisk to be reflected
>> >> >> to all devices.
>> >> >>
>> >> >> Suggestions?
>> >> >
>> >> >Could we specify the path to tmpfs or others during provisioning
>> >> >instead?  It seems more general (but more work).
>> >>
>> >> Then it would almost become a real device, no longer just a simulator.
>> >> It's enough work, though, as you said, but at that point we'd just have
>> >> to specify the backend file to use for the device.
>> >>
>> >> In that case what API would we need to use to allow the user to set the
>> >> backend file?
>> >
>> >Yes, I think we can allow some vendor specific provisioning parameters.
>> >
>> >But not sure it's an overkill for the use case here. If others are
>> >happy with the shared_backed. I'm fine.
>>
>> Yeah, maybe it's overkill and I don't have much time these days :-(
>>
>> I think the easiest way is to merge this patch, but I understand that a
>> module parameter is not very beautiful
>>
>> I'll try to see if I can implement provisioning parameters for
>> vdpa_sim_blk. Allowing capacity to be set only to the first device if
>> `shared_backend` is on.
>>
>> WDYT?
>
>Something like this.
>
>When there's no block simulator, allow an arbitrary capacity. When
>there is one, fail the creation when the capacity doesn't match. (when
>'shared_backend' is on).

Yeah, makes sense to me! I'll do it!

Thanks for the help,
Stefano


