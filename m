Return-Path: <linux-kernel+bounces-397126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 120E59BD70E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E111C2379E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC19215C6D;
	Tue,  5 Nov 2024 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="VFvcMAg9"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F5E213EEF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 20:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730838569; cv=none; b=CjOcodwuhL8p1hyVsqLMXZEulOvSnspG6uOOdSJMB6z4P+OPRmsoNURLQ8YCMsk2AL+RzAeaINOMrPcWXNxr1NbLAdepMvsl9NcjB/+a6pHYdxiBRXfNkpa4mHz3LD0+TSW5a7+9rbRY3jtOCvC3ARJpaSLbaj31wN7r/id15vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730838569; c=relaxed/simple;
	bh=d3dD1BAZxlbYeLGAcAe/6Ue5ouZ4MMP1Gn0DibkROqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5tqBEEYQmddfeoXffcixwBtbM/A7hMV2PG4c/t24iUiIC4gxmgMHNq8cV5016SUloxiDR9tzyltzvgZwpUtk8WysMX/UhxygrG0RYrwQNkIDdONw7aH7GRmOMThTApJYWTnIrBfSz2FIeX4vCwEDk1P88tNO1XmVyBgGY4QaL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=VFvcMAg9; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e3010478e6so4535230a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 12:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730838566; x=1731443366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TG+HKfsXVndr/dbdsEdQzVp/Dckr4A4PHVsSxF6U0c=;
        b=VFvcMAg9nXSNj7jeC3U8Ctj5Db+XxTRepT3ICnblil/L6pl2R/lKMSJv1Y9yliSGcN
         ++vbWC6tMq/NzWE/G2kshOF1tZmfouVL9ElIy7I7dfdTMCuUOIpMyJPGIOkWDjKiIFWj
         S0XlCdqks5aD6FXB9wL9wCgytap+lX0N4tMR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730838566; x=1731443366;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6TG+HKfsXVndr/dbdsEdQzVp/Dckr4A4PHVsSxF6U0c=;
        b=sD6Cz4vQhpiSd92l0Ic3fbApF2Hx1JiL+eXtCrric4eqSbcQHuSs7cy+wC4htCV4dG
         pLbBYRgHwiFVcgeP4RZMwAtedx1p8Y3IzKrdTA7xEd9Oz7nASoKQyWnmGhxv1iDIrZ/Q
         qNK6JlDA851W5IQXYEJGv5Ow4AIOQbgg39WfxyuTS6q2WBD9TQMP2ABY9fLD2FvMe7hK
         0ApOM9dByGoxu/k697x1JgMFRrlrvI4hXBdxwdin21FLbNizMtlzwr4kQ16EaGn5RpaV
         7Hu6CON+9xtU5dLFjTRxZG3n7mHfIjhsLbYerbXDcTgbnipDhDgIb226JnGBItpeXFQ8
         EjLA==
X-Forwarded-Encrypted: i=1; AJvYcCXP0aKfXkOZ2AdedPynFXWD7CE9EDRtkgut3x2z8e+K0Jw8tA8fjfoCCuMWQXdWfDFaGhiZ8v7IPaJYhc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz9Iw+oGUTjF9jS5ApBpXsqoYwCP/r9IzyO9W6H/FMF8cy4+DW
	y5pHYjNsvweG58bpBSve0vgVXGy2K6VXR+2aC1YnZ0z7vNVGdGEbfnJBfIAGANo=
X-Google-Smtp-Source: AGHT+IGpXvnQLdYM/eNUxgFErDh6D1tC1fH+hd2J2ncskN5f6MUlUmoouPD6XNorFgW/ypBKExow4g==
X-Received: by 2002:a17:90b:2781:b0:2e5:5e55:7f18 with SMTP id 98e67ed59e1d1-2e94c2e77f5mr25127221a91.24.1730838566657;
        Tue, 05 Nov 2024 12:29:26 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fbfb05asm12412856a91.48.2024.11.05.12.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 12:29:26 -0800 (PST)
Date: Tue, 5 Nov 2024 12:29:23 -0800
From: Joe Damato <jdamato@fastly.com>
To: Philo Lu <lulie@linux.alibaba.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew@daynix.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/4] virtio_net: Sync rss config to device when
 virtnet_probe
Message-ID: <ZyqAI--BgVBo1Kt1@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew@daynix.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
References: <20241104085706.13872-1-lulie@linux.alibaba.com>
 <20241104085706.13872-4-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104085706.13872-4-lulie@linux.alibaba.com>

On Mon, Nov 04, 2024 at 04:57:05PM +0800, Philo Lu wrote:
> During virtnet_probe, default rss configuration is initialized, but was
> not committed to the device. This patch fix this by sending rss command
> after device ready in virtnet_probe. Otherwise, the actual rss
> configuration used by device can be different with that read by user
> from driver, which may confuse the user.
> 
> If the command committing fails, driver rss will be disabled.
> 
> Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index acc3e5dc112e..59d9fdf562e0 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6584,6 +6584,15 @@ static int virtnet_probe(struct virtio_device *vdev)
>  
>  	virtio_device_ready(vdev);
>  
> +	if (vi->has_rss || vi->has_rss_hash_report) {
> +		if (!virtnet_commit_rss_command(vi)) {
> +			dev_warn(&vdev->dev, "RSS disabled because committing failed.\n");
> +			dev->hw_features &= ~NETIF_F_RXHASH;
> +			vi->has_rss_hash_report = false;
> +			vi->has_rss = false;
> +		}
> +	}
> +
>  	virtnet_set_queues(vi, vi->curr_queue_pairs);
>  
>  	/* a random MAC address has been assigned, notify the device.

Acked-by: Joe Damato <jdamato@fastly.com>

