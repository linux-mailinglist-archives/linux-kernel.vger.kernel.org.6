Return-Path: <linux-kernel+bounces-172553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA34B8BF37A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287C91C23433
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DEB38B;
	Wed,  8 May 2024 00:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OrX9+naF"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAA6364
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 00:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127525; cv=none; b=Qt0Tx82kNYKMp3GpCE+vusFjNzBWRwFZ0qcIVdopT1HjDWlsQzSrOjiVspNqG45s5bM3qyPwb1A3axFzajDWKPyanix/z69XqqHt42FVvq7psJo6htdu1jbX0KOcpXcjtjz+m+YVaRCOm7NjquNxZUdaA6LYez6D0Ik7dJJJS/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127525; c=relaxed/simple;
	bh=yYyTvuGPY9Yh5W/zUy0ZLLfIboxNn47n/XUpWdPEdkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQYNtX3UoOQb2AvK/0h6iAhePpVHuJA8Ic925sdazb+uDkzmgOxaqQkCPnUiSzW1RmYkZzv1zSSmNGxpqyZN/KAl9lXCY7fPsvq6XOz/KGL87KDur9sIRg3AFWKkbNcJCzZFNvavGhBxY/HQqnQVGOXrfdWQn/fWnkg+1CUQ3/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OrX9+naF; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7928ec5308cso28744285a.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 17:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715127522; x=1715732322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xz9j1cB4bE9JnQUPVM/3p943nBzNMqY3vx9jMGSHBwA=;
        b=OrX9+naFQS9UkKPEt3HpnOkrsjyikDK0VD/2KvV/4FGStGPTd8KGljTx5+pp2tE1k6
         6QFMNmqvyweyfxVP8q3FWwCN+1lo6GqvAg5Om+36DwKmo/DqslIgPlZf5kYUpmkNPrzK
         rQfmd9i2DaSVGO94nxMysAOpjLZxkA784iQ5IPHjjnv8iXhrShfhl2Rj4YmwTV9VOThx
         iwT7j5Z5rXLlxIbu/tlps6sNG8mxMM6DGZ8+4xVTNku29AbQlhof03IsohygdoXKEf7Y
         jhS/MRSWTcK9NfRYGoNe0j5NMxgzPzB8GSs8atVe1DI+dYf/qvwnn8HbvGovaTPPPsje
         GAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715127522; x=1715732322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xz9j1cB4bE9JnQUPVM/3p943nBzNMqY3vx9jMGSHBwA=;
        b=RXt8y7LYQlcbRwWKHfFCg0l7E/MUtM+aNVABpyFg5ZNfdEHsKri57yPiHqPeVmmj32
         W2lj5xOE0OjYF5tatH0RjdmH2xXsBTf4TD1070qIDOpKbYOR3sQS5oefack8v/AMA7Nt
         qM81pvW6VUCIvNhO8p23OP5lCVNIEDFDT38Jf9UJ34vUEzKICKHpkbwco0SYmsa5R8Ci
         CjX+dwLRZvBbRdcPpOiaQU7ZzyPzKGgmlJfSXeShy9LY05w9/oac3HLlBjcNDF3AMRD8
         78OMKGGp/UbbtGkioUkc3XeciDpzKmmQFIqy7Fk01sZWvE5/KjmO+XBYxxwmkqnbng+R
         L9QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjJ1BOEzIQP+//wEhla1bgMTzhfj2k/oCZb6IkKPzdql/bL1zFpoSc/Ff8uHTerkMzjHvUH2qzxRJ35sJEEk6pyCZMffFO1jyF7Opq
X-Gm-Message-State: AOJu0YxwoFZQlblM2mQ9KenoTrzZX/0y7bQU6S//eQ3Wrav4APt7ukrZ
	vKQlQKrROQpJbGYw4kvU9NjSEUgetTb38Di3YFXGF/vq+Rp9xhdfsRzx5+Xs2Eo=
X-Google-Smtp-Source: AGHT+IH/oKAJDpiDkQ/SfwUCo/HBUUtNt6FLW2j+wSJ+9VeCJKucyFKqJPPS4SU5qDn89BCTBGrk9w==
X-Received: by 2002:a05:620a:1901:b0:790:ec77:4c1a with SMTP id af79cd13be357-792a64cdb96mr636436685a.39.1715127522026;
        Tue, 07 May 2024 17:18:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id y7-20020a05620a44c700b007929ca64e0fsm2160454qkp.5.2024.05.07.17.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 17:18:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4V16-0004sp-PU;
	Tue, 07 May 2024 21:18:40 -0300
Date: Tue, 7 May 2024 21:18:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/9] iommufd: Fault-capable hwpt attach/detach/replace
Message-ID: <20240508001840.GO4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-7-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430145710.68112-7-baolu.lu@linux.intel.com>

On Tue, Apr 30, 2024 at 10:57:07PM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> index 13125c0feecb..6357229bf3b4 100644
> --- a/drivers/iommu/iommufd/fault.c
> +++ b/drivers/iommu/iommufd/fault.c
> @@ -15,6 +15,124 @@
>  #include "../iommu-priv.h"
>  #include "iommufd_private.h"
>  
> +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> +{
> +	int ret;
> +
> +	if (idev->iopf_enabled)
> +		return 0;
> +
> +	ret = iommu_dev_enable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
> +	if (ret)
> +		return ret;
> +
> +	idev->iopf_enabled = true;
> +
> +	return 0;
> +}

I would greatly prefer we remove this from the drivers :\ I guess it
is Ok for now

Doesn't this need a counter? We can have many fault capable PASIDs?
That will get changed in the PASID series?

Jason


