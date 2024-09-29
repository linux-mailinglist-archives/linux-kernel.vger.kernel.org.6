Return-Path: <linux-kernel+bounces-343092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C51E9896AD
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D1B928249F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2B54779D;
	Sun, 29 Sep 2024 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdWDHJd9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D63D4207A
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 17:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727632129; cv=none; b=OC+DHs6acrjDpKf38/440HvJZNh8RsKz71dCezMdXNxWF0/3Nz9FuxCt0r7t+3Kdux+3T6/Psr04FVK1V12yzmkm//1VmuO08Hfre1h1KwdNkMy5W0LU9ZJP7165SIuRbtPEUxd7770tmTeoXMFt0iLJhsn1vtYA+JyOHEB3lRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727632129; c=relaxed/simple;
	bh=do27kc5Fwyi6Kx7WwmJUxF9V16BLmQ7JLqwuhDUy4Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVxX8I/64B0EfT0CzPvrDTQe1c+Wq8uDkG3jgYHZPJfNZ+PfkvI6JYnSojwIXiisl30JbmIwvJLJECLwVMIKgMDsR+281OSnJpv96xnmCxiY09h2dDQecbUrjRBP0RwDA6iscGOvcpy7MLFyPU+yosdrUBGxQQeZlkZPBTZ+2S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TdWDHJd9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727632126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wPatogrvfeQytgMf1DGOYNKKTCyiWPsjq+uNPqesLks=;
	b=TdWDHJd9BPPH2HTP4lnkPvCAjdjmWM6jZqnCaKxeXcMhsS/uvCF8XFUw65X3k9Poog3Ofm
	5xZfkf1wKjKMp5SKgY13J5HSbVqzbFT02aoD7siQeQvhKS5TsYTyfSNWaLj++4MLAPqCrz
	paxrOeD9H24r+NnplX06YSc6+/BM8pQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-RiNWLfKCMzmyVna93oraog-1; Sun, 29 Sep 2024 13:48:44 -0400
X-MC-Unique: RiNWLfKCMzmyVna93oraog-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8d1a00e0beso20435366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 10:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727632123; x=1728236923;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wPatogrvfeQytgMf1DGOYNKKTCyiWPsjq+uNPqesLks=;
        b=V9vSefcEXoTN+az06D5/4B8OgtZxP8dZTLTr0bz8gei5Yk8CnovXxGu2PlUwUL9kt/
         eG7lxJgrl6dju32hoSkBGnP2Jd3TS0lDyakAHEze5+WrNqPXzN4VzqfY3Narac3HvizH
         2r/01hK9JR5rHe89xxHdKKdeYFrKOBI6Zuy4sFWENuR8E9r+EdzBQkE06WnlE1/rJUA3
         xMbGueGm571BxJrCAV21DEuTKDJX0Zynx/XiOLA+fIsW+/gvHraMQI2snM8Ud5byVXNj
         qX5Hgtyqvq/1kpFMRAkZ/sRcx2Yz0F2KsiBZCOkgKzoS9SFe3v6Hqgl9ngQwYZHcYDKx
         kIzA==
X-Forwarded-Encrypted: i=1; AJvYcCWhTXWOkGMadgGsWIkwn9IaBxrJIP2GwmSVTXfkLAomij1ZEFjn6Xxz/l8WfMUqVzU58FtjgtPDl+/jHGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydm7x4CKkUIGsf7MA3HyGU+JvTUn/ZcbTmr1vf+9wYiAwFF/Ah
	1mziOcsg8zIg64RCR5wtVPXyemDJF60jBT3QYiVB4LGiHjqAGxldF1jkphd8wBllLy6G56yXLIS
	iae6yTOs7xwNKftfWlwGLv3B2AD9yo9y7R2tcbxAmlghxs+UUACwsV1QTh/TXvg==
X-Received: by 2002:a17:907:8687:b0:a8d:4954:c209 with SMTP id a640c23a62f3a-a93b165dacamr1584445166b.22.1727632123591;
        Sun, 29 Sep 2024 10:48:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8yhcltAXNNOPlgdZbg2eX/lkfZ7eFhPOsGjV+HlVBPUltwDUsyTd38J3Fyn/QINeqZ/Q5XA==
X-Received: by 2002:a17:907:8687:b0:a8d:4954:c209 with SMTP id a640c23a62f3a-a93b165dacamr1584442566b.22.1727632122934;
        Sun, 29 Sep 2024 10:48:42 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:822e:847c:4023:a734:1389])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2948fc7sm404346366b.137.2024.09.29.10.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 10:48:42 -0700 (PDT)
Date: Sun, 29 Sep 2024 13:48:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: stefanha@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: specify module version
Message-ID: <20240929134815-mutt-send-email-mst@kernel.org>
References: <20240926161641.189193-1-aleksandr.mikhalitsyn@canonical.com>
 <20240929125245-mutt-send-email-mst@kernel.org>
 <CAEivzxdiEu3Tzg7rK=TqDg4Ats-H+=JiPjvZRAnmqO7-jZv2Zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEivzxdiEu3Tzg7rK=TqDg4Ats-H+=JiPjvZRAnmqO7-jZv2Zw@mail.gmail.com>

On Sun, Sep 29, 2024 at 07:35:35PM +0200, Aleksandr Mikhalitsyn wrote:
> On Sun, Sep 29, 2024 at 6:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Sep 26, 2024 at 06:16:40PM +0200, Alexander Mikhalitsyn wrote:
> > > Add an explicit MODULE_VERSION("0.0.1") specification
> > > for a vhost_vsock module. It is useful because it allows
> > > userspace to check if vhost_vsock is there when it is
> > > configured as a built-in.
> > >
> > > Without this change, there is no /sys/module/vhost_vsock directory.
> > >
> > > With this change:
> > > $ ls -la /sys/module/vhost_vsock/
> > > total 0
> > > drwxr-xr-x   2 root root    0 Sep 26 15:59 .
> > > drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
> > > --w-------   1 root root 4096 Sep 26 15:59 uevent
> > > -r--r--r--   1 root root 4096 Sep 26 15:59 version
> > >
> > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> >
> >
> 
> Dear Michael,
> 
> > Why not check that the misc device is registered?
> 
> It is possible to read /proc/misc and check if "241 vhost-vsock" is
> there, but it means that userspace
> needs to have a specific logic for vsock. At the same time, it's quite
> convenient to do something like:
>     if [ ! -d /sys/modules/vhost_vsock ]; then
>         modprobe vhost_vsock
>     fi
> 
> > I'd rather not add a new UAPI until actually necessary.
> 
> I don't insist. I decided to send this patch because, while I was
> debugging a non-related kernel issue
> on my local dev environment I accidentally discovered that LXD
> (containers and VM manager)
> fails to run VMs because it fails to load the vhost_vsock module (but
> it was built-in in my debug kernel
> and the module file didn't exist). Then I discovered that before
> trying to load a module we
> check if /sys/module/<module name> exists. And found that, for some
> reason /sys/module/vhost_vsock
> does not exist when vhost_vsock is configured as a built-in, and
> /sys/module/vhost_vsock *does* exist when
> vhost_vsock is loaded as a module. It looks like an inconsistency and
> I also checked that other modules in
> drivers/vhost have MODULE_VERSION specified and version is 0.0.1. I
> thought that this change looks legitimate
> and convenient for userspace consumers.
> 
> Kind regards,
> Alex


I'll ask you to put this explanation in the commit log,
and I'll pick this up.

> >
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


