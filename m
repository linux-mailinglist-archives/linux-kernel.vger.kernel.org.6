Return-Path: <linux-kernel+bounces-528341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EBEA41684
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8083AD83B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3C6205508;
	Mon, 24 Feb 2025 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tvg3BVkE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7E618D65C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740383357; cv=none; b=d1N3Tzbycg2lPI8u29zzoha3no+8DK8cg4o9KCHRzY32xP+X8WFf0T4iYrPkWsMet6a9d/JAP5vpVxH0XWpg6HTPYTHRWiE58q6xJ6BO0mkwzq/facyEv7dj6gO/WLAsy8BqMc9xpOFLGvGkmnVMiAbY2Swb7yO0WDyBzTxamLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740383357; c=relaxed/simple;
	bh=xStK9CH4TU3I3+rtYUJpOH1tSFucpQmlqd3Apil2Wjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FkVRT3MUgpBHcYGnjhuJz8fTxtZSxvLZ5Y16dsD48kEPdiv2Nl+Fjr/Xsel3zc4Wd3PQ+cOVL4f/b58Mo+Hh5sexOZDbATk0mVm2wf9lJH93CVpzTLrJU3hT9u6bcN/PeympPwil/t2mcnwF+VBjb3hyRq8ABDdXkpuo9KJTKqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tvg3BVkE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740383354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E00VN6HxPgl9KvZBGjXBkxL6RT0gnJ7DSIyLW3UOh1w=;
	b=Tvg3BVkEF9U+5+aaMI5OjsxOWN/ViYl+KIDvtcOEZZI7NYY/OSRDdOFJEZ7WR6HXyS4OcF
	AxA3WPqb0p/8wXlTEAs2Fr6P9xXpgaCVzE/h/az26tPTZjwyC2Tzkx3eU/k4H4J1vclPKe
	FhFrZdsceSK6pJmrJgbamNgkbCtTIGU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-Al5J54byOeydcsU83W_OVQ-1; Mon, 24 Feb 2025 02:49:12 -0500
X-MC-Unique: Al5J54byOeydcsU83W_OVQ-1
X-Mimecast-MFC-AGG-ID: Al5J54byOeydcsU83W_OVQ_1740383351
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43935e09897so29068875e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 23:49:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740383351; x=1740988151;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E00VN6HxPgl9KvZBGjXBkxL6RT0gnJ7DSIyLW3UOh1w=;
        b=TOULRAhPbIxohqkrcJpQg1MIOKMWzl/m3mLkywsesCnBWEk/ZIPhPqUFWTE5R71J7j
         CsEmI/c0XC2qZ6LPL1FZt72PanPBuGF5gAzd1RAWKgKW5W8Wm9DARkJHjp5I6Ukq+ShG
         +w5f3q7bRxdzGAN/jZf+4v51mu/7WPmYZ3yEZ/uSKZs7cyk+uN3OFeftET/yLAgUfLui
         SG110q2cVtDvHwKa6bV3s4xo3Q4aku40sDNUXLspvdHj3jinP/rN8koxgZRSm6eKZ9Jq
         5qd4pFWIktFheTqpqzFQ5CxR7hheZcA2Wlk2uSTmeeqGfrf4pXy5rh4+z4vTJfXcu21u
         2jlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF+miDnKSMbVKemeGkgfjkNkGLDyLdwmK3iyWbbKn+pV00K64+fnTFcaWH2GaBKwNTf38pTiM3RKN4tLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz+0V+7HmFwsEw0ab6Wlo4vsD3C0jesKlVt5BJWPS9WuW15NI3
	WyZ5vjnvaX0fP4w520APepc/aZa4cJL9XHZowJhcofOIq60PfpfOZzRIxwsy5qZO9UoqmeqJzuX
	/7yn41vJg28libEIrhJ8IN0GJjUG03R2jpxdM8kluSYTjiYpPE9WvNIINUDu7Bw==
