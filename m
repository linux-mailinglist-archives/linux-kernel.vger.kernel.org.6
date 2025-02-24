Return-Path: <linux-kernel+bounces-530119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE663A42F52
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB283B0096
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDFC1DDC37;
	Mon, 24 Feb 2025 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZVb/A5s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0F6469D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433304; cv=none; b=ZG+YhJ6PqT06tSdg+3g//g2WqJ95zI9QWw9jf4SbceoKNkBh5rk31moN8I8kVl+F9qGoxqwLYqjrxLQ1djN1nFJDXmZc0PnZJR1aA3qM9G0jGbHEt/rl2i89TwUAJifWNadp4FhXN9qeYY2q6BgajVV/u3Hb6N7aGXOVPam6XC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433304; c=relaxed/simple;
	bh=61F3yXXy+T55QgXGolvQLQ63nKYT11qrytRHapc3erE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLqwd/fB0PeqC1Vvf+MWWk3CKJPyJ+h3+E0twP0dhhlnZsIxha5aX/6ms6wPHWau+wtT7bGpbfKHwb7rlxfQPmc2bG1Tw+i9TxAlWlXuyIx/j36y9mzj70lVkZbJMRJjAurADHpQp6DWczdZCzKOAnPGZ362MzPJkzoVpaIyFX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZVb/A5s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740433301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L6HqPHsnfVa2C7Dq998EVFw1DlYFaKT132e9r5oyBLs=;
	b=FZVb/A5sdg7cqYyN2CNkkD28J2+84qaaEA0sUwiQrZ6QYSlOPF3AgiAWvuVeP8jr1Skigu
	iRhuv6t72LK8XLf7lZcrrqTALurn/Htiv0HFacMtL1HRjihREc0xxA/7KY74tJR4tbCKkx
	iy7NGGIKd/VoLPPlzJK/lEmRYd+SUjE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-wUegrxcgOA-Vq6_m39r_yg-1; Mon, 24 Feb 2025 16:41:38 -0500
X-MC-Unique: wUegrxcgOA-Vq6_m39r_yg-1
X-Mimecast-MFC-AGG-ID: wUegrxcgOA-Vq6_m39r_yg_1740433297
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-abbaa560224so466637566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:41:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740433297; x=1741038097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6HqPHsnfVa2C7Dq998EVFw1DlYFaKT132e9r5oyBLs=;
        b=iUjsEI+MdHUp90WA1dLDDYXJWTIQY+9zAESOoQsj94EnvxgBTVSa2/AcW43iI2aRWx
         FbMH8vrP1VEVH3kHy6Sc8CKl08WhUzkLnkd5lM4nUJKHPtmWrEerqQaGQ9OC0qHXk6AH
         41YN8HdTU2HPjOl9VSNUxPa1qFkH6OCFDSl0RrfdIcYRDodvu8LAohXg0Us5EA64fCdy
         sbaxoCeHek+Yd4k/SjoSsa0glcFGS4QqCf9ditjHkslhcYruM2vCpu6ZMnmXTNUmoY9I
         wiWSa5ND3TJr21zEaLzAHn4TcNKDg9jn+tDwCnCqQapNzHOZfJa7zUsVGkfq1AhA6YqG
         6zug==
X-Forwarded-Encrypted: i=1; AJvYcCXIsZNnGZWQsrtQo9QqInVFvWCzISQRTc0sXpPv8z0/W4ByQiI2azyxEJRFLweMXdqHm1lFjOU4/9VL4BA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpdK+YaI0cowecLbV52I1pFvq4jemnywZhkqxJc3qgwJ1RptRr
	f08B1axYzddD1xYEk+ZXu9V6qNCN1oXSrYoTlzL2qx1tTHdVtgh4NDQm3G5Qklq2b9NJKSXfjJc
	I40phq8w1U0HkwlFnGrJMmlGMahn6Qj1CcES8Gf0fVgY0noFbXRnyWiQHx0aQ9Q==
X-Gm-Gg: ASbGncvRn62PGlvmACl5JXr2pJTFnbSGNDC0gmrKsxPYwT7DTOmKx3EQUyCQZ0WHm/y
	AE+R5Y8I6yzUkVEL3RX/NAPXZnxTQZOffzxbH2kucCM49dXtIor+/I2AN9qGQFYDWPu+Lqxig0c
	ioS7mZVT/+xAxwHi51W1YHnj55kwCr1A1B6SOlgZ67aUUh25IVE+dt3CwAuYktha2QmL/wwgnFH
	2KrACBJYwec4Q+hEE0PTAMgKRcZrn5bP4MaIlR8YBo5FLANptb7+y3VRNpEQwDXsfindYExt0eo
	lIBKxXLtug==
