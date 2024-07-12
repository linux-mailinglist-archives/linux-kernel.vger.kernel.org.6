Return-Path: <linux-kernel+bounces-251211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5406A930227
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D434A1F2285C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 22:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5493F73501;
	Fri, 12 Jul 2024 22:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFJ/GbFa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6933651C21
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 22:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720823789; cv=none; b=ghdNKEXrnqAOR+4Ne/0YpdfTDMYsx03dMEwb9vYzPWAUfnxVc9LiY4XdYxpm2/2qUBzovxMGHnSv8Jcq+WPkpsh4kcwmJUatX02jd/B/o2Jlg1mruLLecpLsVxSag8wJRJueyOSroyJoBDFLmbtpEKeWc0pc05HEMELA7cYMoio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720823789; c=relaxed/simple;
	bh=TNXcGKx0oO0INQoUwhNKp6sd7FDNWObHlJOZyFifFs8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TEdINUvreaWWP7qIgSa6lTOHbIMmzUMei1iyGqFuWqkQCLrHRewUaRgsj6R7E6rMlJ9T3R7FwmfjumiQCuZ0Pce4Y4vbkk8FQcfO880VelTRK79nw0aoX9YAzBYTYNCOJefFZO0K+yKvCCIOWs/1elyW9B64jHtJz6Uag21sGfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NFJ/GbFa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720823786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UD+jsIB9utwUuMD5D9RKKWQHJKFtMYpx4nMjcv9KoxQ=;
	b=NFJ/GbFacmMjFCx2KCrY2h1GIzSPKDh051sxNVOB1yjwe8sWB5ub3PwenAXZxNREKge1lH
	xaDqLxYAw7z+8+unq3xcRvXLZ1vYNK6a4dEei4k3+KsVRtB+mRT3CPEiPUbQkcJALEqnBn
	4dzURTrAh8gFBLZfK7+dofKkAX8SPRQ=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-wNTFWPeMOqGXWRHcu9FHTA-1; Fri, 12 Jul 2024 18:36:24 -0400
X-MC-Unique: wNTFWPeMOqGXWRHcu9FHTA-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f3b0bc9cf6so274264539f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 15:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720823784; x=1721428584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UD+jsIB9utwUuMD5D9RKKWQHJKFtMYpx4nMjcv9KoxQ=;
        b=DndtMTzFtoMxaNoy+lAes72WTJno/dbOKQofMJi6dU9kebF331b9okZuu9arY1v7nE
         pDM2YgLPsbIvt7sKUUeS8iA3/xHZkBbqO10zQp7+FZKdwpdzvdwl0ZHRYmqfRlcznuLs
         h3D86GUaJvBVI/I/fyvPiLTK5t6nrdR/pjwfND1Vl0xId5mti/QQ2o4A++llXLqzc7yC
         5VO0MQ800Vgj0BO5VGIbOgsGN+qSQh01JEGzbyxIFcf0a3rDRbdmwEKBc7XPGHQtF7Kc
         eMqu7SH1y6nXrvvzemAU/P1/dcttaham2E2Etemcar9GWOeGl1gERP9Gi31nJWLwDm4z
         pV7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqfSZ2+6qvFlKSFZaSMxwEV0f4ieAs/6GeYtWiqiZH8UhVSkS2JeDlg6AsfQNwdN8oPS5GVXom8P68a9yH3HmfnCC2Z2tTtn3M7b1B
X-Gm-Message-State: AOJu0Yy3BG3UxMZfWz+eOU8rBc3/lgn2wDoBJRM3/w27p56zSk1u0x3Y
	eBE9ceV5nAxHtmm1n9x/bVwzGaGZOYa9Vij28yDVKmYSMTdl7fJN7hFZYwCfGLzWEKGC84kp2h2
	mAnEZZZrxu9CtbWpG1eShoYuEvXpJmgStVL4tCxysUhZ2vpkZVwErjz0Ajdd+fQ==
X-Received: by 2002:a05:6602:1615:b0:7f6:f93d:e6a0 with SMTP id ca18e2360f4ac-800034fd528mr1822795339f.15.1720823783806;
        Fri, 12 Jul 2024 15:36:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSyar8qW8JkxVFrshE2XwMjaVLy7kugEr4dBZXEvrYReUj5BJaoGKYAE5t07ynIbmqrbCK4g==
X-Received: by 2002:a05:6602:1615:b0:7f6:f93d:e6a0 with SMTP id ca18e2360f4ac-800034fd528mr1822794539f.15.1720823783398;
        Fri, 12 Jul 2024 15:36:23 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1af8108sm2710939173.14.2024.07.12.15.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 15:36:22 -0700 (PDT)
Date: Fri, 12 Jul 2024 16:36:21 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>, Jeff Johnson
 <quic_jjohnson@quicinc.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] vfio-mdev: add MODULE_DESCRIPTION() macros
