Return-Path: <linux-kernel+bounces-397715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 738BB9BDF71
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8FA1F223B8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0BC1CCB34;
	Wed,  6 Nov 2024 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQKc1r9T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7EA176FA4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878382; cv=none; b=IuXnPKzg8PrMcA+BursJutkSsa3yjukfUelkKqMJU1OprO9N7Vkhtzj+liGZntLMI+fUHJfZLekRG0iSz0uOgcgmdkO4cj8D3z+unpAef0Vu5GNuEAbBOkt/dq3F9i82u0hFOyHr1G/SPAlhaTa7fipzhu5x6oR74GcBFI+yd8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878382; c=relaxed/simple;
	bh=1TK5jWQmYm5lF5a0elC3Jq/CHvGV6cfz4sc++/qpT/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyNr07cMmWieqD1SE6JkkgX/vUg9qHez87pNspqWrNa9a0qQI5A2Wr6ys5ty/3AtSKME7GowFsYZtqKEw3cmd+c2jV3oLsRZZqeUeaNp+ctGyHOdRYPMhibL2diWdOSV9VAeNQi09aHxw+Dj5Hgu8kn/ekpcgbVS0tWJhUo1Cy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YQKc1r9T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730878379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I0Nl77wHyDTDBUHU8VfL2oqjen/EEFJo/J8tC1+irrs=;
	b=YQKc1r9ToRVZRI9T3VC7PTWTsSBg2+uZdxfak6faBcaTGrz7/hjoE++P7ofcmASNbyeg2E
	ocBSlcqDJVuxCaHfllpN1Boeny6ECaWsfnksncLc2OYiMXwEKjgMjmWJ03+ilfYGzRsj0b
	bPlO1m+QBXni/NbkeX81/8Zd6UsRlFw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-GtFZQ8YVOyWaRNv8PR_X3g-1; Wed, 06 Nov 2024 02:32:57 -0500
X-MC-Unique: GtFZQ8YVOyWaRNv8PR_X3g-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-539e4b7c8f4so4589752e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 23:32:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730878375; x=1731483175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0Nl77wHyDTDBUHU8VfL2oqjen/EEFJo/J8tC1+irrs=;
        b=cgQv5wfYnOVsX+B1qklxZ/HJp5Uo/lohbA7cXtlaz3IQ0LzuqDMR1WBxRrjJ31JRzE
         3Qp9cudd8qyzh+d1ARFexKL/0uhOy+i/w/pQX4m9O3HvSrYqct4qHHwFXrpnyFxWYr4b
         Em9sAIzsVH3qHscrPudXADMUL2GxX7LtSWvGODWp9PYcTsoAL3da/m8SKVfccxkUOYBV
         mvU8hMo5be0s/eNKd1Amjy2+WGFmQh0fQ3wXvV67z/HTyFQVTHsdDxgBIxKywIOByGN6
         0XS11PPopHuYbw/2Vs/d/iEDba7GbwhLiyx7YkgC3FZ5mUPWX3qDMD1A0ojLuOliWZ1a
         3nZA==
X-Forwarded-Encrypted: i=1; AJvYcCXG2bPgX+17Knc2SwnzAsT93f5arI3UMS7+E801dNQ3crTDx2PWkxXbTz1jNUuRIf8zKl/GoPeQ2PPn9qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoBB4/YTMCsVWE8zHBJL/++VgjzLyd8S5p18JXG6zP+JQ3CPJt
	SKgDURGAShGWDiruQ4Qec85UsiiL97GgzM+C/7kE4MN3oG5SIjCay1nNjT1dXSRSyvpcDg/mKx1
	dHbTRuDaknkvup/Tzr7EEv64NXgmStKcSM12L9V04RUc8tV+TtEpJ1O8f5hUlaHvCrws8XA==
X-Received: by 2002:a05:6512:3a8c:b0:539:ed5e:e226 with SMTP id 2adb3069b0e04-53b3490f0demr19783062e87.26.1730878375088;
        Tue, 05 Nov 2024 23:32:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjB2BJOsn+j3Y41tPwiKFVeRVoGZVa9+cut0MOvJu0SDjEm2Wp6FGY8emxABWpEuw8y0y3Bg==
X-Received: by 2002:a05:6512:3a8c:b0:539:ed5e:e226 with SMTP id 2adb3069b0e04-53b3490f0demr19783047e87.26.1730878374648;
        Tue, 05 Nov 2024 23:32:54 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa7397e4sm11883915e9.40.2024.11.05.23.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 23:32:53 -0800 (PST)
Date: Wed, 6 Nov 2024 02:31:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 7/9] vhost: Add new UAPI to support change to task mode
Message-ID: <20241106022630-mutt-send-email-mst@kernel.org>
References: <20241105072642.898710-1-lulu@redhat.com>
 <20241105072642.898710-8-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105072642.898710-8-lulu@redhat.com>

On Tue, Nov 05, 2024 at 03:25:26PM +0800, Cindy Lu wrote:
> Add a new UAPI to enable setting the vhost device to task mode.
> The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> to configure the mode if necessary.
> This setting must be applied before VHOST_SET_OWNER, as the worker
> will be created in the VHOST_SET_OWNER function
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c      | 15 ++++++++++++++-
>  include/uapi/linux/vhost.h |  2 ++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index c17dc01febcc..70c793b63905 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2274,8 +2274,9 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  {
>  	struct eventfd_ctx *ctx;
>  	u64 p;
> -	long r;
> +	long r = 0;
>  	int i, fd;
> +	bool inherit_owner;
>  
>  	/* If you are not the owner, you can become one */
>  	if (ioctl == VHOST_SET_OWNER) {
> @@ -2332,6 +2333,18 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  		if (ctx)
>  			eventfd_ctx_put(ctx);
>  		break;
> +	case VHOST_SET_INHERIT_FROM_OWNER:
> +		/*inherit_owner can only be modified before owner is set*/

bad coding style

> +		if (vhost_dev_has_owner(d))
> +			break;

is this silently failing? should return EBUSY or something like this.

> +
> +		if (copy_from_user(&inherit_owner, argp,
> +				   sizeof(inherit_owner))) {

not good, 


> +			r = -EFAULT;
> +			break;
> +		}
> +		d->inherit_owner = inherit_owner;




> +		break;
>  	default:
>  		r = -ENOIOCTLCMD;
>  		break;



This means any task can break out of jail
and steal root group system time by setting inherit_owner to 0
even if system is configured to inherit by default.

we need a modparam to block this.


> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index b95dd84eef2d..1e192038633d 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -235,4 +235,6 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
>  					      struct vhost_vring_state)
> +
> +#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, bool)

do not put bool in interfaces. something like u8 and validate it is 0 or
1.

>  #endif
> -- 
> 2.45.0