X-Received: by 2002:a17:907:7e93:b0:abb:6b1a:7b22 with SMTP id a640c23a62f3a-abc0da3b46fmr1564833466b.29.1740433297517;
        Mon, 24 Feb 2025 13:41:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFi78TPozmZYZWNhXigwkXxbfsfc+pSqjPGxh0riHc6R17GvlYa9/Usr+cmEeQtdzW8YiMJ5g==
X-Received: by 2002:a17:907:7e93:b0:abb:6b1a:7b22 with SMTP id a640c23a62f3a-abc0da3b46fmr1564830266b.29.1740433297089;
        Mon, 24 Feb 2025 13:41:37 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:441:1929:22c5:4595:d9bc:489e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20b8194sm25573066b.176.2025.02.24.13.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 13:41:36 -0800 (PST)
Date: Mon, 24 Feb 2025 16:41:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 5/6] vhost: Add new UAPI to support change to task mode
Message-ID: <20250224164027-mutt-send-email-mst@kernel.org>
References: <20250223154042.556001-1-lulu@redhat.com>
 <20250223154042.556001-6-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223154042.556001-6-lulu@redhat.com>

On Sun, Feb 23, 2025 at 11:36:20PM +0800, Cindy Lu wrote:
> Add a new UAPI to enable setting the vhost device to task mode.
> The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> to configure the mode if necessary.
> This setting must be applied before VHOST_SET_OWNER, as the worker
> will be created in the VHOST_SET_OWNER function
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>


Thanks Cindy,

can we add a KConfig knob to disable legacy app support?

It can be handy for security.

Pls make it a patch on top.

> ---
>  drivers/vhost/vhost.c      | 24 ++++++++++++++++++++++--
>  include/uapi/linux/vhost.h | 18 ++++++++++++++++++
>  2 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index d8c0ea118bb1..45d8f5c5bca9 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1133,7 +1133,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
>  	int i;
>  
>  	vhost_dev_cleanup(dev);
> -
> +	dev->inherit_owner = true;
>  	dev->umem = umem;
>  	/* We don't need VQ locks below since vhost_dev_cleanup makes sure
>  	 * VQs aren't running.
> @@ -2278,15 +2278,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  {
>  	struct eventfd_ctx *ctx;
>  	u64 p;
> -	long r;
> +	long r = 0;
>  	int i, fd;
> +	u8 inherit_owner;
>  
>  	/* If you are not the owner, you can become one */
>  	if (ioctl == VHOST_SET_OWNER) {
>  		r = vhost_dev_set_owner(d);
>  		goto done;
>  	}
> +	if (ioctl == VHOST_FORK_FROM_OWNER) {
> +		/*inherit_owner can only be modified before owner is set*/
> +		if (vhost_dev_has_owner(d)) {
> +			r = -EBUSY;
> +			goto done;
> +		}
> +		if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
> +			r = -EFAULT;
> +			goto done;
> +		}
> +		/* Validate the inherit_owner value, ensuring it is either 0 or 1 */
> +		if (inherit_owner > 1) {
> +			r = -EINVAL;
> +			goto done;
> +		}
> +
> +		d->inherit_owner = (bool)inherit_owner;
>  
> +		goto done;
> +	}
>  	/* You must be the owner to do anything else */
>  	r = vhost_dev_check_owner(d);
>  	if (r)
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index b95dd84eef2d..8f558b433536 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -235,4 +235,22 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
>  					      struct vhost_vring_state)
> +
> +/**
> + * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost device
> + *
> + * @param inherit_owner: An 8-bit value that determines the vhost thread mode
> + *
> + * When inherit_owner is set to 1:
> + *   - The VHOST worker threads inherit its values/checks from
> + *     the thread that owns the VHOST device, The vhost threads will
> + *     be counted in the nproc rlimits.
> + *
> + * When inherit_owner is set to 0:
> + *   - The VHOST worker threads will use the traditional kernel thread (kthread)
> + *     implementation, which may be preferred by older userspace applications that
> + *     do not utilize the newer vhost_task concept.
> + */
> +#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> +
>  #endif
> -- 
> 2.45.0


