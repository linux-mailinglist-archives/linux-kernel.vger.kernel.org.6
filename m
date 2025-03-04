Return-Path: <linux-kernel+bounces-545477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE0AA4EDA2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1774173122
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D4525FA0A;
	Tue,  4 Mar 2025 19:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Dp0ostl+"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8921D7E35
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117306; cv=none; b=Y7i5bU6tsPi/7riwX9Opt6dj8gAoyPAmCRC2aMY4Rxn/XGQqiKFEqTbeMbwJDmNp4xtrS12kAvboROzwRsOy+K0VKxchlYJQkjNtTR6mZoAS+jDvZEI4kwPJIFgCFnz3K6qNOdjMQD9lcu7E2XHZqrsxRx3h2eOro8Hci2JZ0Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117306; c=relaxed/simple;
	bh=Z1Dr2H1wZQma+yJxOpXVs8NcHO1DKsOkb0OPlMDP+XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+DMF76GYWW+Jz0USb5u5o3UE2nVB4GBFluP5OqegcFGEtwuHFvr5qFypPXOEk5SYHtk/NgR3X/T28dAGlfRqkdR215lu9MWfqmNuiPAncw3EzL7Brbk7fuclBsjyc4Id5muLemf1Wl9t2YvckfTgbCSCb7/r5Kp74zxWDVq70I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Dp0ostl+; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e86b92d3b0so45119856d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 11:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741117302; x=1741722102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hniMK4SB1u1F2OOA4rSYd4xqdAr8kGaAFH0sJ2S5DiI=;
        b=Dp0ostl+XTTjDEM3m1SzD6qZL0bKvFcGaXEQHgrUtJ+Mr5RonLJYQ3jcyInnuALtSd
         UEQn/OvkSo7/odNgS8TUNQrB+7GyZTVNKZjqzVBHfy9OzsDd1h9s0XyMdiKLLsZT+uck
         7VtQLP+Xh6czvHWQ4t6pKXbWPVr72SisFtfcZ/UuXrO5S1Y+4JJE6M3tcrGPWGftPD66
         nWx6U7SZAhx/oZ40QYh47Dd8tHzuVDhY+RHrYlBAvVhnY96hm8+rFAtjUVBzm0zokP3j
         SImSxPHMkasmx0/sPaU0h96q9GXQza8442rT7xUw8HKjvYKQBwf8pZpq1DnC1gLbBPjh
         OifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741117302; x=1741722102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hniMK4SB1u1F2OOA4rSYd4xqdAr8kGaAFH0sJ2S5DiI=;
        b=TFVoSrWnvzFbyE7YZLaGg+z/DbkvF+3rnl9eeTfmsP/hRAn93JpHp1IADJ0WJOkyrY
         LHGGWmHHYhZlFbhrRmCOS5nCD/OX/Ku+7V51zYE8MjkGAJ3aqVC8gkzQt7aHl6TwRidK
         Af0/Q/H3hKA0GvVR3+gvrQWHlDhDK0fgpSz6r6xBdil0rHszHryGth1hC4dHsBfqhRpe
         KMHG5pmTw5LZzbkOntJmv5sflkvnSQS4yYdmiTKriXiqN8ZtteGVWr0iJLeTJn+2cGh6
         BrD6bFylnExFB6wUANCEaxCliddoD39glba0LC0Dkp2r8qPmQ7b8Q0q1Bg4wj27G52B2
         WiPw==
X-Forwarded-Encrypted: i=1; AJvYcCVqQjlFaKg8NLsxnKZQ0KmalkRGUTeCBjXFJaV14u3KQiEaPWuSEimXU2hbkHXY1TL3bAw8UGP+C+8Xokw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNFBV3UlfAzIaUTtOxfYzrGvnrHPtZhkZarC1vhMK2h8DpZgdX
	DdVhhkpF4/JMATWaGaZp099xYUDYiy9S4seVcNp3SoZB8o3FRGWCV6uFFMOWInI=
X-Gm-Gg: ASbGncv1/t+DnOKzf7heNu7WEussKcTktpKFPHbZ6VnQxy2P+nj6X0HQvIBTIytgPSd
	mM52y13YrjWJSsWEjd4MsXhULurh5nRJjKd5W41VPSSNB1trV6E5eY8VbdCNLRPx5fvb7rRDII5
	XsEiXeby0LO1KmDF9J3E/wm4G79kK1OJFsNScYVMdwEXICfnTluwt9jPWXGr8wRDZDkR3iUoXBW
	1MXl1qpx2o3DTDRLsZ/vLRSkcZ5thJQhZKDhyRUSh2uAtSM8BJc+ZAPPj1p83TlLAsiwu1m/T5F
	8EOWfACGnj16co3nn53/Vo3a+Q277aROSR61naxJoFd3ighgdEQDSB6of4UIlZV/GfNH1dF0liQ
	FMWkYm3Ses006f2ydew==
