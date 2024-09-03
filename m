Return-Path: <linux-kernel+bounces-313541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B866796A6D7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38571B20FFF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED511922FF;
	Tue,  3 Sep 2024 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftBGUyz2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A2318FDC3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 18:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725389233; cv=none; b=U5i8aZI7BBsxzknDCBpCVC/SEYTPFjPxkpbMEu+0N5qY9Maf6f2TfB8FtIwCRppVX2rUBixxpg986Tcml1FLYBiwy8oi9PUKJcVF8Z/2GB9/CPES2JohO7sL6PpART5lUm+O5clJJGQwE/ZUpxIL8Sl9F87a8eGfFW5N1PbfGrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725389233; c=relaxed/simple;
	bh=9fw3yLmVGvVS67/sHkf7QjBMcfR2KArwbDGYPnK0ydc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7KxTaPmmk6GY+/QufvH+OADnX4K7v6YwuWLtObq/ZD5gncKQUcg53+EVT2xvNwMBhbdVlbDpDCup1RAiKjRUnsDdS+VtqZZ4eYYl8goIwn00fQlVuZWRcqLQ7FNBPXBouwIYRqbbKnvMKBM7DBlx4bevKYfE7snCSnUx5dvFh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ftBGUyz2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725389231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RiYZls7XAH3fXWooN5lGFOF3Jc3SZNKa7sVf+1sWGVg=;
	b=ftBGUyz2leFy9EsCefTL8s4ylQoo3IFY80tqUzh/7fxRGRcBIExzxqDTbvFqJV55FO9nTk
	6We3v5SR7ETKLnadtbDmBv/eAlZW/IGOsnQxvSz8o0tLipz9yk16YsKU89O9l5fGsA9puX
	pmzDElDYKGSpQ2P7Bqmio/tgYgib/Qo=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-WHbym7oQPg2Fycw8ZqwRDw-1; Tue, 03 Sep 2024 14:47:09 -0400
X-MC-Unique: WHbym7oQPg2Fycw8ZqwRDw-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-80028cf643bso100739139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 11:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725389229; x=1725994029;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RiYZls7XAH3fXWooN5lGFOF3Jc3SZNKa7sVf+1sWGVg=;
        b=NBQx56ypKrsjcYiO/FsMqjgGgB0MN0BSx69+xwOiIV3ZCB7VqPm0/f1dS4jgjrvFYn
         AXppQQ+epnZwqegqEauYuiq/j4Xi5tbiEyLUPXCd0lZz6HXqK2S8FvY6KRnIgkomDLAi
         NYUPs/tKWh6tOzoD6bx/UfIcJoZIysA9dz8jVqGhZcs9v0Y2dYOT0iiJ6abOZzkphoYC
         CEikvgEeVjTi9BHKRq5vxBXUzhL4LhIn7n/99sf+nBVisrVRV6uQS09zyHB/tpT1S+VW
         /A6YHDNGyaJRNNZJxLfkIPcjrNlHL37g7G8xTW+5mzR9yk9/jgAUjk5Xmv3J1nMYDmAC
         a2ug==
X-Forwarded-Encrypted: i=1; AJvYcCXKhU5V319/zxbXDLd/5ypc9ZMMX9IBPhyvzZxspBgJBfzNubU5BaHTtTvyaJ0urCI2sT0O8OxKhmEd5eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxehkAb39Ry2wq4OoWxlAY/7kAjNO+zkgrr3jIV58kNHSvbQ1JW
	Ozgy+WWTY3RbPMaLUOk1/MwomhB8c4bUsy4xhjPVIWXsfmr5/8qh1RZydd28if7vKkqD5pCjl/U
	xDYaqM27FQuLH51eUYAdL5DyGym7UqjUYkmVPjg49wvn8PeWWUr6Y47HOAms0iw==
X-Received: by 2002:a05:6e02:19c8:b0:39f:7050:6f5f with SMTP id e9e14a558f8ab-39f70506fb4mr10497845ab.5.1725389229138;
        Tue, 03 Sep 2024 11:47:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJhPRnAYcOWTvXTG2dd2PcZkuZ1cOljpqdC47/lzql5dL1/zxTeKjMgQttAAOA6UoUgBJvxw==
X-Received: by 2002:a05:6e02:19c8:b0:39f:7050:6f5f with SMTP id e9e14a558f8ab-39f70506fb4mr10497605ab.5.1725389228707;
        Tue, 03 Sep 2024 11:47:08 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3afc4ff6sm32862425ab.37.2024.09.03.11.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 11:47:08 -0700 (PDT)
Date: Tue, 3 Sep 2024 12:47:07 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] vfio/fsl-mc: Remove unused variable 'hwirq'
Message-ID: <20240903124707.4ecfc5de.alex.williamson@redhat.com>
In-Reply-To: <20240730141133.525771-1-yuehaibing@huawei.com>
References: <20240730141133.525771-1-yuehaibing@huawei.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 22:11:33 +0800
Yue Haibing <yuehaibing@huawei.com> wrote:

> Commit 7447d911af69 ("vfio/fsl-mc: Block calling interrupt handler without trigger")
> left this variable unused, so remove it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c b/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
> index 82b2afa9b7e3..7e7988c4258f 100644
> --- a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
> +++ b/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
> @@ -108,10 +108,10 @@ static int vfio_fsl_mc_set_irq_trigger(struct vfio_fsl_mc_device *vdev,
>  				       void *data)
>  {
>  	struct fsl_mc_device *mc_dev = vdev->mc_dev;
> -	int ret, hwirq;
>  	struct vfio_fsl_mc_irq *irq;
>  	struct device *cont_dev = fsl_mc_cont_dev(&mc_dev->dev);
>  	struct fsl_mc_device *mc_cont = to_fsl_mc_device(cont_dev);
> +	int ret;
>  
>  	if (!count && (flags & VFIO_IRQ_SET_DATA_NONE))
>  		return vfio_set_trigger(vdev, index, -1);
> @@ -136,8 +136,6 @@ static int vfio_fsl_mc_set_irq_trigger(struct vfio_fsl_mc_device *vdev,
>  		return vfio_set_trigger(vdev, index, fd);
>  	}
>  
> -	hwirq = vdev->mc_dev->irqs[index]->virq;
> -
>  	irq = &vdev->mc_irqs[index];
>  
>  	if (flags & VFIO_IRQ_SET_DATA_NONE) {

Applied to vfio next branch for v6.12.  Thanks!

Alex


