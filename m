Return-Path: <linux-kernel+bounces-255573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB8E934262
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE09F1C21008
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84FB184135;
	Wed, 17 Jul 2024 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKKhjptQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0921D183071
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721241899; cv=none; b=nrzqInFeecl+R7utyrz17/D1GJV649/rs2s1vnYYYngSBUofURazIOUqXpy8/OwUPXggsLS2LyG9YD+1jnXdIDeOahzN7q89eI5eIxKlWj6DHASYFwqB8cHEUMLtAqImiZcHZE81byID0XsWlHQY87Afq4Byd+2j4jGOZoMlH2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721241899; c=relaxed/simple;
	bh=ZBrhag/Adb6DC9FRa1byQRim407U3nUqBDVbASRI9ok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UsaKwzdPfzFtjWgTOLxwDx9QPSTNwFWTySvRjnTT4547fCPGSmRQA5ifHsUulECWr3Dt8w6CqIdZWv07GqEI6VlIZFuzfBUnekuppgKfjtOrc9TFxNPL16cv+L6/5DJZowj+GM1cxVF6C2M1RvJMXMJJ8d7KR78+MLxWeYQg/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TKKhjptQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721241895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wnOwiKe1/U2oSA4NsrBTg8a4NW8yOXIUAsKOLfMGmU=;
	b=TKKhjptQ3G4OKuTNJs4LUcvybJXQBvrjtpyQHEisSgtcCYo9gvkaRUtFNTkaia/qt7Avxe
	2YULXgYa29AUfEt31xsGCl2qudZQOIOQgzy6qmj7+c2+abP+5XDKUnqNK6V11fMoPutsGw
	mpZN8OMvAkOr4p4p9QaP2RDjKGc8Cy8=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-KKvxbbw5P3-sHjhbrlWz_g-1; Wed, 17 Jul 2024 14:44:54 -0400
X-MC-Unique: KKvxbbw5P3-sHjhbrlWz_g-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-386a31aca51so20510255ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721241893; x=1721846693;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/wnOwiKe1/U2oSA4NsrBTg8a4NW8yOXIUAsKOLfMGmU=;
        b=IIbSb1xQ7uYxC8IAi9goDx1FRds7DoKZTiLvFERmLcWYnekyRPPcCNx17V495B1+WA
         mmO4uiVIPaAm5xCu+Kk1nqIx0bunsu+EejGiYNzbidgXOV9sI41sWRDS3ysxcFR/w9gK
         XE82c9kzYgllS92K7fKQg6eAhgmia1LG7j4q2p5iNUkDuMcEqU1mPnK8vL3oQketkgb2
         LqpiUJN073utOR+0yQvm+JTfUexUZi30Y7RE5jnBVDKHf0B3xs2DhYumhGqffhOarz7I
         MJ1MzHr0kwL4qTwmngOfkS99tPKBu1qIq9u69XSb8AAqbYeZWvjzLChEe4/SJauhGW0O
         8pwA==
X-Forwarded-Encrypted: i=1; AJvYcCWnxH03CfGsm1Sm7rhATSrn+BUxCbnp7XtusEBreKUJxYCoiQpy6biwNnBuuQe4WmXvv8eMXE5xHaJ8/87zVB/VxYaSbvhNnvzmt4I3
X-Gm-Message-State: AOJu0YzioHW8GYYA94bIa6aGrAVT9LaXh54hT/GE/EVQzvJGgj8+TKxi
	sXaQ+JOje/d6aLtpuPp8/RcPa88Cpw9iBfE9RgWCRDr8POahnWwKovrLgeUwEdx19kPp6tG2SGS
	X9NU/I9cVAqye+azC/KdprWFaAibvrVqAFI5f9D0rCQ8PKpXULvFmsWYs4K/5kQ==
X-Received: by 2002:a05:6e02:1887:b0:382:325c:f7c0 with SMTP id e9e14a558f8ab-3955533241amr37519295ab.5.1721241893525;
        Wed, 17 Jul 2024 11:44:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN8GMb3cyoTVdIUXgw3VLIvcC09SJpv5sExfgbI0hJcCZC98+oNUTyhHDEgK0eZgYz7uSfuw==
X-Received: by 2002:a05:6e02:1887:b0:382:325c:f7c0 with SMTP id e9e14a558f8ab-3955533241amr37519055ab.5.1721241893080;
        Wed, 17 Jul 2024 11:44:53 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3950aee03cesm9514595ab.15.2024.07.17.11.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 11:44:52 -0700 (PDT)
Date: Wed, 17 Jul 2024 12:44:51 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kirti Wankhede <kwankhede@nvidia.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2] vfio-mdev: add missing MODULE_DESCRIPTION() macros
Message-ID: <20240717124451.52af6596.alex.williamson@redhat.com>
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
>  samples/vfio-mdev/mbochs.c  | 1 +
>  samples/vfio-mdev/mdpy-fb.c | 1 +
>  samples/vfio-mdev/mdpy.c    | 1 +
>  samples/vfio-mdev/mtty.c    | 2 +-
>  4 files changed, 4 insertions(+), 1 deletion(-)

Applied to vfio next branch for v6.11.  Thanks,

Alex

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


