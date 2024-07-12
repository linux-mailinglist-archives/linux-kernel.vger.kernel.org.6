Return-Path: <linux-kernel+bounces-250642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B9F92FA6F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23123282B4B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A0A16F293;
	Fri, 12 Jul 2024 12:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OecoPeRo"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95DE13D619
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720788195; cv=none; b=VQ8GGsVIuS89xkRYn0iIr38uhtTEFpfOQbMsRwGGpb4U6xo0fMG+AZKLyST983NbARvhlvZh1wpu2F1b0AxDw2H0t26trZEa1bTETbRrJkah+OiL+Nxul+LXgDZ0fb74s/18s71XISSnDV/12UovCVpooaw3LwD7WLy3VW5viqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720788195; c=relaxed/simple;
	bh=fT+Bhjgp9vjGiECuUQwPkyEv/BsipRr4+reXgqzsDIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQTiafsFDjiLY98yer4YnmhSMqx1q2u97JAgk3HRPDcfrzCuJMnq8iF2tHUzZbvqbCeQWXoBvRUIoCDF5T2r+iTQCFoorj768BU+xoCjc85WHrm+oPIhRshdPJG9Gnrp3wWxqvxMgK+ZR/gtTtUVHqXL8fkrPKkqqDbOg6wTU6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OecoPeRo; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e03a0faee1eso1921976276.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720788193; x=1721392993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TCLw51Ov+fzPQqS/+3p89aoPh13Gnr3eNhlUOT4KGkY=;
        b=OecoPeRoLewgccWAxdww8hBCm7oALZTFZzb82KDQBJeoFYNzoKf24aNYT8ts8D0jec
         5/SQwCiZqpSSVNaqdVg+3chZoVB1lX+VoP2fLPuZswg9q3hCPz1gRjY0SZsoO1sXVYIB
         dIceGz34bQWpdp89ytRZFArczgfIithKcCUZYGOlyzMeyUaMgsqhHdOOybJeRmZxAX+S
         s+SM/RSM61My34Oh2YiaMnDmYvXX+kcrdO7KlVhdT7xTT+38AAkxW0LS+syO6QIFoDUq
         e79e9uPh8HKwDwWrt7lYY9xNFCau/5Dhz4K5WocwoggPUX8Y43CgsaCqG16XF3KAtS/N
         KQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720788193; x=1721392993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCLw51Ov+fzPQqS/+3p89aoPh13Gnr3eNhlUOT4KGkY=;
        b=DZq5ZploPNXfSh+ZQ20aDvaE/ousx+Q+u0oMSaejstNPBm5SjH/D+dCHq1h3skQMJc
         fWRtNcP7h2Al9pUu183FDneZkE15n1Tbzw+vIORPNv0G9i66+BrRDwHCXI3JGmid2FcN
         +aU+77o0UuW4KqTA6KLk0e0WvyXpGLks6qzuvfwJCYjuItMZtW9FF+5/gIU/a4i0cLsl
         nAKMlsmYyCXdQF9VgLJ7FOtWYVC04ioof0cwF/XFopa4LnMOCSkfbMhMePS4+ano/5TC
         dQDojR3xAFv6ZQkm7yJfxaXkgrtqp+zcXnqCLIARz0wwKHYvTBWewbZAY8JP3eC1utrp
         qwJw==
X-Forwarded-Encrypted: i=1; AJvYcCX3Y6A5aoBuTbif4qYjGlYUDKw/tuyyDaIXoiD2W+lDOfTBV6wpf7rA9FuW6Z1e2eLByC+h3GJtYmwcR1yv2DvnT/qhTJwtvW5UR0a0
X-Gm-Message-State: AOJu0YxpRDmeunEgcK20JX0+43sFQxyUmZHvX7vlzZbxIifYn+SueUfu
	TF6zl6fsjnPnmBwqZ48cn/3aN0kZl45QOH7DJjiiOZZI32XmXPiUmztBAsTjvj0=
X-Google-Smtp-Source: AGHT+IEdvjEYH3YJfdXqM+Dc9L3bXQquOW4fau6cdS1Z+dA+ArZi7tFzhHqA4MvsKaCznd0OQ52Lgw==
X-Received: by 2002:a25:874f:0:b0:e03:60b4:1311 with SMTP id 3f1490d57ef6-e041b032e00mr10507728276.9.1720788192827;
        Fri, 12 Jul 2024 05:43:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b26c9dsm40245411cf.14.2024.07.12.05.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 05:43:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sSFcF-000FbT-SJ;
	Fri, 12 Jul 2024 09:43:11 -0300
Date: Fri, 12 Jul 2024 09:43:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iommufd: Add check on user response code
Message-ID: <20240712124311.GY14050@ziepe.ca>
References: <20240710083341.44617-1-baolu.lu@linux.intel.com>
 <20240710083341.44617-3-baolu.lu@linux.intel.com>
 <20240711233950.GU14050@ziepe.ca>
 <b4758476-6de2-4d3e-91b2-10599a37d00e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4758476-6de2-4d3e-91b2-10599a37d00e@linux.intel.com>

On Fri, Jul 12, 2024 at 10:54:11AM +0800, Baolu Lu wrote:
> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> index 29f522819759..a643d5c7c535 100644
> --- a/drivers/iommu/iommufd/fault.c
> +++ b/drivers/iommu/iommufd/fault.c
> @@ -305,10 +305,10 @@ static ssize_t iommufd_fault_fops_write(struct file
> *filep, const char __user *b
>                 if (rc)
>                         break;
> 
> -               static_assert(IOMMUFD_PAGE_RESP_SUCCESS ==
> -                             IOMMU_PAGE_RESP_SUCCESS);
> -               static_assert(IOMMUFD_PAGE_RESP_INVALID ==
> -                             IOMMU_PAGE_RESP_INVALID);
> +               static_assert((int)IOMMUFD_PAGE_RESP_SUCCESS ==
> +                             (int)IOMMU_PAGE_RESP_SUCCESS);
> +               static_assert((int)IOMMUFD_PAGE_RESP_INVALID ==
> +                             (int)IOMMU_PAGE_RESP_INVALID);
>                 if (response.code != IOMMUFD_PAGE_RESP_SUCCESS &&
>                     response.code != IOMMUFD_PAGE_RESP_INVALID) {
>                         rc = -EINVAL;

Yep, my compiler doesn't warn on that apparently..

Jason

