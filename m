Return-Path: <linux-kernel+bounces-226991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4679146DF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5807B1F20F4B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A342C135A5B;
	Mon, 24 Jun 2024 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anTyDzlG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7B9130A79
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719223176; cv=none; b=UXrUm97wngGdntdaSA/Sy18Iq0JIskEPa4p/SVisk3ITnNDX2YoTQdeI/9vH88YlnpDcrhuHtRj9l1ODU2Lai6289lSKl5Ft30rmLfJjQQHUaJXDCvdv+u3SuZLxZWG2Qk95F7dVBqftm2ifw8WS40N8OgLzK2N68qOysBndBLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719223176; c=relaxed/simple;
	bh=8IRKD2VDK4RtOqMcQRev9Lu8Sns19P6qT0a8xgsE+Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oI2G3/PbqU90qy0G21B2YAToqf/k1RIzBZLOh1hlrSn4WbnuJ35tzyCB9JSGEXVZZ5KPrDGGkhKXKYUu6pI/gcBuHLamClP9TQl/wh6gnS+3h2Mbvyz2n16kLtBrHGr3OhehBh9Sst0T6Tum5ZrK0xXF5HGiOn5iRDuEwczJXak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=anTyDzlG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719223174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PwlMgaE8+kBE4Dvy2LlPLjnBZ3dnXU/5g0//YUxNCgs=;
	b=anTyDzlGzs5J9I3GCT+YOAGDgoDu7RCyHa7rgDBLbpLYn/G/EkXO0QNO6HvKC+mXq+uZKm
	ip9M6WwXIbmkRlQG+JA0HDRcyXUAtz8Kx8YiDKj+6KGfP/nwlUnja5xxdTL59gj6SLs2IW
	cqKC8j2pjOoQ66VGZn8HxnDeam2gRME=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-x3DuWd6PP6KNHU9CFNTEQg-1; Mon, 24 Jun 2024 05:59:32 -0400
X-MC-Unique: x3DuWd6PP6KNHU9CFNTEQg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52cd7e63b2aso1983536e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719223171; x=1719827971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwlMgaE8+kBE4Dvy2LlPLjnBZ3dnXU/5g0//YUxNCgs=;
        b=Kj4Bd8mbTLy30Es05h0zkANKQDorZpDRjJ6uQdDjBiVOBLlQWHegmBBbymxWDrrpGC
         ExMMnNPg5zszchmIa3tZl7V5Wghey5gdW7SCKiPfJpx89yJKTPCiN/+bcwBwVRdeVNpp
         BQH6Bf1TKVksh9rZygelryLqEnv/auPlvWvo1EllzDObKBrA6gUJHNSxEKMkJQog583B
         kZ+YXZPrvp7RPqLeGF+vDnDYYZ2n5LzG4/NybhcuDEUt3jyyHwaXiMoLp0yX3iJ6kzcz
         YbnDzvjm5A7nUrtaa4RsG9XbLTmX9iPVE+uGijjamGc6UszshiHeZvx0H9xcKNlXkh0L
         4gBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvIqBLXjo71IDMTx0bwZf5zXOEKbh4QgHhFYkPb3Ckfk3l65fZApSYW4Sdcjb0F7Z5fgm7C/ddjXU3jaHYsawKijS1QLvheOLAMCoN
X-Gm-Message-State: AOJu0YxgUsDXwa9ZrRvE8t1jNo/SrpgxnFRkAkrdvWjmqT49r+0+PY/H
	MigoVigHPgotjeBupZt/J7YCfk7qIVz3Wqo+ooCL2fMfnXytbaVhA+UX0ZgL/6EFpfmW+Kv/IIN
	uEyHm/v6qTvqvPMYwg+5aq2fd3wn0bibjCJoQB2yjGB9qXlx9sJagbjujbJ/7Og==
X-Received: by 2002:a19:c219:0:b0:52c:d5b3:1a6a with SMTP id 2adb3069b0e04-52ce061cedfmr2938793e87.28.1719223170738;
        Mon, 24 Jun 2024 02:59:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa9zU5lz/eJ4TII5tOUnKtVMjwizb2UTpSRF7P4MzTiK4ikVcABLfXc8Ps4KqAgiNvWG1Y+Q==
