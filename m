Return-Path: <linux-kernel+bounces-253767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1453E93269F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 370BE1C22D7A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFB619AA55;
	Tue, 16 Jul 2024 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0JQMNmh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78C91991D4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721133288; cv=none; b=m37Tk3iz4x21iSxjGW4EKGh3UM1X4WKkwzJgoP87VKW4WKsNlTBwHFSIgmLcd9z9Gx0qVX4+d9dt+JNKN4BH+LMI+BtaExML2mHhZkYHIR/AzFOxKH07dwv+pkbxNa6iXDtexc+empfYyHcpsr4BwhzdORp3D4fY0HdCwmAw8dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721133288; c=relaxed/simple;
	bh=UwvO1FF7MnvexBVJsbYqtV2A6b3qtyblV0xiJ3qOHn0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLEQVsXHRhLa0AEzts0gbKOW1Y+m5UdSqVROn5OjRw/9QUE1Nx6Hy82yJpYprgHxF7q9c8xgkWhngS589XslEj9ctpy6xGSghLcdEggdahJ8WGYkX/jjpIfjo3kM+mE6dB0pnMeyXGBk62osF5OBA7iSS6aKByQOuTnkrLKDT0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A0JQMNmh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721133285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmPFA9iny5K5WBu2KEPFzDMz5G8QExo99NmSardUinU=;
	b=A0JQMNmh1gOg8F/nd2m4IL53IBNLOpcAkBxs/vSWvu0OTO2unV4B0j36EUPjwkMT3rHbAp
	Gv3bbzN7hTd7vGAdGYx7t3tJLoqwPjNEfOJorxkUp6TqNCiU7MzgjKUC2WoU4ONnWttxld
	ZY44jdrxitRukNtHS04qdYWq7lu8kaI=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-JnwOGGHBOSqgHfFi4TejiA-1; Tue, 16 Jul 2024 08:34:44 -0400
X-MC-Unique: JnwOGGHBOSqgHfFi4TejiA-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-806199616d0so637999439f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 05:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721133284; x=1721738084;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hmPFA9iny5K5WBu2KEPFzDMz5G8QExo99NmSardUinU=;
        b=WZcEu8G1saIWBP15c80LfmblSQidJZtHXUu0yLTaKxqSWmqoS5URdAJHNKOYHJXC4O
         bBm0AbCAVvXmDs71890aEsaYXKiLa4XRxkwEJXw1qF41tq3t3o75CyMl1ohXaM/SXSCC
         ESXPFWDKYB9N8nn/USwAoFSIIi24t1lqpT++8EMQlJy5gFYlcd/ZolYMvR7aOFIG1Q+a
         zzU6pIe7igL+PEOW0Cu869vaXHr5lGiQUheaQzS5ueWqGNAp3+nFBV0X0778X9MX51ni
         18jMawU4W2lvFIb21eaetZEeJxbXfbrHV2rfKIlvWLKSiKg7020oPdgAzeDysiYZAby1
         F0VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGoKyrQkTDXzjE0vRJYsiMe1tnve/nYrub2Y8uO6GglVIGUbcvnp0MU4ZEYhn3npEBevcQYKYe8/8WFoiBTqsw3if3ezD3QnPMZu4G
X-Gm-Message-State: AOJu0YxOCbV3CA5o2xEeBowPWnnGmAkyze1g/VBzTsPF/MtMaH9BzrYF
	hXA+u0cVZUbypWJotEV2XH7mSxHhdORcBmyHGDrGwK1a8empJp2WCbmugt87jNZd8Kf19K5HB+N
	53FfMaCrD0TZOenhhrkY3QnLexQvMFY0ET5th6y5CgBFb8mf5aLVsNGqOX4q8Lg==
X-Received: by 2002:a05:6602:2cca:b0:805:2e94:f21f with SMTP id ca18e2360f4ac-81574540445mr278731739f.2.1721133283804;
        Tue, 16 Jul 2024 05:34:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx0v8ioi/ZYawS9SUY/Ip1EKV4weK8+lj35wr1o4vxKoM9NKhFCak+mtzECDC8UGRkfJBNgg==
X-Received: by 2002:a05:6602:2cca:b0:805:2e94:f21f with SMTP id ca18e2360f4ac-81574540445mr278729139f.2.1721133283485;
        Tue, 16 Jul 2024 05:34:43 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-80e115fc5f1sm188535739f.3.2024.07.16.05.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 05:34:43 -0700 (PDT)
