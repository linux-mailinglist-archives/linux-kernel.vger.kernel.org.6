Return-Path: <linux-kernel+bounces-344220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFC198A698
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA3B282C0D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3361917F1;
	Mon, 30 Sep 2024 14:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cX8lx5c7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878B018FDDB
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727705120; cv=none; b=W5yVNWFZEDZGQwFKiKTPlS/0e0z17p8qkYXCMeITzcuYgn3Eg0e5ppawreEMNvVocXzBN1pQRE7K5wmSY1JzODTZ6Th/VYKXft430Pil9WSr2f08Xy7SxVda0EY5YNtg9PzruvpgU0AppZTTOh6bzCgDC8xTGxyFEXIwysKd3HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727705120; c=relaxed/simple;
	bh=8BGV6YA2jSXgAI4/qg8vo/il6pLpZ5Aufd6kqqJ600o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUERbJ1xlrLQCUqr20hCYGCyxIzhNo+KPQyy0DmI7JS98tjmdaTlI8WF38lyvgCtVSFVZZ11j9MjWIY2s+ddUcmq6QZYVvGz9eHMBjK1WutoXH//ZjSW4AEQyFo5UysgM35+yr1wFgFIffh2BEK2JFA5R+pVW+qKmhc/qhK7KpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cX8lx5c7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727705117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbhYe2/DTQRFzN+Y7O/uex+Kh54T+vm7XXpc5sSRsSU=;
	b=cX8lx5c7z/4SJXU9OhJsZRjKBwrAKIZmWTwh4pE9EvgFpERlRx9jtMLpVs7+ylq7RRPKDU
	YV7iCY713I0/DPZFSYtNKR3IRmAcSHadEsIdJeeBIlLU6ValHCNwSAIz9jID41PIy2f9Da
	QF/en33QM1wB0FVZveoG8SikM+O6WOw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-rISR-mXIPjqo7jGU21c-DQ-1; Mon, 30 Sep 2024 10:05:16 -0400
X-MC-Unique: rISR-mXIPjqo7jGU21c-DQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb22d396cso37086025e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727705113; x=1728309913;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbhYe2/DTQRFzN+Y7O/uex+Kh54T+vm7XXpc5sSRsSU=;
        b=XhlH/SddCBI1WdCp1ciDsP1ZLHi+YCURjsn6yTdD/NzySJJvW+4w0FqU6xSkEbxqCD
         aVS7+ZerOZEqhdEAvnocPD2ChHMXcm7UMA6Q7pH9vZAdLYYlx96E112aJhXUsiuNETow
         h6bYa43cdn3OHEGtacWaxsxoS3zAzRu09Mb08NO6aVU8dX0bQVvAi8yVDXMbgYJKAK68
         LaHuBCY1oD7AiywhMnvyZdwxo05dg7iDB0tReX92USBqPQiZ6wNgZ0t1ktaivVa3a8kx
         fy3Lj8T9NGE9Zaux/bTW8CTv/f99d5Gqr1H87OrP7dgonIrQSZAHGsb+VT4foodSTqav
         9D/w==
X-Forwarded-Encrypted: i=1; AJvYcCVSjN88mtC7IciCgMYDbi+jKZgl8V/2ezn3NrCenxcIqnU7uTsX4SE2RL3rOC0EOvYtaGfsvoVo9UaitEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI4dxSOsPwqBJvWs8v/+AQrKkwDUJVAMmszA4t5alj4HU4IR3n
	wmEjtCWrGkWbgCRFzFiV1VQjwUKvdLZz/NNCPI6MWF2Xwp8IFaBofPqZTNLPOQrAhpUH4BxZrwl
	9v9CCyl2pS8u2p6AqJ1zmlnqSnCcrIz9n97v5pBu7tPNSGAI4HFkQn2WSgAbyNA==
