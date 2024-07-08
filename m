Return-Path: <linux-kernel+bounces-243940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD4D929CBF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4DF1F210E6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0598B1B974;
	Mon,  8 Jul 2024 07:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVGkMdAs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CEF18641
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720422364; cv=none; b=QMG1Q+Xxiqj3qv+gTeWlwWA9Tabp7AKNqRD/+MKPrc+2vPTUgYDcXIetYZspK9lzM5H7v59WOcVKfyYEoojWUiTD/1GDzXDLNZrEsDMbb+aFuNdDqeqR+IC2pE0vLAJFhv2bDmcv3AZNa0Bk/rIv7JeVEithhdtYtrMDFoDKtmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720422364; c=relaxed/simple;
	bh=5PpxEpUcZXTUsSxmL3KzijXTV7X465dD3PtkiU/Lq6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EoDbWZpLflJbebwJF1Z9quYjxSgjFpVcoMFg+CeN8vldIA8pQ/KgjXYlzOBO2mzy9X9p2ZUkhCa6ntn/JicHVSrOtxOznK0GhZuX9qke/DIzaDBRepNbD07v1ASyIKyc/6hOkkbeKTzllBa/feDHsmtQfB1dm5yjQBBizSXBcv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVGkMdAs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720422361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FUC5EM5aqKsivpFfSa2Ci5nWACyLQ337fx39KNuMZpE=;
	b=AVGkMdAsgBPAhZ/8ajLiGsYeoWJ/9ezmGhkM260fnWh2FYkvh5/H61JVxZIbUuTyGkgVlF
	hqepHPn0XOc4yjdfweKtBioCzPSOR2K0+wJgw3BXgAxZJ21k6mg6Q260fs5JsQut9nipkF
	X9oeYJdTrcUedSnfRgmGfLWMJyHrB68=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-d5ET9UOuOVWepXcxBC9wvg-1; Mon, 08 Jul 2024 03:06:00 -0400
X-MC-Unique: d5ET9UOuOVWepXcxBC9wvg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a77dbdc2cf6so150925666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 00:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720422359; x=1721027159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUC5EM5aqKsivpFfSa2Ci5nWACyLQ337fx39KNuMZpE=;
        b=kHSs2ILAMlQRVokEaL1/SjL977fz3PsabbkRKngFsKy0KpxscndO0KbYyplOMoBvZw
         h0MdQAMQ+WkLsjp1iE/W//vMNZ0r1XdtKeXg3NOoHujrZ8qjSCqQSBquCl5UXTlkJkAm
         EXmW3l+PfhFGto2eigdQ67YiVBaylZszyk/f/PwfIG+3WEuSIow/T6KSSESwxVJ9D0fU
         CeNegNF4TliHbk0KhOw/60+oyXnvlDqt5va9bcttdg9cC7+Q9aSRQFQoUCsYxMin60l4
         xsTf7Czy/3sp6T4eYpXuwqC8JvQMfqkoG9e2ULYRlPuKQC7Y8I1dj3J+y0TBpXXA+MKi
         GqHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXptfi2MRxsbj2SwWCqwFA7m2f/RnSoE5FP540DteJO+a2tSo3b2nh0Qwk3p/H/Zz91Z90wELvUlcCOnKBNxlWwIEHs5pymz0B0pos6
X-Gm-Message-State: AOJu0YzEsK0iFY+fkzZ1gIEkJQBxLx3BPwIgaOAdAqT+zROo+ZeemSco
	VrdM1rMqYoghCwplHeoffiseK+GPe2Gk2teeaJPQJTXlUY/UPPQzL87QvtJe2tyEJN8WfZbijct
	PMEM8brqXG/xjsbQv8TbhARGEylZox29WcGoDILkwsVQg2ov5QsscZdbyW4+8Qkl2oKoJSXV3Na
	7CqhqPixxn6Z154X+WIB75HP7uHTDv0WQ3Yecq
