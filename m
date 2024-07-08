Return-Path: <linux-kernel+bounces-244011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7238E929DD6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904541C2267C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85EF44C93;
	Mon,  8 Jul 2024 08:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDldCTKD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47FC3FBB3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425602; cv=none; b=RBbAJ1z3UuFGiIjuyAOY0zb2xc3sRUBUYru/+9YlxuIMgngPmd3ks0Fc0um4TFDK7eAZ2+Qztp0V4bbtpu6kqvJEiRXMb2T58+Ioug0AgGeT/Se1hfPbah2zJgVaWIGITMD3MT6I6VRcoN/5aIVwPh/QJQ+bPkGthOm2M1WIOTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425602; c=relaxed/simple;
	bh=ypDmDEIJunc+6xP57YDvnppUbdocORL0n8/UmNVySjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bzr9eZ4nhddgIgMDIcnkEwmZU4B5O1txGnpaOD3ceiA67riTRO4qZPjwWH9bROCTpdv6wd56Mg+VuO1plefrraj3wp88tlQGAzo0WLZyAIleAUM+qtA7dbEPqllUfQtb9IQmUdzVQ1YxzgudtSkO/FPuLwEBWg3SSh40BF25IMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDldCTKD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720425599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+jzZKzgZN5yjTgMZLmwwMWyTGMohkBEx3Wj3DoxAjmE=;
	b=bDldCTKDbiml3/LrnELQEt4LNoeCFQFpx00BAQcq4fkBN7o4my+1ZXCgw9tyOl0FgHyba7
	vagqYmZJZox6CUPp8FGYAEJtofEj1o17bYzpaWwuqiwqDxttfAaG6TNrJorQKQqRjCt0UV
	bZvbZO4hj4LisNU179Vd2rbHzb0CBCA=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-uqd8bZAFOcOzXV4pVVpu0g-1; Mon, 08 Jul 2024 03:59:57 -0400
X-MC-Unique: uqd8bZAFOcOzXV4pVVpu0g-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-8101874e9d0so1304389241.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 00:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720425597; x=1721030397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jzZKzgZN5yjTgMZLmwwMWyTGMohkBEx3Wj3DoxAjmE=;
        b=hcgfliwuE75zPx/FYbx5XYVhwDWY2K6Ul/rIvRhmyOh7hEDkXJZF+LT8QAPJGBYCC5
         hO9tZTPFfSWlbsAI3K0LZfmW6IfM9437lNhvcD0ZMFavXw2a34peq1pgPo3zjqelyaO2
         u70zFaEPXeA2p6AHPmdFY2DwluBxeKWBYyuMaZF6CCmiCl6qraSrOcUtKo3MFCRJdExc
         h9vObQAtPl7mMna6f+yQ8BWJr3/jco9jw3ih/sXPgIW18sTSAjRlURWx16Q0HtS+pnwt
         i+2uiyY/X+H6gygMarqvDzTJhI4UvHlsmlm43WkYWIKc3W12l5fDHFPX9QjwhT6hC7tT
         SUFg==
X-Forwarded-Encrypted: i=1; AJvYcCUuAHin+YJe9g6kqwl+rYELpRaPQQgVGnEqD/ehsDswYXbMVcLlO71CRMi2CKWiZ4hA/yyO4T+/jk7GE6gFQaeb4I7dMRkIwQoqrtmJ
X-Gm-Message-State: AOJu0YwvUMRr6RaT4OWnDlol03YnLhUonkxNYht1R82NqFN78cIfevui
	5ZB9rCy8ZBPd8eZtVbqHZZFxgpu1hSBNQa3hCarJ3RICz1jjNF5gveof5XWaOuZy79qNl3OADed
	3v4EIiIrPp+CVRDkZQIXWUb+F6PaFA2P5Ok2qDuYkOYNc/oWv0iEEsRh89CHxkFJpNJ9bKIP1fU
	JBzOQLlKYqfyh8RjGxtJ17097OwX8TxfmQMcDu
X-Received: by 2002:a05:6102:d7:b0:48f:df86:db3 with SMTP id ada2fe7eead31-48fee64f3b0mr11277518137.3.1720425597083;
        Mon, 08 Jul 2024 00:59:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV8fdac+V6whxgl1p91S7RDh/uQhPFnx4tc0vbRT4tU2Zuap5wcKUpOT9KSKXPDq+v4OlMSYZafBNo2LVtRrY=