X-Google-Smtp-Source: AGHT+IEVAKGzcENzw+iAKzItxzizgLoOPdiHsjgb9KK/h/j44uEdoziCKUzFRD74zSh7p4AQOUAf1A==
X-Received: by 2002:a05:6214:e67:b0:6e8:89bd:2b50 with SMTP id 6a1803df08f44-6e8e6cc6b6emr9042306d6.7.1741117300888;
        Tue, 04 Mar 2025 11:41:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ec1f8sm70616526d6.121.2025.03.04.11.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 11:41:40 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tpY95-00000001J4e-2w8n;
	Tue, 04 Mar 2025 15:41:39 -0400
Date: Tue, 4 Mar 2025 15:41:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Long Li <longli@microsoft.com>
Cc: Ratheesh Kannoth <rkannoth@marvell.com>,
	"longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
	Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [Patch rdma-next] RDMA/mana_ib: handle net event
 for pointing to the current netdev
Message-ID: <20250304194139.GE5011@ziepe.ca>
References: <1740782519-13485-1-git-send-email-longli@linuxonhyperv.com>
 <20250304063940.GA2702870@maili.marvell.com>
 <SA6PR21MB423174BA15D8A909CB2A6950CEC82@SA6PR21MB4231.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA6PR21MB423174BA15D8A909CB2A6950CEC82@SA6PR21MB4231.namprd21.prod.outlook.com>

On Tue, Mar 04, 2025 at 06:26:03PM +0000, Long Li wrote:
> > On 2025-03-01 at 04:11:59, longli@linuxonhyperv.com
> > (longli@linuxonhyperv.com) wrote:
> > > From: Long Li <longli@microsoft.com>
> > >
> > > When running under Hyper-V, the master device to the RDMA device is
> > > always bonded to this RDMA device if it's present in the kernel. This
> > > is not user-configurable.
> > >
> > > The master device can be unbind/bind from the kernel. During those
> > > events, the RDMA device should set to the current netdev to relect the
> > > change of master device from those events.
> > >
> > > Signed-off-by: Long Li <longli@microsoft.com>
> > > ---
> > >  drivers/infiniband/hw/mana/device.c  | 35
> > > ++++++++++++++++++++++++++++  drivers/infiniband/hw/mana/mana_ib.h |
> > > 1 +
> > >  2 files changed, 36 insertions(+)
> > >
> > > diff --git a/drivers/infiniband/hw/mana/device.c
> > > b/drivers/infiniband/hw/mana/device.c
> > > index 3416a85f8738..3e4f069c2258 100644
> > > --- a/drivers/infiniband/hw/mana/device.c
> > > +++ b/drivers/infiniband/hw/mana/device.c
> > > @@ -51,6 +51,37 @@ static const struct ib_device_ops mana_ib_dev_ops = {
> > >                          ib_ind_table),  };
> > >
> > > +static int mana_ib_netdev_event(struct notifier_block *this,
> > > +                             unsigned long event, void *ptr) {
> > > +     struct mana_ib_dev *dev = container_of(this, struct mana_ib_dev, nb);
> > > +     struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
> > > +     struct gdma_context *gc = dev->gdma_dev->gdma_context;
> > > +     struct mana_context *mc = gc->mana.driver_data;
> > > +     struct net_device *ndev;
> > > +
> > > +     if (event_dev != mc->ports[0])
> > > +             return NOTIFY_DONE;
> > > +
> > > +     switch (event) {
> > > +     case NETDEV_CHANGEUPPER:
> > > +             rcu_read_lock();
> > > +             ndev = mana_get_primary_netdev_rcu(mc, 0);
> > > +             rcu_read_unlock();
> > ...
> > > +
> > > +             /*
> > > +              * RDMA core will setup GID based on updated netdev.
> > > +              * It's not possible to race with the core as rtnl lock is being
> > > +              * held.
> > > +              */
> > > +             ib_device_set_netdev(&dev->ib_dev, ndev, 1);
> > rcu_read_unlock() should be here, right ?
> 
> It can't.  ib_device_set_netdev() is calling alloc_port_data() and may sleep.
> 
> I think this locking is okay. This event only comes in when:
> 1. the master device has changed to netvsc. In this case ndev is guaranteed to be valid as this notification is triggered by netvsc.
> 2. the master device has changed to itself (the ethernet device parent for the IB device).  In this case, ndev is valid because mana_ib is an auxiliary device to ndev and it can't unload itself at this time.


Why not return with the netdev refcount held so you don't need this
weirdo rcu thing?

Jason

