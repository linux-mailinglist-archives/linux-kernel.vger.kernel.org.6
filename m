Return-Path: <linux-kernel+bounces-344230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE7B98A6F5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F99F1C20B50
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B221917F2;
	Mon, 30 Sep 2024 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHU9Gqgg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5A718FC79
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727706463; cv=none; b=Uj/MYt4YGi/Jrjnn4OVom03je9Oequ88hxcR9yv/6oo2lB1fEfALDIxdLlwqVrZVobJOVyq4tZFf6G2X6q0cSnxrQvt+5jTBeLc9kPIdhrWfi9Wk++3SgRmFcp5kdGICCnAnNPbkuoL5+DaQG4Rv+nKid6yL2JM1UabYb5xu+cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727706463; c=relaxed/simple;
	bh=EeYyLF20aDFEbuavaL7j2KagAYQQasGHqOcT6pXxFaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBJJIjqOojE2fIAYHH1Q7+TMmISGpxk9yZJqfr8Ya+Hf59O77ogpKVM7lgbJjki07zTKbPGNPvSqjhN0LRVw8Zxa8S6GppuUoQepHFPMES+nY6EPMUiS2EcZknANPqoFmgelr/cPB0UXgXsuknrnQif5fUW65xOQzH7H6nQlK6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHU9Gqgg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727706460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4ytbPBd95cWqX8Nn+fM7i9ZT4U+6yWcLeNhuCcF4JcQ=;
	b=LHU9Gqgg7UuJ3hYXB4XRMhM4XKtRYBSYG/Rb9EC6f27Ft3yj4jh5AFRMD+pmtDHd/whfbm
	KrIxZUT28kV7Kg/2C4Tg3t8+6hi9JCUQDnbQXCaAxvF2DD28hSmttW3LBOi00sibCPYTsU
	2+Econ3Yh0gh5y50APsHnmHZJ4WXoB8=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-RGtPliqGMlaytlKNDlqrgw-1; Mon, 30 Sep 2024 10:27:39 -0400
X-MC-Unique: RGtPliqGMlaytlKNDlqrgw-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5e1c8fa5032so3411025eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727706459; x=1728311259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ytbPBd95cWqX8Nn+fM7i9ZT4U+6yWcLeNhuCcF4JcQ=;
        b=lwd705bv9OVGTREGv6oP07WgZW0bc9UGA8AegVHlSmfyUT+nwz3Eaz21bE51nG42QW
         QIBtSnW5DWlD6WDF4JnPaEOux4l7lQjWuK9s24e0Cj9desHhNoI1uOWR1RX+90AMgiQk
         WNkdaBNjeBN1eh4MOVqDi4PfjR/7CWL0aqkLkB4Rue6nCQW10XvuNCUfD9wNajO6vtzM
         NtSaQ+xTT0Mz+HMT2oS19nn62tML1O5blARBkLHWiSU0AYNzfuXFwWZVfnSdCLaA8JzL
         drSmOFed3SMKwUCtijVuqU8FXN1WPKYnvRJ51AATXCrLZA94tIXF1J0zX5Q9coKY/uTp
         ZJTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCV0Yeeezq49PepWsP6gH0BHV9w0I5gEBlcttOM/UJgYaqKfMoxlixeo+iLfdGARU4s192PeR2pvcU+WE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfo1XE+ien8amYid/JN7LyGUGgKlAwtTwpyuT2PEtbZLjayxZ0
	HOggvMP/Dv41IB97uIwFihsUqmqlBYdY19DIhzMB5CiLxhb9b5JW6nuCGl3iXFh8h2CZUqHwVez
	GmI9uWawPnGaA22zGMr22Uqt03juQs3szHcFXP5tSWuqKx6+3wtZiqRNOxVJbYA==
X-Received: by 2002:a05:6358:7201:b0:1af:15b5:7ca0 with SMTP id e5c5f4694b2df-1becbc29d1emr438412755d.6.1727706458902;
        Mon, 30 Sep 2024 07:27:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIrMRsWhZz29fSWrh8R6+DMZiFE0fzWTDB+zeNZvgXRTdMVS2bFMuus9C1n6IS1/FhZMePYA==