X-Received: by 2002:a19:c219:0:b0:52c:d5b3:1a6a with SMTP id 2adb3069b0e04-52ce061cedfmr2938775e87.28.1719223169992;
        Mon, 24 Jun 2024 02:59:29 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366389b8985sm9587026f8f.43.2024.06.24.02.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 02:59:29 -0700 (PDT)
Date: Mon, 24 Jun 2024 05:59:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: Re: [PATCH V2 1/3] virtio: allow nested disabling of the configure
 interrupt
Message-ID: <20240624054403-mutt-send-email-mst@kernel.org>
References: <20240624024523.34272-1-jasowang@redhat.com>
 <20240624024523.34272-2-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624024523.34272-2-jasowang@redhat.com>

On Mon, Jun 24, 2024 at 10:45:21AM +0800, Jason Wang wrote:
> Somtime driver may want to enable or disable the config callback. This
> requires a synchronization with the core. So this patch change the
> config_enabled to be a integer counter. This allows the toggling of
> the config_enable to be synchronized between the virtio core and the
> virtio driver.
> 
> The counter is not allowed to be increased greater than one, this
> simplifies the logic where the interrupt could be disabled immediately
> without extra synchronization between driver and core.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio.c | 20 +++++++++++++-------
>  include/linux/virtio.h  |  2 +-
>  2 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index b968b2aa5f4d..d3aa74b8ae5d 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -127,7 +127,7 @@ static void __virtio_config_changed(struct virtio_device *dev)
>  {
>  	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>  
> -	if (!dev->config_enabled)
> +	if (dev->config_enabled < 1)
>  		dev->config_change_pending = true;
>  	else if (drv && drv->config_changed)
>  		drv->config_changed(dev);
> @@ -146,17 +146,23 @@ EXPORT_SYMBOL_GPL(virtio_config_changed);
>  static void virtio_config_disable(struct virtio_device *dev)
>  {
>  	spin_lock_irq(&dev->config_lock);
> -	dev->config_enabled = false;
> +	--dev->config_enabled;
>  	spin_unlock_irq(&dev->config_lock);
>  }
>  
>  static void virtio_config_enable(struct virtio_device *dev)
>  {
>  	spin_lock_irq(&dev->config_lock);
> -	dev->config_enabled = true;
> -	if (dev->config_change_pending)
> -		__virtio_config_changed(dev);
> -	dev->config_change_pending = false;
> +
> +	if (dev->config_enabled < 1) {
> +		++dev->config_enabled;
> +		if (dev->config_enabled == 1 &&
> +		    dev->config_change_pending) {
> +			__virtio_config_changed(dev);
> +			dev->config_change_pending = false;
> +		}
> +	}
> +
>  	spin_unlock_irq(&dev->config_lock);
>  }
>

So every disable decrements the counter. Enable only increments it up to 1.
You seem to be making some very specific assumptions
about how this API will be used. Any misuse will lead to under/overflow
eventually ...



My suggestion would be to
1. rename config_enabled to config_core_enabled
2. rename virtio_config_enable/disable to virtio_config_core_enable/disable
3. add bool config_driver_disabled and make virtio_config_enable/disable
   switch that.
4. Change logic from dev->config_enabled to
   dev->config_core_enabled && !dev->config_driver_disabled



  
> @@ -455,7 +461,7 @@ int register_virtio_device(struct virtio_device *dev)
>  		goto out_ida_remove;
>  
>  	spin_lock_init(&dev->config_lock);
> -	dev->config_enabled = false;
> +	dev->config_enabled = 0;
>  	dev->config_change_pending = false;
>  
>  	INIT_LIST_HEAD(&dev->vqs);
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 96fea920873b..4496f9ba5d82 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -132,7 +132,7 @@ struct virtio_admin_cmd {
>  struct virtio_device {
>  	int index;
>  	bool failed;
> -	bool config_enabled;
> +	int config_enabled;
>  	bool config_change_pending;
>  	spinlock_t config_lock;
>  	spinlock_t vqs_list_lock;
> -- 
> 2.31.1


