Return-Path: <linux-kernel+bounces-307825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D34B965360
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 01:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D8ABB2137D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A868018EFF1;
	Thu, 29 Aug 2024 23:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JuFfkqyn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C197018E776
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 23:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724973707; cv=none; b=KincKIqbheFVx8QD+otEwxV9Qiu0xWSZLUwQueOxVCljInOyifWXsNEi/OJTym8hFYa+ua3ATgq/mZZ/3AigV69K4+sLKGkoeFoo9GvvEgSkt8iEWaqhqt2/FFH2jNqFjUCx6YWpopqb45Jq73Oag1gfE2TLAF2teH/dOozNWIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724973707; c=relaxed/simple;
	bh=AqHcWtuqCNAT29wDBP4vmDe6sFzp23LVp9gIvFYdeR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Md5qtGZrm7Z0urRaDLlAMjjvZu7ekHeIGD9bjqG9vFq7j1oVryvMKbEG8hbMKfFAahUJ07o+ouIjvp47gqA4Cz7iUoMUFGb3mmpdZgYwt0pbciX/pFAO0c+Yxfy2WnUA1+m1nGJNi20FJuFdY+AbEqVqRW+xeW+cozOU4jwkbZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JuFfkqyn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724973704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkLW/GJXW025vC/zR7s6KWdbSZfTOu9zBPKEdmJOkMc=;
	b=JuFfkqyn+ou3Iv+Qj+HAfdYX8XHeDoKAq8NFA+LN1A9xuQGC7lztPF3I5s//N9yv9u2bEq
	4lBdaaa4LoITOP85M4Tk3vk3sur/i+QmBibKJaWTMK7CdMEkrDOPO7vWmn7s6wZ8wUee7r
	TYcyn0GeRj5+7myxBfz1JbYtPJTqbM0=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-x69-dGDPOoyHqm5GLGjcQQ-1; Thu, 29 Aug 2024 19:21:43 -0400
X-MC-Unique: x69-dGDPOoyHqm5GLGjcQQ-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8279ee499aaso13455139f.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724973702; x=1725578502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkLW/GJXW025vC/zR7s6KWdbSZfTOu9zBPKEdmJOkMc=;
        b=FfCI2M8eGS8k+pCprWv8hs3vYbcO2y5NubmZiHwt6+MixFpMOaRzEGkHAENQ8zNOnY
         Ma9xyZA1wQCIpvp8GHnc1jhjwHImKgb6XkuO599eCTha4LIvkVshthDGe12tEM9WvWzj
         XaAI8wrWqgs1I8Ddl6GCKmyX7V0M07Wuaz2eIdRHydogouA5siJGHyB48k/iz+pAtr0E
         hgs6BUcF2Dxk54o1OWw5yWd/1/US+MlCqYAIN0LiGrj4h4gTC1uzTmpaCxBfk5Yq8pKK
         EPly5UDVySNT30AsB11YADq79V6FC6LUOGAiu8VQLIqHxXf1ugYAppIDCOr21aOs4giq
         vuYA==
X-Forwarded-Encrypted: i=1; AJvYcCVUP72SL3brGYoSasHLJiOJM20kyHgtcqTgIPeYvwzFgkAPYDVZkCpx+j9AxkiVQxyM42qnYIM6meN6UxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU8Xf84LHjPwFAe+h8EOsIDsB8lIq+W2Niz0ljgkZRR+84IBvM
	2L9T/3oYNXvWoig3xAwKiFB0B4rmlUKtOn+3YdJnWcxeyKtN0gmMeQOKYIsoy734NHoY82GH7t6
	xpF6CBmA341ni5aiYBorTUEFc4mj92PJBTvh7CHNyX4OGNRBM4FGkveFhEkwbmw==
X-Received: by 2002:a5d:9c51:0:b0:81f:7f2d:8391 with SMTP id ca18e2360f4ac-82a262e0480mr34008339f.3.1724973702395;
        Thu, 29 Aug 2024 16:21:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaZvSkwWJar4Rqj8+g17+VPHiiSCIGu68s1hSoMmlVtVZB3E0uN+OY128eFxMU3Jp0pN94Cg==
X-Received: by 2002:a5d:9c51:0:b0:81f:7f2d:8391 with SMTP id ca18e2360f4ac-82a262e0480mr34006639f.3.1724973701954;
        Thu, 29 Aug 2024 16:21:41 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2e18812sm456400173.83.2024.08.29.16.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 16:21:41 -0700 (PDT)
Date: Thu, 29 Aug 2024 17:21:40 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, treding@nvidia.com, vbhadram@nvidia.com,
 jonathanh@nvidia.com, mperttunen@nvidia.com, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, clg@redhat.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, msalter@redhat.com
Subject: Re: [RFC PATCH 3/5] vfio_platform: reset: Introduce new open and
 close callbacks
