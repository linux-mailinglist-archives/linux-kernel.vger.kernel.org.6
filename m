Return-Path: <linux-kernel+bounces-245225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCEA92AFF5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475901F224F5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C3513A400;
	Tue,  9 Jul 2024 06:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqLnVXD4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52029823A9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 06:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720506002; cv=none; b=BAdlRmNOWuyLtgDrtpFqB3KpqMq8QtKbH5fpSBBqkQhm9pC0nBL6XZqdkOFyaHyl43K6CeCv5ee2RU4iqGQVL5Lbv/ggEdq7/U/YCvOijivm3i0jDwhdD5iQC2TFRAzXJIDHDttCFsXmtgOJ59gMMZqYPi8IzNJQRjIMrSAi/ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720506002; c=relaxed/simple;
	bh=IgIMapnYz4R7QhXStj3YA8Z3MkB+898jyfEDj8yV1IA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sv7Gb5nJ+ZInmOCdB0j1ZLuaMc7IVlZdI+MjUlZykLIUNxY8ucU7/I6SrFRJmqcMjq5zcM90kzBK55ZanK44KbICTTqdUipJP9DqHdKHYtsmKvG+5CwNexh3cof9UORXQTajtCimMoCrdqDBhMbn8LkfhOnGNJlzZifUiWUoMIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aqLnVXD4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720505999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6PAJ3NQZoDsxViJ6hO5lgvZht1GTrzFNq+ksySjJ6SY=;
	b=aqLnVXD4xHO/2RywEWtUF13x2bjPkBmcFqiJ+uFiiVKSFx74OmXdfOWcFp081h5TLTo0ny
	HU4TdwLdY6rq229+hvLaI5DOcHRYljKvm/h7D/3JGUrfMaR9KE4IWwUYlzhNzak5E/2MLD
	cnR08f+Hjtk/uat9a8dsLAkm5Zwi58k=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-JUCad89NMTSjmOxR2KMVxA-1; Tue, 09 Jul 2024 02:19:57 -0400
X-MC-Unique: JUCad89NMTSjmOxR2KMVxA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-57d3eca4bb7so6543018a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 23:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720505996; x=1721110796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6PAJ3NQZoDsxViJ6hO5lgvZht1GTrzFNq+ksySjJ6SY=;
        b=YB2RLueKGxNt8QG31H9QQzqChc0f7C3OAAAh+e8loutpfRklNxaGuS8ChAD4rNFptS
         fZBgj3qnRs6AsK0knu4yeQDGD09IKEChgfWEsX8nKRmwa6th9meMBLy+mIn9PiS3zuWz
         doYjjbwae1W6mhOQBlDpMTWhIYZXsPogCsCzKhtXpAQXgKk/YXE62o0A3MIk2k3M8rR3
         6Gm06lQZSD/YBvu3GVKlJCR83vlss5LRyVTMkpzufoWlzZdZCLq8OcM5l/5q68QMOfee
         GRstzpZL9XPUX5mo0T0WL9I9A1u5U2hbjHRwPf4PwElhDEvMFUFXNm19ckb+HqqcbStm
         /Qpw==
X-Forwarded-Encrypted: i=1; AJvYcCUukHtd/nX+qr+K6o9cY31DiH4xyoDps62X+3dF0RTGXJvooY+htCXOM7/4j9Ca3ZGx2opb4ecbmRdujIDqfoJnEscZQcHgJ082weXY
X-Gm-Message-State: AOJu0YwCWwswweDwM15LueJ0b9RZtKK2WhphOI3gNdPNIZ2rFp3sp9ck
	2IBidsTTBl8vjYx4aI4YnVf6og2J4rmTc1nqTwy62vy3bJU2QCQ0hgei3QM6cHxpBd7u+zQKlzb
	TKE/rJJ+uTuQ988QTaCEfH5/RMkrk73AleSPdyxxPhHEnGWk6nnrcSTXpeAbzxb+qID10EjYx3L
	BywhoEOyn6RZbYlrcJpQWYEltHqhUzkf252jnG
X-Received: by 2002:a05:6402:4309:b0:58c:77b4:404b with SMTP id 4fb4d7f45d1cf-594dd34aa4dmr1068300a12.15.1720505996524;
        Mon, 08 Jul 2024 23:19:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ9cScRO5pziPV+dYduWA5rh756OgcUnuUTG7kK7SZbXCFXGzo6HuFDwa6LNFne0lhqbLXSFEqskdyCJsHCbg=
X-Received: by 2002:a05:6402:4309:b0:58c:77b4:404b with SMTP id
 4fb4d7f45d1cf-594dd34aa4dmr1068284a12.15.1720505996168; Mon, 08 Jul 2024
 23:19:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708064820.88955-1-lulu@redhat.com> <PH0PR12MB5481AE2FD52AEE1C10411F3DDCDB2@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481AE2FD52AEE1C10411F3DDCDB2@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 9 Jul 2024 14:19:19 +0800
Message-ID: <CACLfguXk4qiw4efRGK4Gw8OZQ_PKw6j+GVQJCVtbyJ+hxOoE0Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] vdpa: support set mac address from vdpa tool
To: Parav Pandit <parav@nvidia.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "mst@redhat.com" <mst@redhat.com>, 
	"jasowang@redhat.com" <jasowang@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jul 2024 at 11:59, Parav Pandit <parav@nvidia.com> wrote:
>
> Hi Cindy,
>
> > From: Cindy Lu <lulu@redhat.com>
> > Sent: Monday, July 8, 2024 12:17 PM
> >
> > Add support for setting the MAC address using the VDPA tool.
> > This feature will allow setting the MAC address using the VDPA tool.
> > For example, in vdpa_sim_net, the implementation sets the MAC address to
> > the config space. However, for other drivers, they can implement their own
> > function, not limited to the config space.
> >
> > Changelog v2
> >  - Changed the function name to prevent misunderstanding
> >  - Added check for blk device
> >  - Addressed the comments
> > Changelog v3
> >  - Split the function of the net device from vdpa_nl_cmd_dev_attr_set_doit
> >  - Add a lock for the network device's dev_set_attr operation
> >  - Address the comments
> >
> > Cindy Lu (2):
> >   vdpa: support set mac address from vdpa tool
> >   vdpa_sim_net: Add the support of set mac address
> >
> >  drivers/vdpa/vdpa.c                  | 81 ++++++++++++++++++++++++++++
> >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 19 ++++++-
> >  include/linux/vdpa.h                 |  9 ++++
> >  include/uapi/linux/vdpa.h            |  1 +
> >  4 files changed, 109 insertions(+), 1 deletion(-)
> >
> > --
> > 2.45.0
>
> Mlx5 device already allows setting the mac and mtu during the vdpa device creation time.
> Once the vdpa device is created, it binds to vdpa bus and other driver vhost_vdpa etc bind to it.
> So there was no good reason in the past to support explicit config after device add complicate the flow for synchronizing this.
>
> The user who wants a device with new attributes, as well destroy and recreate the vdpa device with new desired attributes.
>
> vdpa_sim_net can also be extended for similar way when adding the vdpa device.
>
> Have you considered using the existing tool and kernel in place since 2021?
> Such as commit d8ca2fa5be1.
>
> An example of it is,
> $ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:55 mtu 9000
>
Hi Parav
Really thanks for your comments. The reason for adding this function
is to support Kubevirt.
the problem we meet is that kubevirt chooses one random vdpa device
from the pool and we don't know which one it going to pick. That means
we can't get to know the Mac address before it is created. So we plan
to have this function to change the mac address after it is created
Thanks
cindy