X-Gm-Gg: ASbGncvnzQkvrTBK8R1XEe4LyPBfqlDI5s22w02Abm+OXRo4Kh4XXxghc9Ql68As6Xs
	p9cXoRe5j/+n5MULbjsfg6pmcXZ3sRHJtVHOxhJitp/P3HshTlDgcLCzlFuOvhUglFUhBRYu9pj
	V/FGDFb+Dk/Op2C27e1k0PYyQa/9QmKXVg9H1VMhhSvd9Cxup4hmqo4Dpe9geSx1eVtaZgeqRrT
	Pvm1549X1uUKucmOwOUbDE5p97Mq2QguECGiHyC7zyD0yqYWl3sMbYYALYKrRydBzEFUo2uGeNT
	kHR699ZDfVm478VLLRyVMAvt+K2GII9ndHBjh7893vD0TYkugAJ3lOewlQ==
X-Received: by 2002:a05:600c:4fd3:b0:439:9543:9488 with SMTP id 5b1f17b1804b1-439ae2196a6mr79412485e9.21.1740383351205;
        Sun, 23 Feb 2025 23:49:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrYr6P7ROjGu/VT+mFoE6+CidQWRd3kw5YrS7WdRG0vovSVW/3wpDXzVzz04F1ymunuqV9nQ==
X-Received: by 2002:a05:600c:4fd3:b0:439:9543:9488 with SMTP id 5b1f17b1804b1-439ae2196a6mr79412305e9.21.1740383350822;
        Sun, 23 Feb 2025 23:49:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b030be6fsm97665715e9.31.2025.02.23.23.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 23:49:10 -0800 (PST)
Message-ID: <7fa37894-7d73-4087-a849-2957f31ad7f4@redhat.com>
Date: Mon, 24 Feb 2025 08:49:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: break and reset virtio devices on
 device_shutdown()
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Hongyu Ning <hongyu.ning@linux.intel.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 virtualization@lists.linux.dev
References: <c1dbc7dbad9b445245d3348f19e6742b0be07347.1740094946.git.mst@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <c1dbc7dbad9b445245d3348f19e6742b0be07347.1740094946.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Michael,

On 2/21/25 12:42 AM, Michael S. Tsirkin wrote:
> Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
> accesses during the hang.
> 
> 	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
> 	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
> 	...
> 
> It was traced down to virtio-console. Kexec works fine if virtio-console
> is not in use.
> 
> The issue is that virtio-console continues to write to the MMIO even after
> underlying virtio-pci device is reset.
> 
> Additionally, Eric noticed that IOMMUs are reset before devices, if
> devices are not reset on shutdown they continue to poke at guest memory
> and get errors from the IOMMU. Some devices get wedged then.
> 
> The problem can be solved by breaking all virtio devices on virtio
> bus shutdown, then resetting them.
> 
> Reported-by: Eric Auger <eauger@redhat.com>
> Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks!

Eric
> ---
>  drivers/virtio/virtio.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index c1cc1157b380..e5b29520d3b2 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -377,6 +377,36 @@ static void virtio_dev_remove(struct device *_d)
>  	of_node_put(dev->dev.of_node);
>  }
>  
> +static void virtio_dev_shutdown(struct device *_d)
> +{
> +	struct virtio_device *dev = dev_to_virtio(_d);
> +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> +
> +	/*
> +	 * Stop accesses to or from the device.
> +	 * We only need to do it if there's a driver - no accesses otherwise.
> +	 */
> +	if (!drv)
> +		return;
> +
> +	/*
> +	 * Some devices get wedged if you kick them after they are
> +	 * reset. Mark all vqs as broken to make sure we don't.
> +	 */
> +	virtio_break_device(dev);
> +	/*
> +	 * The below virtio_synchronize_cbs() guarantees that any interrupt
> +	 * for this line arriving after virtio_synchronize_vqs() has completed
> +	 * is guaranteed to see vq->broken as true.
> +	 */
> +	virtio_synchronize_cbs(dev);
> +	/*
> +	 * As IOMMUs are reset on shutdown, this will block device access to memory.
> +	 * Some devices get wedged if this happens, so reset to make sure it does not.
> +	 */
> +	dev->config->reset(dev);
> +}
> +
>  static const struct bus_type virtio_bus = {
>  	.name  = "virtio",
>  	.match = virtio_dev_match,
> @@ -384,6 +414,7 @@ static const struct bus_type virtio_bus = {
>  	.uevent = virtio_uevent,
>  	.probe = virtio_dev_probe,
>  	.remove = virtio_dev_remove,
> +	.shutdown = virtio_dev_shutdown,
>  };
>  
>  int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)