X-Received: by 2002:a05:600c:45cb:b0:42c:b905:2bf9 with SMTP id 5b1f17b1804b1-42f5844aaf2mr102046385e9.16.1727705112922;
        Mon, 30 Sep 2024 07:05:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHedwkuap3eJCT3RHcthIkOqlbt0d6yHOSw0A1Hk3ikUkgu+/CDxR6xGUFVDewLI1wRMZ9G9Q==
X-Received: by 2002:a05:600c:45cb:b0:42c:b905:2bf9 with SMTP id 5b1f17b1804b1-42f5844aaf2mr102046045e9.16.1727705112494;
        Mon, 30 Sep 2024 07:05:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55d:ca3b:807c:fdd2:f46d:60e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a36244sm152852005e9.38.2024.09.30.07.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 07:05:11 -0700 (PDT)
Date: Mon, 30 Sep 2024 10:05:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: stefanha@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vhost/vsock: specify module version
Message-ID: <20240930100452-mutt-send-email-mst@kernel.org>
References: <20240929182103.21882-1-aleksandr.mikhalitsyn@canonical.com>
 <20240929150147-mutt-send-email-mst@kernel.org>
 <CAEivzxcvokDUPWzj48aJX6a4RU_i+OdMOH=fyLQW+FObjKpZDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEivzxcvokDUPWzj48aJX6a4RU_i+OdMOH=fyLQW+FObjKpZDQ@mail.gmail.com>