X-Received: by 2002:a05:6102:d7:b0:48f:df86:db3 with SMTP id
 ada2fe7eead31-48fee64f3b0mr11277502137.3.1720425596652; Mon, 08 Jul 2024
 00:59:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705112821.144819-1-sgarzare@redhat.com> <20240705073017-mutt-send-email-mst@kernel.org>
 <25fehn7xgvqyqgd6zcscsjazzfhktyjrazffyrtbp2oibnhkey@ggobdyv4zxkf> <CACLfguWtcdTM-+GjiXWC-s=d-bvkUedHbCimzsfvYXWJ-=3iDQ@mail.gmail.com>
In-Reply-To: <CACLfguWtcdTM-+GjiXWC-s=d-bvkUedHbCimzsfvYXWJ-=3iDQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 15:59:34 +0800
Message-ID: <CACGkMEurseUpMKaiLpJEkcT9U_tmqm4yqp3OgR--6XnAY=C9WQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_blk: add `capacity` module parameter
To: Cindy Lu <lulu@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 3:06=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Fri, 5 Jul 2024 at 20:42, Stefano Garzarella <sgarzare@redhat.com> wro=
te:
> >
> > On Fri, Jul 05, 2024 at 07:30:51AM GMT, Michael S. Tsirkin wrote:
> > >On Fri, Jul 05, 2024 at 01:28:21PM +0200, Stefano Garzarella wrote:
> > >> The vDPA block simulator always allocated a 128 MiB ram-disk, but so=
me
> > >> filesystems (e.g. XFS) may require larger minimum sizes (see
> > >> https://issues.redhat.com/browse/RHEL-45951).
> > >>
> > >> So to allow us to test these filesystems, let's add a module paramet=
er
> > >> to control the size of the simulated virtio-blk devices.
> > >> The value is mapped directly to the `capacity` field of the virtio-b=
lk
> > >> configuration space, so it must be expressed in sector numbers of 51=
2
> > >> bytes.
> > >>
> > >> The default value (0x40000) is the same as the previous value, so th=
e
> > >> behavior without setting `capacity` remains unchanged.
> > >>
> > >> Before this patch or with this patch without setting `capacity`:
> > >>   $ modprobe vdpa-sim-blk
> > >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
> > >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
> > >>   virtio_blk virtio6: [vdb] 262144 512-byte logical blocks (134 MB/1=
28 MiB)
> > >>
> > >> After this patch:
> > >>   $ modprobe vdpa-sim-blk capacity=3D614400
> > >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
> > >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
> > >>   virtio_blk virtio6: [vdb] 614400 512-byte logical blocks (315 MB/3=
00 MiB)
> > >>
> > >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > >
> > >What a hack. Cindy was working on adding control over config
> > >space, why can't that be used?
> >
> > If it can be used easily with virtio-blk device too, it will be great.
> > @Cindy do you plan to support that changes for a virtio-blk device too?
> >
> Hi Stefano
> I plan to add support to change the vdpa device's configuration after
> it is created.

I think for Stefano's case, we can just implement it via provisioning
parameters?

Thanks

> In the first step, I want to use the vdpa tool to add
> support for changing the MAC address for the network device. the next
> step will also add MTU settings etc
> here is the link
> https://lore.kernel.org/all/20240708064820.88955-1-lulu@redhat.com/T/#t
>
> in the device part, the device needs to implement its function of
> int (*dev_set_attr)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev,
>        const struct vdpa_dev_set_config *config);
> the configuration will be passed by struct vdpa_dev_set_config. I'm
> not sure if this kind of design is suitable for you? Really thanks and
> any comments are welcome
> thanks
> Cindy
>
>
> > In the mean time, for the simulator I thought that this change was fine=
.
> > It's just used for testing and debugging...
> >
> > My main question is how to use that when we have `shared_backend` set t=
o
> > true, since we use that setting to test for example live migration. In
> > that case, how do we handle the size of the shared ramdisk between
> > devices?
> >
> > Thanks,
> > Stefano
> >
>