Date: Tue, 16 Jul 2024 06:34:41 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2] vfio-mdev: add missing MODULE_DESCRIPTION() macros
Message-ID: <20240716063441.132d60bd.alex.williamson@redhat.com>
In-Reply-To: <20240715-md-vfio-mdev-v2-1-59a4c5e924bc@quicinc.com>
References: <20240715-md-vfio-mdev-v2-1-59a4c5e924bc@quicinc.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jul 2024 12:27:09 -0700
Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
> description is missing"), a module without a MODULE_DESCRIPTION() will
> result in a warning with make W=1. The following warnings are being
> observed in samples/vfio-mdev:
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in samples/vfio-mdev/mtty.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in samples/vfio-mdev/mdpy.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in samples/vfio-mdev/mdpy-fb.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in samples/vfio-mdev/mbochs.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro to these
> modules. And in the case of mtty.c, remove the now redundant instance
> of the MODULE_INFO() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> Of the almost 300 patches I've submitted tree-wide to fix these
> issues, this is one of the 13 remaining. Hopefully this can make it
> via your tree into the 6.11 merge window. If not, Greg KH has
> indicated he'll take this as an -rc instead of waiting for 6.12.
> ---
> Changes in v2:
> - Updated the commit text to more fully describe the problem and solution.
> - Removed the MODULE_INFO() from mtty.c
> - Note I did not carry forward Kirti's Reviewed-by: due to this removal,
>   please re-review
> - Link to v1: https://lore.kernel.org/r/20240523-md-vfio-mdev-v1-1-4676cd532b10@quicinc.com
> ---

LGTM.  Kirti, would you like to re-add your R-b?  Thanks,

Alex

>  samples/vfio-mdev/mbochs.c  | 1 +
>  samples/vfio-mdev/mdpy-fb.c | 1 +
>  samples/vfio-mdev/mdpy.c    | 1 +
>  samples/vfio-mdev/mtty.c    | 2 +-
>  4 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
> index 9062598ea03d..836456837997 100644
> --- a/samples/vfio-mdev/mbochs.c
> +++ b/samples/vfio-mdev/mbochs.c
> @@ -88,6 +88,7 @@
>  #define STORE_LE32(addr, val)	(*(u32 *)addr = val)
>  
>  
> +MODULE_DESCRIPTION("Mediated virtual PCI display host device driver");
>  MODULE_LICENSE("GPL v2");
>  
>  static int max_mbytes = 256;
> diff --git a/samples/vfio-mdev/mdpy-fb.c b/samples/vfio-mdev/mdpy-fb.c
> index 4598bc28acd9..149af7f598f8 100644
> --- a/samples/vfio-mdev/mdpy-fb.c
> +++ b/samples/vfio-mdev/mdpy-fb.c
> @@ -229,4 +229,5 @@ static int __init mdpy_fb_init(void)
>  module_init(mdpy_fb_init);
>  
>  MODULE_DEVICE_TABLE(pci, mdpy_fb_pci_table);
> +MODULE_DESCRIPTION("Framebuffer driver for mdpy (mediated virtual pci display device)");
>  MODULE_LICENSE("GPL v2");
> diff --git a/samples/vfio-mdev/mdpy.c b/samples/vfio-mdev/mdpy.c
> index 27795501de6e..8104831ae125 100644
> --- a/samples/vfio-mdev/mdpy.c
> +++ b/samples/vfio-mdev/mdpy.c
> @@ -40,6 +40,7 @@
>  #define STORE_LE32(addr, val)	(*(u32 *)addr = val)
>  
>  
> +MODULE_DESCRIPTION("Mediated virtual PCI display host device driver");
>  MODULE_LICENSE("GPL v2");
>  
>  #define MDPY_TYPE_1 "vga"
> diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
> index 2284b3751240..b382c696c877 100644
> --- a/samples/vfio-mdev/mtty.c
> +++ b/samples/vfio-mdev/mtty.c
> @@ -2058,6 +2058,6 @@ module_init(mtty_dev_init)
>  module_exit(mtty_dev_exit)
>  
>  MODULE_LICENSE("GPL v2");
> -MODULE_INFO(supported, "Test driver that simulate serial port over PCI");
> +MODULE_DESCRIPTION("Test driver that simulate serial port over PCI");
>  MODULE_VERSION(VERSION_STRING);
>  MODULE_AUTHOR(DRIVER_AUTHOR);
> 
> ---
> base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
> change-id: 20240523-md-vfio-mdev-381f74bf87f1
> 