Message-ID: <20240712163621.6f34ae98.alex.williamson@redhat.com>
In-Reply-To: <MN2PR12MB420688C51B3F2CC8BF8CA3A8DCA62@MN2PR12MB4206.namprd12.prod.outlook.com>
References: <20240523-md-vfio-mdev-v1-1-4676cd532b10@quicinc.com>
	<a94604eb-7ea6-4813-aa78-6c73f7d4253a@quicinc.com>
	<MN2PR12MB420688C51B3F2CC8BF8CA3A8DCA62@MN2PR12MB4206.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 07:27:33 +0000
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> + Alex.
> 
> Reviewed by : Kirti Wankhede <kwankhede@nvidia.com>

Mind the syntax, Reviewed-by:

Also a comment below...

> > -----Original Message-----
> > From: Jeff Johnson <quic_jjohnson@quicinc.com>
> > Sent: Friday, July 12, 2024 12:01 AM
> > To: Kirti Wankhede <kwankhede@nvidia.com>
> > Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org; kernel-
> > janitors@vger.kernel.org
> > Subject: Re: [PATCH] vfio-mdev: add MODULE_DESCRIPTION() macros
> > 
> > On 5/23/24 17:12, Jeff Johnson wrote:  
> > > Fix the 'make W=1' warnings:
> > > WARNING: modpost: missing MODULE_DESCRIPTION() in samples/vfio-  
> > mdev/mtty.o  
> > > WARNING: modpost: missing MODULE_DESCRIPTION() in samples/vfio-  
> > mdev/mdpy.o  
> > > WARNING: modpost: missing MODULE_DESCRIPTION() in samples/vfio-  
> > mdev/mdpy-fb.o  
> > > WARNING: modpost: missing MODULE_DESCRIPTION() in samples/vfio-  
> > mdev/mbochs.o  
> > >
> > > Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> > > ---
> > >   samples/vfio-mdev/mbochs.c  | 1 +
> > >   samples/vfio-mdev/mdpy-fb.c | 1 +
> > >   samples/vfio-mdev/mdpy.c    | 1 +
> > >   samples/vfio-mdev/mtty.c    | 1 +
> > >   4 files changed, 4 insertions(+)
> > >
> > > diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
> > > index 9062598ea03d..836456837997 100644
> > > --- a/samples/vfio-mdev/mbochs.c
> > > +++ b/samples/vfio-mdev/mbochs.c
> > > @@ -88,6 +88,7 @@
> > >   #define STORE_LE32(addr, val)	(*(u32 *)addr = val)
> > >
> > >
> > > +MODULE_DESCRIPTION("Mediated virtual PCI display host device driver");
> > >   MODULE_LICENSE("GPL v2");
> > >
> > >   static int max_mbytes = 256;
> > > diff --git a/samples/vfio-mdev/mdpy-fb.c b/samples/vfio-mdev/mdpy-fb.c
> > > index 4598bc28acd9..149af7f598f8 100644
> > > --- a/samples/vfio-mdev/mdpy-fb.c
> > > +++ b/samples/vfio-mdev/mdpy-fb.c
> > > @@ -229,4 +229,5 @@ static int __init mdpy_fb_init(void)
> > >   module_init(mdpy_fb_init);
> > >
> > >   MODULE_DEVICE_TABLE(pci, mdpy_fb_pci_table);
> > > +MODULE_DESCRIPTION("Framebuffer driver for mdpy (mediated virtual pci  
> > display device)");  
> > >   MODULE_LICENSE("GPL v2");
> > > diff --git a/samples/vfio-mdev/mdpy.c b/samples/vfio-mdev/mdpy.c
> > > index 27795501de6e..8104831ae125 100644
> > > --- a/samples/vfio-mdev/mdpy.c
> > > +++ b/samples/vfio-mdev/mdpy.c
> > > @@ -40,6 +40,7 @@
> > >   #define STORE_LE32(addr, val)	(*(u32 *)addr = val)
> > >
> > >
> > > +MODULE_DESCRIPTION("Mediated virtual PCI display host device driver");
> > >   MODULE_LICENSE("GPL v2");
> > >
> > >   #define MDPY_TYPE_1 "vga"
> > > diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
> > > index 2284b3751240..40e7d154455e 100644
> > > --- a/samples/vfio-mdev/mtty.c
> > > +++ b/samples/vfio-mdev/mtty.c
> > > @@ -2059,5 +2059,6 @@ module_exit(mtty_dev_exit)
> > >
> > >   MODULE_LICENSE("GPL v2");
> > >   MODULE_INFO(supported, "Test driver that simulate serial port over PCI");
> > > +MODULE_DESCRIPTION("Test driver that simulate serial port over PCI");

Seems the preceding MODULE_INFO needs to be removed here.  At best the
added MODULE_DESCRIPTION is redundant, but "supported" is not a
standard tag, so it's not clear what the purpose of that tag was meant
to be anyway.  Thanks,

Alex

> > >   MODULE_VERSION(VERSION_STRING);
> > >   MODULE_AUTHOR(DRIVER_AUTHOR);
> > >
> > > ---
> > > base-commit: 5c4069234f68372e80e4edfcce260e81fd9da007
> > > change-id: 20240523-md-vfio-mdev-381f74bf87f1
> > >  
> > 
> > I don't see this in linux-next yet so following up to see if anything
> > else is needed to get this merged.
> > 
> > I hope to have these warnings fixed tree-wide in 6.11.
> > 
> > /jeff  