On Mon, Sep 30, 2024 at 02:28:30PM +0200, Aleksandr Mikhalitsyn wrote:
> On Sun, Sep 29, 2024 at 9:03 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Sun, Sep 29, 2024 at 08:21:03PM +0200, Alexander Mikhalitsyn wrote:
> > > Add an explicit MODULE_VERSION("0.0.1") specification for the vhost_vsock module.
> > >
> > > It is useful because it allows userspace to check if vhost_vsock is there when it is
> > > configured as a built-in.
> > >
> > > This is what we have *without* this change and when vhost_vsock is configured
> > > as a module and loaded:
> > >
> > > $ ls -la /sys/module/vhost_vsock
> > > total 0
> > > drwxr-xr-x   5 root root    0 Sep 29 19:00 .
> > > drwxr-xr-x 337 root root    0 Sep 29 18:59 ..
> > > -r--r--r--   1 root root 4096 Sep 29 20:05 coresize
> > > drwxr-xr-x   2 root root    0 Sep 29 20:05 holders
> > > -r--r--r--   1 root root 4096 Sep 29 20:05 initsize
> > > -r--r--r--   1 root root 4096 Sep 29 20:05 initstate
> > > drwxr-xr-x   2 root root    0 Sep 29 20:05 notes
> > > -r--r--r--   1 root root 4096 Sep 29 20:05 refcnt
> > > drwxr-xr-x   2 root root    0 Sep 29 20:05 sections
> > > -r--r--r--   1 root root 4096 Sep 29 20:05 srcversion
> > > -r--r--r--   1 root root 4096 Sep 29 20:05 taint
> > > --w-------   1 root root 4096 Sep 29 19:00 uevent
> > >
> > > When vhost_vsock is configured as a built-in there is *no* /sys/module/vhost_vsock directory at all.
> > > And this looks like an inconsistency.
> >
> > And that's expected.
> >
> > > With this change, when vhost_vsock is configured as a built-in we get:
> > > $ ls -la /sys/module/vhost_vsock/
> > > total 0
> > > drwxr-xr-x   2 root root    0 Sep 26 15:59 .
> > > drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
> > > --w-------   1 root root 4096 Sep 26 15:59 uevent
> > > -r--r--r--   1 root root 4096 Sep 26 15:59 version
> >
> 
> Hi Michael,
> 
> > Sorry, what I'd like to see is an explanation which userspace
> > is broken without this change, and whether this patch fixes is.
> 
> Ok, let me try to write a proper commit message in this thread. I'll
> send a v3 once we agree on it (don't want to spam busy
> kvm developers with my one-liner fix in 10 different revisions :-) ).
> 
> ============
> Add an explicit MODULE_VERSION("0.0.1") specification for the
> vhost_vsock module.
> 
> It is useful because it allows userspace to check if vhost_vsock is
> there when it is
> configured as a built-in. We already have userspace consumers [1], [2]
> who rely on the
> assumption that if <any_linux_kernel_module> is loaded as a module OR configured
> as a built-in then /sys/module/<any_linux_kernel_module> exists. While
> this assumption
> works well in most cases it is wrong in general. For a built-in module
> X you get a /sys/module/<X>
> only if the module declares MODULE_VERSION or if the module has any
> parameter(s) declared.
> 
> Let's just declare MODULE_VERSION("0.0.1") for vhost_vsock to make
> /sys/module/vhost_vsock
> to exist in all possible configurations (loadable module or built-in).
> Version 0.0.1 is chosen to align
> with all other modules in drivers/vhost.
> 
> This is what we have *without* this change and when vhost_vsock is configured
> as a module and loaded:
> 
> $ ls -la /sys/module/vhost_vsock
> total 0
> drwxr-xr-x   5 root root    0 Sep 29 19:00 .
> drwxr-xr-x 337 root root    0 Sep 29 18:59 ..
> -r--r--r--   1 root root 4096 Sep 29 20:05 coresize
> drwxr-xr-x   2 root root    0 Sep 29 20:05 holders
> -r--r--r--   1 root root 4096 Sep 29 20:05 initsize
> -r--r--r--   1 root root 4096 Sep 29 20:05 initstate
> drwxr-xr-x   2 root root    0 Sep 29 20:05 notes
> -r--r--r--   1 root root 4096 Sep 29 20:05 refcnt
> drwxr-xr-x   2 root root    0 Sep 29 20:05 sections
> -r--r--r--   1 root root 4096 Sep 29 20:05 srcversion
> -r--r--r--   1 root root 4096 Sep 29 20:05 taint
> --w-------   1 root root 4096 Sep 29 19:00 uevent
> 
> When vhost_vsock is configured as a built-in there is *no*
> /sys/module/vhost_vsock directory at all.
> And this looks like an inconsistency.
> 
> With this change, when vhost_vsock is configured as a built-in we get:
> $ ls -la /sys/module/vhost_vsock/
> total 0
> drwxr-xr-x   2 root root    0 Sep 26 15:59 .
> drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
> --w-------   1 root root 4096 Sep 26 15:59 uevent
> -r--r--r--   1 root root 4096 Sep 26 15:59 version
> 
> Link: https://github.com/canonical/lxd/blob/ef33aea98aec9778499e96302f2605882d8249d7/lxd/instance/drivers/driver_qemu.go#L8568
> [1]
> Link: https://github.com/lxc/incus/blob/cbebce1dcd5f15887967058c8f6fec27cf0da2a2/internal/server/instance/drivers/driver_qemu.go#L8723
> [2]
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ============
> 
> Does this sound fair enough?
> 
> Kind regards,
> Alex


Looks good, thanks!

> >
> >
> >
> > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> > > ---
> > >  drivers/vhost/vsock.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > > index 802153e23073..287ea8e480b5 100644
> > > --- a/drivers/vhost/vsock.c
> > > +++ b/drivers/vhost/vsock.c
> > > @@ -956,6 +956,7 @@ static void __exit vhost_vsock_exit(void)
> > >
> > >  module_init(vhost_vsock_init);
> > >  module_exit(vhost_vsock_exit);
> > > +MODULE_VERSION("0.0.1");
> > >  MODULE_LICENSE("GPL v2");
> > >  MODULE_AUTHOR("Asias He");
> > >  MODULE_DESCRIPTION("vhost transport for vsock ");
> > > --
> > > 2.34.1
> >