Message-ID: <20240829172140.686a7aa7.alex.williamson@redhat.com>
In-Reply-To: <20240829161302.607928-4-eric.auger@redhat.com>
References: <20240829161302.607928-1-eric.auger@redhat.com>
	<20240829161302.607928-4-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 18:11:07 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Some devices may require resources such as clocks and resets
> which cannot be handled in the vfio_platform agnostic code. Let's
> add 2 new callbacks to handle those resources. Those new callbacks
> are optional, as opposed to the reset callback. In case they are
> implemented, both need to be.
> 
> They are not implemented by the existing reset modules.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/vfio/platform/vfio_platform_common.c  | 28 ++++++++++++++++++-
>  drivers/vfio/platform/vfio_platform_private.h |  6 ++++
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index 3be08e58365b..2174e402dc70 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -228,6 +228,23 @@ static int vfio_platform_call_reset(struct vfio_platform_device *vdev,
>  	return -EINVAL;
>  }
>  
> +static void vfio_platform_reset_module_close(struct vfio_platform_device *vpdev)
> +{
> +	if (VFIO_PLATFORM_IS_ACPI(vpdev))
> +		return;
> +	if (vpdev->reset_ops && vpdev->reset_ops->close)
> +		vpdev->reset_ops->close(vpdev);
> +}
> +
> +static int vfio_platform_reset_module_open(struct vfio_platform_device *vpdev)
> +{
> +	if (VFIO_PLATFORM_IS_ACPI(vpdev))
> +		return 0;
> +	if (vpdev->reset_ops && vpdev->reset_ops->open)
> +		return vpdev->reset_ops->open(vpdev);
> +	return 0;
> +}

Hi Eric,

I didn't get why these are no-op'd on an ACPI platform.  Shouldn't it
be up to the reset ops to decide whether to implement something based
on the system firmware rather than vfio-platform-common?

> +
>  void vfio_platform_close_device(struct vfio_device *core_vdev)
>  {
>  	struct vfio_platform_device *vdev =
> @@ -242,6 +259,7 @@ void vfio_platform_close_device(struct vfio_device *core_vdev)
>  			"reset driver is required and reset call failed in release (%d) %s\n",
>  			ret, extra_dbg ? extra_dbg : "");
>  	}
> +	vfio_platform_reset_module_close(vdev);
>  	pm_runtime_put(vdev->device);
>  	vfio_platform_regions_cleanup(vdev);
>  	vfio_platform_irq_cleanup(vdev);
> @@ -265,7 +283,13 @@ int vfio_platform_open_device(struct vfio_device *core_vdev)
>  
>  	ret = pm_runtime_get_sync(vdev->device);
>  	if (ret < 0)
> -		goto err_rst;
> +		goto err_rst_open;
> +
> +	ret = vfio_platform_reset_module_open(vdev);
> +	if (ret) {
> +		dev_info(vdev->device, "reset module load failed (%d)\n", ret);
> +		goto err_rst_open;
> +	}
>  
>  	ret = vfio_platform_call_reset(vdev, &extra_dbg);
>  	if (ret && vdev->reset_required) {
> @@ -278,6 +302,8 @@ int vfio_platform_open_device(struct vfio_device *core_vdev)
>  	return 0;
>  
>  err_rst:
> +	vfio_platform_reset_module_close(vdev);
> +err_rst_open:
>  	pm_runtime_put(vdev->device);
>  	vfio_platform_irq_cleanup(vdev);
>  err_irq:
> diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
> index 90c99d2e70f4..528b01c56de6 100644
> --- a/drivers/vfio/platform/vfio_platform_private.h
> +++ b/drivers/vfio/platform/vfio_platform_private.h
> @@ -74,9 +74,13 @@ struct vfio_platform_device {
>   * struct vfio_platform_reset_ops - reset ops
>   *
>   * @reset:	reset function (required)
> + * @open:	Called when the first fd is opened for this device (optional)
> + * @close:	Called when the last fd is closed for this device (optional)

This doesn't note any platform firmware dependency.  We should probably
also note here the XOR requirement enforced below here.  Thanks,

Alex

>   */
>  struct vfio_platform_reset_ops {
>  	int (*reset)(struct vfio_platform_device *vdev);
> +	int (*open)(struct vfio_platform_device *vdev);
> +	void (*close)(struct vfio_platform_device *vdev);
>  };
>  
>  
> @@ -129,6 +133,8 @@ __vfio_platform_register_reset(&__ops ## _node)
>  MODULE_ALIAS("vfio-reset:" compat);				\
>  static int __init reset ## _module_init(void)			\
>  {								\
> +	if (!!ops.open ^ !!ops.close)				\
> +		return -EINVAL;					\
>  	vfio_platform_register_reset(compat, ops);		\
>  	return 0;						\
>  };								\


