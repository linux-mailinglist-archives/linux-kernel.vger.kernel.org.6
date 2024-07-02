Return-Path: <linux-kernel+bounces-238359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D45C9248D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1419AB21AC4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B5C200139;
	Tue,  2 Jul 2024 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PobfWWYd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0128F1BD4EF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 20:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719951256; cv=none; b=a04jifKMmA5JIISiySDI70E/ZMdK4EDJVJN+WlejXKQhRpVP8aTG9wtpjoFNO6QQtWWS+oBKwGa8JS0ZsXXI6OYkWNEq4+Bf5m9Rlt4i12/wukpWJ01LDyBFblJO2SkbOKPsFLYwaLjETKO9QbRWTpcGfEqViTULpV2rGAlZ1t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719951256; c=relaxed/simple;
	bh=6yQX24i0j5POCJvd/ZR1KFxvOAs2rK2wuTtDubWxa24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFeqHDj4O9sh/QMpt3d/O1/DLg3x0qhb0lKoDUQlgQ6qRmLVHPMpltt6aWrXA2tOoAL5DHZYDdji8szu8CHnxHxO/891GT45uKgYfKrqVvnb4lxji9Os7V8e/CibQLcEWfM4MRfCnronkcHlTTnzDfDlTtRZ1LasDXJeeqmuLDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PobfWWYd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719951253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fBu7ePDVo++7D4IjJbMnU5rjjRnV5+agERHDVqnqF08=;
	b=PobfWWYdItRFIUAKiekTXIDlSFNitlhpdxu/gjXfgJ4/crhfMwVdQ2D5vmW0tcOiFvMmsl
	xg9e8p8BdnD154+U7No91El1Yjl1ExbWUyifow6/QgkYGBAXDMSh1aucc7i8S8hzAcghRr
	jFyCcbnkLDrCwtettAD6+HM/7muY6Ew=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-UCZzHcZWNomj7qEdP3F5iw-1; Tue, 02 Jul 2024 16:14:10 -0400
X-MC-Unique: UCZzHcZWNomj7qEdP3F5iw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4256569a4faso28941435e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 13:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719951249; x=1720556049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBu7ePDVo++7D4IjJbMnU5rjjRnV5+agERHDVqnqF08=;
        b=mW5kIC7R4BfMnXEByugH9do8iwm7Rbvy+fh5RNsuu19myccIsuvDwd+mQUhnBBx1oh
         c4+alANf/Ol06Q5/3nrnWkBDeQZVqHQ0BICHJWKl/mwcI1/pXaSBNUbH7YHa9Pa8PN+v
         LR/g2+935OT+IiKqbIF3SFwb85F1cjGtStxQ0lnuN1UKFCZmSBRcuy51g50jhsJcr+Bs
         MnGmLFFRq0yJpeSAZaZbjcgC4Uk44kn34GACQojv0vCRQt8uC+6euTCZhVMGXGY0h/2H
         oX2TKT7hF+5OUULzRxsP0qYuxuiAZu+a6WMmNQmWcIu/wnK3KMTAMwomeaHqvGpULaQU
         kmbA==
X-Forwarded-Encrypted: i=1; AJvYcCXUz7/c1k8iNGXUkI6BtK01tKLNntxOGTFznEyq5aY7m192KnGVSTHXucHo7g4wwpiBjpIBFCmu65v+cdgnDwCrSYPVcBb28ashqrYj
X-Gm-Message-State: AOJu0YxFWN+2z9AWi2z3m0i0IWXghfMFB0E+GB8e34ZpdT7XP7xYNHjN
	sUIhSPRZ6ye9SccF8NdbDlACV9QLC8qOSfYzvcLYJpyTu+gQF96Tc1lM6O715jGObxQWGiouZGj
	ie5cZpek3prwGlJvIELF/o0nVZRxVWcQTlkEDcwkPF1kjkQM68uJIa0P6QkZV8w==
X-Received: by 2002:a05:600c:5113:b0:424:8836:310c with SMTP id 5b1f17b1804b1-4256d4d3063mr114936105e9.5.1719951249213;
        Tue, 02 Jul 2024 13:14:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3yYy+Pj4KvbuOhw9OhwaRAp+IJ09cqGiSTJv3EMe94RolCEIKpfHnntszHbV+PrhqoxF3tA==
X-Received: by 2002:a05:600c:5113:b0:424:8836:310c with SMTP id 5b1f17b1804b1-4256d4d3063mr114935935e9.5.1719951248617;
        Tue, 02 Jul 2024 13:14:08 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af376easm210890935e9.5.2024.07.02.13.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 13:14:08 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:14:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] virtio: add missing MODULE_DESCRIPTION() macros
Message-ID: <20240702161350-mutt-send-email-mst@kernel.org>
References: <20240702-md-sh-drivers-virtio-v1-1-cf7325ab6ccc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702-md-sh-drivers-virtio-v1-1-cf7325ab6ccc@quicinc.com>

On Tue, Jul 02, 2024 at 01:10:18PM -0700, Jeff Johnson wrote:
> With ARCH=sh, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/virtio/virtio.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/virtio/virtio_ring.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

tagged, thanks!

> ---
>  drivers/virtio/virtio.c      | 1 +
>  drivers/virtio/virtio_ring.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index b968b2aa5f4d..396d3cd49a1b 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -609,4 +609,5 @@ static void __exit virtio_exit(void)
>  core_initcall(virtio_init);
>  module_exit(virtio_exit);
>  
> +MODULE_DESCRIPTION("Virtio core interface");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 2a972752ff1b..1cac7d5b3062 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3244,4 +3244,5 @@ void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq,
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_device);
>  
> +MODULE_DESCRIPTION("Virtio ring implementation");
>  MODULE_LICENSE("GPL");
> 
> ---
> base-commit: 1dfe225e9af5bd3399a1dbc6a4df6a6041ff9c23
> change-id: 20240702-md-sh-drivers-virtio-704eb84769cb


