Return-Path: <linux-kernel+bounces-365523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6804099E3A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7432846BA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4401E2841;
	Tue, 15 Oct 2024 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RL1iabjE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778301DAC89
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728987574; cv=none; b=eqZRRsbQPqki9XPduRhUUBRXkfUEhVh2UwTVf1ZIvBno6tq7M0fPsRsQlwNTKQw8tHhMPzc6+MxOWi1n03USyq6GdCKacmkBeQUXRSV3/TQwnKN8CNrC9NyWxQZcN2BPzdh9r2sJRZM2Bf8mxWDlUlGDPxuuhxCa4r94heR4jeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728987574; c=relaxed/simple;
	bh=UtNejxWTGys9rDt1pROLsuGxzh/JYXHbYWC1bkRqFBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CapuHK0sR3zoBTc5vNgU57U13zwv2nVO6CFG+qFugu9hdwQFi8tRvzk+lOIYSufQY97ByK9wiilScZKK0YfeNPAd446NQqSKac5hNXUVJM4wMXaAUISh89oTq9au7CsXlM85y/xD3N99xrpMzlilkJriiZ76xmoJqNSM5Diw5og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RL1iabjE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728987571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yL03YOPM9cVhg3T+Qftkg8/CQZZbBVIoxOh8LNZ0CNY=;
	b=RL1iabjEWGsviJh/lgJeoOeS14UYFfl4t3zPM7yHqF7jRcVMbpnFldn0rc4y/zFL3wiuA9
	S6+tkNjlUH3iVsdIy16E6McSa7dtCG60Ebz2PSaJ0FZEJYEs+oYf/E9vfVt13tXradEoQL
	91o4ttZQ9lmTnskmC4h51THB36VSP9w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-blWc40RyMA-I1MBeM5f2nQ-1; Tue, 15 Oct 2024 06:19:29 -0400
X-MC-Unique: blWc40RyMA-I1MBeM5f2nQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a99efc7d881so186215966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728987568; x=1729592368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yL03YOPM9cVhg3T+Qftkg8/CQZZbBVIoxOh8LNZ0CNY=;
        b=EEUVPP1evEz0I5hb8lFKfNVlxxgerkq1KXMnPsOfHoXgQv9RwynCLYTUDz2dlr8T0r
         NgEI8VMS9lMXf8skXDANGca5Pjdr8TTNt1BssI6FmX6yvBD8It3VY9RQJEJ+FQGBDjSX
         bB4qdMarN8vFfQa1CKqVSLdd1X5Z12Egk25nMpjiJE70I1ckESYNafllUdJoi3MynrVq
         57u/vEGDQut9/w+WsjNGss+c9p8PujB8XO6FRCi8EqmtF3m5DNOmeh2BoiFVmN57kBhB
         /k5eT5mel6Wdr6xoCgaTf5e1HAlmUR2uzDGMVGwo3QhxbavyRjdfD9nfhQ2NIDFxj0Yf
         ssHg==
X-Forwarded-Encrypted: i=1; AJvYcCV1quQTyqT+1aT7hMDIoI+asHP3TgDqRor0ASCtJ//Pe6jmbGm6FcEbiNdIfND6Fr0Hh+3dIFZ5P5UG/Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEqfT7GB/a9tQ9KGVSxdHLVxstHLkWN+3KGX4cAPRFaVLB7G2Q
	tn3fszVlQbD0MJfgmdlXgikkqAdDomzI7fGnirB/E09v4KcdAdDXktJLH8Y1QiLKm/q8mT20JAc
	mA+BE3y39xW6VMhRGqR/06W1XCCXA4tJhj8qEr+9z6rOf6x8wu22s/yyGzxmuHg==
X-Received: by 2002:a17:907:3cb:b0:a9a:f82:7712 with SMTP id a640c23a62f3a-a9a0f8277a0mr373405666b.52.1728987568225;
        Tue, 15 Oct 2024 03:19:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCt73pi+kBQa8sFo8lywX0rXLgjhAffY6kTOniri1Q1voIZU61MMns3Q+EQxXd6h1IBekPBA==
X-Received: by 2002:a17:907:3cb:b0:a9a:f82:7712 with SMTP id a640c23a62f3a-a9a0f8277a0mr373404366b.52.1728987567756;
        Tue, 15 Oct 2024 03:19:27 -0700 (PDT)
Received: from redhat.com ([2a02:14f:171:1a30:7155:8c78:3ad8:e1c0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a298169a8sm53853266b.134.2024.10.15.03.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 03:19:27 -0700 (PDT)
Date: Tue, 15 Oct 2024 06:19:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 7/7] vhost: Add new UAPI to support change to task mode
Message-ID: <20241015061702-mutt-send-email-mst@kernel.org>
References: <20241004015937.2286459-1-lulu@redhat.com>
 <20241004015937.2286459-8-lulu@redhat.com>
 <a6b0d25b-4b8c-4633-8900-978adf14795d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6b0d25b-4b8c-4633-8900-978adf14795d@oracle.com>

On Mon, Oct 14, 2024 at 03:56:33PM -0500, Mike Christie wrote:
> On 10/3/24 8:58 PM, Cindy Lu wrote:
> > Add a new UAPI to support setting the vhost device to
> > use task mode. The user space application needs to use
> > VHOST_SET_INHERIT_FROM_OWNER to set the mode.
> > This setting must be set before VHOST_SET_OWNER is set.
> > 
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vhost.c      | 18 +++++++++++++++++-
> >  include/uapi/linux/vhost.h |  2 ++
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 08c9e77916ca..0e5c81026acd 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2341,8 +2341,24 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> >  {
> >  	struct eventfd_ctx *ctx;
> >  	u64 p;
> > -	long r;
> > +	long r = 0;
> >  	int i, fd;
> > +	bool inherit_owner;
> > +
> > +	if (ioctl == VHOST_SET_INHERIT_FROM_OWNER) {
> 
> Maybe instead of a modparam and this ioctl we just want a new ioctl:
> 
> /*
>  * This will setup the owner based on the calling thread instead of
>  * using kthread.
>  */
> #define VHOST_INHERIT_OWNER _IO(VHOST_VIRTIO, 0x83)

I feel this is not good because it is insecure -
process should not normally have a say in whether
namespaces work correctly.
So we want the system admin to be able to block the
old mode.

> It would initially be used by vhost-scsi when worker_per_virtqueue=true
> since that is a new use case and there will be no regressions.
> 
> For the other cases we default to VHOST_SET_OWNER. Other QEMU cases or
> tool XYZ can use the new ioctl when they are ready.

I do not like it that we switched default now we apparently will be
switching it back. Will break some userspace whatever we do.

-- 
MST