X-Received: by 2002:a17:906:b11:b0:a77:db36:1ccc with SMTP id a640c23a62f3a-a77db361dbcmr512997466b.24.1720422358885;
        Mon, 08 Jul 2024 00:05:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJS0DZEsXtrYoLqrPVKVwR9KH5Yv072isEfrtxy78mylm1aqwAVich5MZPYa4GI87sCbQHEPN3vwbfGH+5sWU=
X-Received: by 2002:a17:906:b11:b0:a77:db36:1ccc with SMTP id
 a640c23a62f3a-a77db361dbcmr512995966b.24.1720422358470; Mon, 08 Jul 2024
 00:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705112821.144819-1-sgarzare@redhat.com> <20240705073017-mutt-send-email-mst@kernel.org>
 <25fehn7xgvqyqgd6zcscsjazzfhktyjrazffyrtbp2oibnhkey@ggobdyv4zxkf>
In-Reply-To: <25fehn7xgvqyqgd6zcscsjazzfhktyjrazffyrtbp2oibnhkey@ggobdyv4zxkf>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 8 Jul 2024 15:05:21 +0800
Message-ID: <CACLfguWtcdTM-+GjiXWC-s=d-bvkUedHbCimzsfvYXWJ-=3iDQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_blk: add `capacity` module parameter
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jul 2024 at 20:42, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Fri, Jul 05, 2024 at 07:30:51AM GMT, Michael S. Tsirkin wrote:
> >On Fri, Jul 05, 2024 at 01:28:21PM +0200, Stefano Garzarella wrote:
> >> The vDPA block simulator always allocated a 128 MiB ram-disk, but some
> >> filesystems (e.g. XFS) may require larger minimum sizes (see
> >> https://issues.redhat.com/browse/RHEL-45951).
> >>
> >> So to allow us to test these filesystems, let's add a module parameter
> >> to control the size of the simulated virtio-blk devices.
> >> The value is mapped directly to the `capacity` field of the virtio-blk
> >> configuration space, so it must be expressed in sector numbers of 512
> >> bytes.
> >>
> >> The default value (0x40000) is the same as the previous value, so the
> >> behavior without setting `capacity` remains unchanged.
> >>
> >> Before this patch or with this patch without setting `capacity`:
> >>   $ modprobe vdpa-sim-blk
> >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
> >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
> >>   virtio_blk virtio6: [vdb] 262144 512-byte logical blocks (134 MB/128 MiB)
> >>
> >> After this patch:
> >>   $ modprobe vdpa-sim-blk capacity=614400
> >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
> >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
> >>   virtio_blk virtio6: [vdb] 614400 512-byte logical blocks (315 MB/300 MiB)
> >>
> >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >
> >What a hack. Cindy was working on adding control over config
> >space, why can't that be used?
>
> If it can be used easily with virtio-blk device too, it will be great.
> @Cindy do you plan to support that changes for a virtio-blk device too?
>
Hi Stefano
I plan to add support to change the vdpa device's configuration after
it is created. In the first step, I want to use the vdpa tool to add
support for changing the MAC address for the network device. the next
step will also add MTU settings etc
here is the link
https://lore.kernel.org/all/20240708064820.88955-1-lulu@redhat.com/T/#t

in the device part, the device needs to implement its function of
int (*dev_set_attr)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev,
       const struct vdpa_dev_set_config *config);
the configuration will be passed by struct vdpa_dev_set_config. I'm
not sure if this kind of design is suitable for you? Really thanks and
any comments are welcome
thanks
Cindy


> In the mean time, for the simulator I thought that this change was fine.
> It's just used for testing and debugging...
>
> My main question is how to use that when we have `shared_backend` set to
> true, since we use that setting to test for example live migration. In
> that case, how do we handle the size of the shared ramdisk between
> devices?
>
> Thanks,
> Stefano
>


