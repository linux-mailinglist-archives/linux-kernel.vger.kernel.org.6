Return-Path: <linux-kernel+bounces-355738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0675499563B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914681F26715
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E85F212644;
	Tue,  8 Oct 2024 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G+vbLI4M"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C992220A5EF
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411157; cv=none; b=RWvOGSGlgh2LTPm8ATxMu21csVzZXF/aX1EO87oxdByl3YdD8/DnGq6gEWqJRlB0xCH2MhwWJPH0rrLx9m0q05lMSGpTOZ7nqA70xi8nDy0FRp90y7Rsi8dd+kD7Y6sZqz9JDoJeCrRzOVDHFev/8+uoITNj+0pevx6yAZQjY5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411157; c=relaxed/simple;
	bh=KZtnorh+6De5MzRF06EfiOi8deC4jcrfngGuRSraIlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=socp+A/iGm4aV2JMBWM7tomGGJd4YAzt1FUkcWiquKsANP9xjaptFyJDRhWZ7vqWrgj8Yp+Q3KL8o5CHD5i1S+dREd1d2kR0ClR+78ciOCfV4NgiZ5y++qkUYSHtl/PduxFKzTj4m77l2EsuRpZ8YVToGX6vdJiVB62bxrjfbBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=G+vbLI4M; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-45821eb62daso37788751cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 11:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728411154; x=1729015954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n+daBNbE4A3/IkoAmsu5dUuddPR6v/H43OmoGOvQMFg=;
        b=G+vbLI4MKwbljzKPnGln0fhAge825mcNXiXjQkBrbJNXrLOEMRdq9SnaoP4hBEqJFL
         NM3FpUVsnp+3RoF/rIbIfV/5gbdtAVJTEUgB6KI8YCb8wgNjcCKks3IY4Obvd2dnIMtp
         8OWQ1OQPzG/mnY92pAKdlHo8ZvbVr0A/KyzfS6XNXGCfmdLPHU9ahc/POq4v6PBq/Ohp
         jGlzxgfHApbysJT6l0bnF0cobJDvtvfOwZ/RdtkRzTyvfIVu+LZT+EknI+Qp24IBwwnM
         FU34IS8pv6prYjrhbrWpb9AzwJ/SYsRX7gY8eC6+SdkBsDzPKF5vKEMShoosf45CojSZ
         5Qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728411154; x=1729015954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+daBNbE4A3/IkoAmsu5dUuddPR6v/H43OmoGOvQMFg=;
        b=NqDmhgsrXfwxX6M8GCjOyo1RMhrdWGXsHmzPeqolXwH+6Yfax5SS9Qpy8vDs748Jhg
         zHdtRhGSA5wkItW/3YA1l229n5p16l3WxuMoGSqq5ihrLv0rC8JXItMH97rxJxvzMP7n
         GjX4T5zCKwXcWgDlVmz40l04mnPDj+nStKK51k88/x+6KZy2hGWXt0H6mfYeIo2n73ca
         nTeMEzy5s+47lXeXvmw1GP1dQM6qlBQ9TVMI1nq52DhKmxt+rl19lxjbm+xndqPhbkNy
         1kAafcYTb192xAUL9VRzlDr0TpVkY+RASkW10aFfk2HhtluVcJrkt/JpVA8wTPLGqXGq
         7qqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgnmQX9mOT5BWvbMErjvej3F+WjYUygFy3dStLjCCF2evnvLmHxpfNUMPUP0vOfBIGyHDDILlo5wl/HU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZd/isurssNYZlrAcjEEUgMbBd4G6b5lRZCx68I2jlI3zVMJSG
	EZcpZVt8f/GpYsnsIqWQZd/6MMwML2D2gNxCi524UH76xvKK4Zc5A+6TGqltxYw=
X-Google-Smtp-Source: AGHT+IFZ7849aZEK7tygFhqWieCpfCpQYJY7F+nz/8tdd79wkaQ8EwIY9JISq9FkFonwvaH6jvNvDg==
X-Received: by 2002:a05:622a:1a87:b0:458:5011:6671 with SMTP id d75a77b69052e-45d9badaf62mr199367281cf.39.1728411153683;
        Tue, 08 Oct 2024 11:12:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da763fdbdsm38396711cf.82.2024.10.08.11.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 11:12:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1syEhE-006qUW-Iy;
	Tue, 08 Oct 2024 15:12:32 -0300
Date: Tue, 8 Oct 2024 15:12:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/amd: Use atomic64_inc_return() in iommu.c
Message-ID: <20241008181232.GD762027@ziepe.ca>
References: <20241007084356.47799-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007084356.47799-1-ubizjak@gmail.com>

On Mon, Oct 07, 2024 at 10:43:31AM +0200, Uros Bizjak wrote:
> Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
> to use optimized implementation and ease register pressure around
> the primitive for targets that implement optimized variant.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/amd/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