X-Received: by 2002:a05:6358:7201:b0:1af:15b5:7ca0 with SMTP id e5c5f4694b2df-1becbc29d1emr438410055d.6.1727706458474;
        Mon, 30 Sep 2024 07:27:38 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b68ec20sm40159986d6.135.2024.09.30.07.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 07:27:37 -0700 (PDT)
Date: Mon, 30 Sep 2024 16:27:14 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
	kuba@kernel.org
Cc: stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vhost/vsock: specify module version
Message-ID: <w3fc6fwdwaakygtoktjzavm4vsqq2ks3lnznyfcouesuu7cqog@uiq3y4gjj5m3>
References: <20240929182103.21882-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240929182103.21882-1-aleksandr.mikhalitsyn@canonical.com>

On Sun, Sep 29, 2024 at 08:21:03PM GMT, Alexander Mikhalitsyn wrote:
>Add an explicit MODULE_VERSION("0.0.1") specification for the vhost_vsock module.
>
>It is useful because it allows userspace to check if vhost_vsock is there when it is
>configured as a built-in.
>
>This is what we have *without* this change and when vhost_vsock is configured
>as a module and loaded:
>
>$ ls -la /sys/module/vhost_vsock
>total 0
>drwxr-xr-x   5 root root    0 Sep 29 19:00 .
>drwxr-xr-x 337 root root    0 Sep 29 18:59 ..
>-r--r--r--   1 root root 4096 Sep 29 20:05 coresize
>drwxr-xr-x   2 root root    0 Sep 29 20:05 holders
>-r--r--r--   1 root root 4096 Sep 29 20:05 initsize
>-r--r--r--   1 root root 4096 Sep 29 20:05 initstate
>drwxr-xr-x   2 root root    0 Sep 29 20:05 notes
>-r--r--r--   1 root root 4096 Sep 29 20:05 refcnt
>drwxr-xr-x   2 root root    0 Sep 29 20:05 sections
>-r--r--r--   1 root root 4096 Sep 29 20:05 srcversion
>-r--r--r--   1 root root 4096 Sep 29 20:05 taint
>--w-------   1 root root 4096 Sep 29 19:00 uevent
>
>When vhost_vsock is configured as a built-in there is *no* /sys/module/vhost_vsock directory at all.
>And this looks like an inconsistency.
>
>With this change, when vhost_vsock is configured as a built-in we get:
>$ ls -la /sys/module/vhost_vsock/
>total 0
>drwxr-xr-x   2 root root    0 Sep 26 15:59 .
>drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
>--w-------   1 root root 4096 Sep 26 15:59 uevent
>-r--r--r--   1 root root 4096 Sep 26 15:59 version
>
>Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
>---
> drivers/vhost/vsock.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 802153e23073..287ea8e480b5 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -956,6 +956,7 @@ static void __exit vhost_vsock_exit(void)
>
> module_init(vhost_vsock_init);
> module_exit(vhost_vsock_exit);
>+MODULE_VERSION("0.0.1");

I was looking at other commits to see how versioning is handled in order 
to make sense (e.g. using the same version of the kernel), and I saw 
many commits that are removing MODULE_VERSION because they say it 
doesn't make sense in in-tree modules.

In particular the interesting thing is from nfp, where 
`MODULE_VERSION(UTS_RELEASE);` was added with this commit:

1a5e8e350005 ("nfp: populate MODULE_VERSION")

And then removed completely with this commit:

b4f37219813f ("net/nfp: Update driver to use global kernel version")

CCing Jakub since he was involved, so maybe he can give us some 
pointers.

Thanks,
Stefano

> MODULE_LICENSE("GPL v2");
> MODULE_AUTHOR("Asias He");
> MODULE_DESCRIPTION("vhost transport for vsock ");
>-- 
>2.34.1
>


