Return-Path: <linux-kernel+bounces-221471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5749F90F421
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512A41C22154
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4A4155747;
	Wed, 19 Jun 2024 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Vu5/rXaQ"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533A6155322
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718814889; cv=none; b=a2/QYnn2yNxFGWAMPiZjo95Q0xYcnByrquUYaeFx3GWLmLz3UfYPQSGzhmEDIgsNUFp/cdu4TZL0ziMr4233ipn9eH9Al89SweyxftzZIoWCtJiQ/A9aG207OzfBpmLnul3Y1x4sZSyqV1FTlX+/DXole/yi7lvhHvruIo3pNcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718814889; c=relaxed/simple;
	bh=vz3OyqF6PjBb+NDoBEl8crxXV6LQcMi1lT8jRt8+XwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbWWib1xZGI0gJoOR7N4M0fGFFE6hHmFEFL2/m1KjNiPbXZ5k1NRn9Sk6K9NCkPuC9EdeISW8d2Awjk5jWYw5d/lr2EPWJpj3oXj0D5pDcxgWIfB334S5KrvI/75CkN89LPuk/bTKKBG/SZZcduEJEdbOApf7pd+HvMx3mzHVlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Vu5/rXaQ; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6f98178ceb3so3792434a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718814887; x=1719419687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U0Z3MILfX5zi94LfosxPsrOvnWTNdLm10NYSBu4aEWY=;
        b=Vu5/rXaQyfeTAi7/rv4vTsJL0ulf7MwmTz4DtKzBI2EjvsX3fIESxNVgPAP5vjnxFE
         1VYQfu+ZkqJOdSzECsnPut6NFRmnQRJeYeoFYwxSWXbbnLL3ktWuBDSV79KOc72ZLw01
         5m/Axu+DWbMbbTwqpVnbTeu0rl5qR/dgOCPBMAdq7xyVThKcjK/aiX9LRmDYfz8qLQxI
         8ybyoxVaM55rOdzo2jxHUAdg76X1oyq2bup1N0/o/oDPX1sXm2tggXlIrO22TdqG4nIQ
         xOzC0DWDvECjN1dZYhvtWR54CYhQON/BbTR9Am8GRwFkYpHkn0OLWpp0CL+hhGfXxbhM
         0TfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718814887; x=1719419687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0Z3MILfX5zi94LfosxPsrOvnWTNdLm10NYSBu4aEWY=;
        b=ETJJdaQ0EYYMDjMslrXvkGgdvmO/SD4PIW0r6pmlcrLNVsL71Xhee4O+dL/O9+ECe2
         IoXEdlohiDs6tt7GoxwRwb7hrn53Bo6hLexG1jsfSTJPfWIfuWTTfJQj7Czv+C3DSjP7
         mFzcu6KSJC7Lp2ZWZ7/9J735OOng0UV4AQTTZjAdlWg8JYxfFv3djx1BPnu4dAs2BlNq
         +1qV2FrxzSsvaVP6AZiuLYFxOAQJJ1JhvGoIEPhQnShdct6ZdYekILUtgl0/5p7aX0w2
         iZPgYp/LUvEIy6/m2IH7YZnbrCiwlqkn9spTviroC5E8kcQycxPQg7Y6FDQDgu3IdkSi
         t3JQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5FU18aYf48h0IzKRMe49bBr5/hNdcryPlv54OnGGuk3UBw0xtLrCwckiq+9uBWd6SFr/ppzspxbNW7jDta4ydwRmMvrV41Y8SRKlX
X-Gm-Message-State: AOJu0YwyY5lZHp+20uyuZy9cag+F3lMKkUOVSYAyvD3A6gnVed3+zmnB
	Az4wZNQOjBNjF0FmPCOIz81NHid+aItjXzIIsHs36MeFlqONaFdQDqj0ANuzSV0=
X-Google-Smtp-Source: AGHT+IHbLaigtw0mJHzx/yQd28ehpS3L1U7ULHkxwkCKVmyGufSvndmmDVZaVUaeop0hhX6BCYc7SQ==
X-Received: by 2002:a05:6830:1243:b0:6f9:aaab:d34f with SMTP id 46e09a7af769-7007365c28amr2973145a34.6.1718814887452;
        Wed, 19 Jun 2024 09:34:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b4f8754a9bsm17821726d6.92.2024.06.19.09.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 09:34:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJyGk-005ArA-0i;
	Wed, 19 Jun 2024 13:34:46 -0300
Date: Wed, 19 Jun 2024 13:34:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: add missing MODULE_DESCRIPTION() macro
Message-ID: <20240619163446.GM791043@ziepe.ca>
References: <20240613-md-arm64-drivers-iommu-arm-arm-smmu-v3-v1-1-0e9f7584a5c8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613-md-arm64-drivers-iommu-arm-arm-smmu-v3-v1-1-0e9f7584a5c8@quicinc.com>

On Thu, Jun 13, 2024 at 12:44:17PM -0700, Jeff Johnson wrote:
> With ARCH=arm64, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.o

Weird I never saw that..

> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c | 1 +
>  1 file changed, 1 insertion(+)

Fixes: da55da5a42d4 ("iommu/arm-smmu-v3: Make the kunit into a module")
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

