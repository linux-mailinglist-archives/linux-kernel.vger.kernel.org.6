Return-Path: <linux-kernel+bounces-279413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C84094BD05
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB3D1B20FCD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30D018C348;
	Thu,  8 Aug 2024 12:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MOQaHrQ/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4041E18B494
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119047; cv=none; b=nZW1fKrYbs1jcyaq2N9thMY38TLgbr/F2TMw9Vmg4iQAY7FyZmiXZk13mRxJAl6KDqxc0FhGGN+7VEXBpunZFu86qwoYortojiQO7mT3deXyjA2oZdynypvwa1aO3/X/Hqz3wa/CDMqDnB3Gg1DIZ8ajabVcf6UeerOt6g9I9oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119047; c=relaxed/simple;
	bh=9bc7aDzprpbcgS4WFLHvkOB53uMBGrapeaVhrEf3Z7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYMQkf/7bKxFoif/c63sF/38OkluM7AHwlrb4X8mv5CRvGuzkI8/NZhPlIqcS6ySsAWFrOIo/N4lB7GEEYbEwal6FQwX+vThqVHeEUflNmoEbKmYv8QJ6SfCWo+BJZ8OFnLM1dJC2J3k6W4vcmBMlumukrgBNp4243I1ZEJVLxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MOQaHrQ/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723119044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1M/Bbzbm2m4qddYa34fpB/kjEFz/ogrNcSTJJcSrSIw=;
	b=MOQaHrQ/MZAZf5pAUfup/zVew2rP7fbGq/oaWI64OCPX4yHv+h18OwfBGlQOS32hEloPPE
	HSSgGMPIPulS/iMlF0U2zT9KOlCXiP8yirY1L2dzb2UUH27eZuu+7v12pe2uw+3Eu/KN6Z
	p81y4j+/6EpVWoIC+qLZF1NeuLDjV9I=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-jVwjj3QSMVe08phNXgXeWA-1; Thu, 08 Aug 2024 08:10:40 -0400
X-MC-Unique: jVwjj3QSMVe08phNXgXeWA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5a16fae2ba7so588008a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 05:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723119039; x=1723723839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1M/Bbzbm2m4qddYa34fpB/kjEFz/ogrNcSTJJcSrSIw=;
        b=rd9oHI+GLHu8Vu9JosgNjG30pumfHga2u6SKH3pxIw+4Fe8yKJO4L8+cGSY522qPUz
         hWVRCu2AF2QU99RoBZu49FHRomZVw6rOmT/2y+fV9afO+meGgs/rV/WjIu5PBWUz88+l
         wQwYSFDDuHk9A8aHXfi/5410weAm+s8KDsS/Iwx4xmaCgDRuuUNVoXWcPq3JIsp/kM7J
         bCEi0kKw8NlWhpxG1Aw1D/YHjFz/iOAXH7CXlIdogqpLtG95VHWuGpIINQjSZ3bkSkR1
         aLu1nJQ3SXuGDzJkhWSKIgbMPhItd9m7MLmyYi/1n1kX5Sl3+vhJWTD7C3jhyexi+18j
         LIbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXuij5Th4be9vCjE/F/IxiwzC23o60WYIeTFc7+MFtlj1RYlRODVoevJi0RyojTqVD+maeArxjb87mqjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YykGvTyoZFdhNEl/KmGY19XZt2/NCV/8o8STuZXU4ppBXA6d/Cb
	QaUa/8LDetCQSCAhtEahqNX2nodOBMQjxy22cAWKS6IWeG5ep8GNjVgudnITVgHYzd/ezbYSVlY
	RbD41GTeihq3krQCytgIB3hOhsbp6jhh+psoIecF36QD5JmbwwNdxs76ebXOqRQ==
X-Received: by 2002:a05:6402:2803:b0:5a1:24fc:9a47 with SMTP id 4fb4d7f45d1cf-5bbb23decc5mr1357331a12.27.1723119039469;
        Thu, 08 Aug 2024 05:10:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLx/yjqoXNv7pgu3Db5bjZDcuVQRkJcyOheFnVizNfuaxPT8z3LRIP3msZG+5UgTn6kRv+YQ==
X-Received: by 2002:a05:6402:2803:b0:5a1:24fc:9a47 with SMTP id 4fb4d7f45d1cf-5bbb23decc5mr1357292a12.27.1723119038645;
        Thu, 08 Aug 2024 05:10:38 -0700 (PDT)
Received: from redhat.com ([2.55.14.119])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2bf841asm564212a12.5.2024.08.08.05.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 05:10:37 -0700 (PDT)
Date: Thu, 8 Aug 2024 08:10:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hongyu Ning <hongyu.ning@linux.intel.com>
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
Message-ID: <20240808075701-mutt-send-email-mst@kernel.org>
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>

On Thu, Aug 08, 2024 at 10:51:41AM +0300, Kirill A. Shutemov wrote:
> Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
> accesses during the hang.
> 
> 	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
> 	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
> 	...
> 
> It was traced down to virtio-console. Kexec works fine if virtio-console
> is not in use.

virtio is not doing a lot of 16 bit reads.
Are these the reads:

                virtio_cread(vdev, struct virtio_console_config, cols, &cols);
                virtio_cread(vdev, struct virtio_console_config, rows, &rows);

?

write is a bit puzzling too. This one?

bool vp_notify(struct virtqueue *vq)
{       
        /* we write the queue's selector into the notification register to
         * signal the other end */
        iowrite16(vq->index, (void __iomem *)vq->priv);
        return true;
}
        
> 
> Looks like virtio-console continues to write to the MMIO even after
> underlying virtio-pci device is removed.

You mention both MMIO and pci, I am confused.
Removed by what? In what sense?




> 
> The problem can be mitigated by removing all virtio devices on virtio
> bus shutdown.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>

A bit worried about doing so much activity on shutdown,
and for all devices, too. I'd like to understand what
is going on a bit better - could be a symptom of
a bigger problem (e.g. missing handling for suprise
removal?).




> ---
>  drivers/virtio/virtio.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index a9b93e99c23a..6c2f908eb22c 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -356,6 +356,15 @@ static void virtio_dev_remove(struct device *_d)
>  	of_node_put(dev->dev.of_node);
>  }
>  
> +static void virtio_dev_shutdown(struct device *_d)
> +{
> +	struct virtio_device *dev = dev_to_virtio(_d);
> +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> +
> +	if (drv && drv->remove)
> +		drv->remove(dev);
> +}
> +
>  static const struct bus_type virtio_bus = {
>  	.name  = "virtio",
>  	.match = virtio_dev_match,
> @@ -363,6 +372,7 @@ static const struct bus_type virtio_bus = {
>  	.uevent = virtio_uevent,
>  	.probe = virtio_dev_probe,
>  	.remove = virtio_dev_remove,
> +	.shutdown = virtio_dev_shutdown,
>  };
>  
>  int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)
> -- 
> 2.43.0


