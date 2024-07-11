Return-Path: <linux-kernel+bounces-249990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C03B92F2B0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 01:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCD841C2204F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BECA15ADAF;
	Thu, 11 Jul 2024 23:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iW+4FIKE"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2441115ADA1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720741195; cv=none; b=i9cnWppE2osGMC0HexUiGnnU0ljHALpwhiYtP1gyAWDLTYxzgdK9GE87PDYE7Gh0E1tmat5I2SjSk1jBHaKbpIsKvBKyYG/mkwZ0QnCMdE8+VeYQS8QngLE1G/mW3JzcYGabr5HG8zc4AbU0UNiIpIKtF3ZzwbRMmEujKpp591o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720741195; c=relaxed/simple;
	bh=AaZXRsdVn2tvLYsDOVlyTZEChQrM/esAH6DERNhXAfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgcaMlOV2mDkvwIpW5Ps8T5XE2lR7+uHPBchpyAJJMR3t5vWIjR6/CbVEL8daqhK23w4XDoWkyHYbbxkY9qjzS0Lhme0IZ30tV0Gq5YEshQ+gfPtU4XuhEf3ymBQmzWxuBpguvQQIRRv3hWPwQ5eGxMpe+cpdH7z4Q09QEDXNqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iW+4FIKE; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79f08b01ba6so125874185a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720741193; x=1721345993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IFVrrIHp8Vup92boS3hFd9PYBN8YKvRYBK43QitxZkA=;
        b=iW+4FIKEGd08RFlmgSFOOdNtvyCAWPy2i9oEVeAJQ6so5vE724dY0nbS4dWSOKGpAd
         iyL+WEl3sXHZC7COphR9jtVeravFTAOjdgTqp5zVXeAnEXOOO8iKQYFGqaBFsVIGdESk
         Es75IV/7Z8fT+d/PMNOuNilgsOhcxWmlM4wKBCBKRxfNeN2O5OJ8/xh3S834u+SqADuB
         RcMYHHS7YI63o75kjPKkpw91J8zZiCsUc4fi2zy6RXpgs5WnjN48OfUNn8yI/GcTgHkN
         Ghrj9weTNR33yf9get0MliPAINB2TO+tH9v7n5EX3EiUBDSJ+oWzi4LUMGr/EK1rHFw+
         8hwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720741193; x=1721345993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFVrrIHp8Vup92boS3hFd9PYBN8YKvRYBK43QitxZkA=;
        b=tKLPhSl56r8jAoPdjKVNWDI1l2mUu6u7U4Xt1p4ZYEqBvUZH7h8ZGOpcDIo6P5canp
         67BCbfYV0aqT+Y3sZcHKu8T6lzdH/PSKjheYCQ6mEd2vY5gFgU7J4CsViU+O8HNyro4L
         OK3Gz5mI9OqFeuz1bN8LQrfURvld8JejhnWSwv58mYcIumvIF0S/wPjj+IR226d2p+zL
         fmtll1Y0wRSaGRYJEQXf+Brb9OWEAlLjNDQZzITdY54pseae6LPfwVvtuX1Cuj3ClaON
         ddx1Ru5qmkIIxEiTUW/PDDOT0lMvzX475Ja8OWZ02rmlxWf98C1a323GoLgwR4kF3ZLH
         myKg==
X-Forwarded-Encrypted: i=1; AJvYcCVzgDS5dzvauc7KJPo0M3WPBh89BZt6TDF47Sfr7RgGejfMFXAdivToyxWSSgbwvGfT9cs/4Epw3iihgg2SP4AJckcjOd+Ayarv8CL5
X-Gm-Message-State: AOJu0YytbJUmnq/SyOW6RKSh7SRhr0fWdcOGS9qgx72q4dC8mJ3iF3Ax
	upwHRJI6aoO8EhctvE+2SwYprH9J/k71lUidhrUPk3RY9jplLfFZnefy7HGnG0k=
X-Google-Smtp-Source: AGHT+IEvE6NFq20imkRuEEO3x8KpVY70FapRhLgTh97KHKQPOyxmkDqYb4gFKM6bc2M6nmkv7zlTvQ==
X-Received: by 2002:a05:620a:4611:b0:795:60ba:76e9 with SMTP id af79cd13be357-7a152fbcbfcmr290215985a.4.1720741193036;
        Thu, 11 Jul 2024 16:39:53 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18ff827csm341798685a.4.2024.07.11.16.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:39:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sS3OA-00FTEK-Qs;
	Thu, 11 Jul 2024 20:39:50 -0300
Date: Thu, 11 Jul 2024 20:39:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iommufd: Add check on user response code
Message-ID: <20240711233950.GU14050@ziepe.ca>
References: <20240710083341.44617-1-baolu.lu@linux.intel.com>
 <20240710083341.44617-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710083341.44617-3-baolu.lu@linux.intel.com>

On Wed, Jul 10, 2024 at 04:33:40PM +0800, Lu Baolu wrote:
> The response code from user space is only allowed to be SUCCESS or
> INVALID. All other values are treated by the device as a response
> code of Response Failure according to PCI spec, section 10.4.2.1.
> This response disables the Page Request Interface for the Function.
> 
> Add a check in iommufd_fault_fops_write() to avoid invalid response
> code.
> 
> Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/fault.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> index 54d6cd20a673..044b9b97da31 100644
> --- a/drivers/iommu/iommufd/fault.c
> +++ b/drivers/iommu/iommufd/fault.c
> @@ -305,6 +305,12 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
>  		if (rc)
>  			break;
>  
> +		if (response.code != IOMMUFD_PAGE_RESP_SUCCESS &&
> +		    response.code != IOMMUFD_PAGE_RESP_INVALID) {
> +			rc = -EINVAL;
> +			break;
> +		}


I added this:

		static_assert(IOMMUFD_PAGE_RESP_SUCCESS ==
			      IOMMU_PAGE_RESP_SUCCESS);
		static_assert(IOMMUFD_PAGE_RESP_INVALID ==
			      IOMMU_PAGE_RESP_INVALID);

As well

Jason

