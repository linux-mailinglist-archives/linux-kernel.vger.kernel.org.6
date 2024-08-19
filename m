Return-Path: <linux-kernel+bounces-292088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D71956AE7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D493FB262B3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FDC16B3AC;
	Mon, 19 Aug 2024 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JozCceb6"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C4B16728B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070587; cv=none; b=B459IiM+zxumhZlA+NvQQBncuS13YqkV14yQNSuWzau6flSxGp3xefNcU0stJPfKBEb1Mgedya3Wy/d15e9OeriWwMajmicOCvQ0rSfn13zPvH92Pakb5C7jHqAC6xflki6FowUrQUS0MSeI5QocNCmNPSalNy+Vw+ApoPmGWIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070587; c=relaxed/simple;
	bh=bSNUXKGBjQKQmux5zNRZzh5oU+ewiugPLqR2rBPhmek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkMrPrDKudt1I5xDMVkkv937xcNxsiuIIZP1p/W7737I7y/G8a0Yf0SawScVJbet7OHhYEUty7AtsHoPHjrUwRIWxUaG+ot1fYmQckZQX5zlW6GsauyvgBOO79aBT1THkYzCc2YVmR9UtsLoqgP3o8WZTlryhWuQ0EVa3/xnJUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JozCceb6; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-70cb1b959a6so1370921a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 05:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724070585; x=1724675385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u2uduvQHU7RcRy7PnMogFpv26XgB0YOKAwBeGf5yMFQ=;
        b=JozCceb6JQ2uUPqJyozAcQrmncGsJd4ayGiILq8ygMT/bnAsY1k5iouaZh8TcW3FvT
         3pyR8ZGE6kZr/d/DAjopB0sRpdYrtspjc//oWHCkWufMDTPm+8uDKOk6eEn2P/WyyrL5
         knRgFRnfiJ/C8ncRbLrmV+Z0FoSGv+4YHo7FHyoQXMkHxMyqk4xt/rn6PzCs6E5B9I/X
         YRK3PKjBZaWNNa0vHoivfspEZHPG6pNAIW5ucSYKoCG81naLD/KTGYLzj38VYoOQxfNA
         htIurXpBhM9auHs8VYkq7HWj7JKIIqdpVI7q8zRhxnEhgQvk/u+Z4kRDTo/AlIBIziCo
         Klnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724070585; x=1724675385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2uduvQHU7RcRy7PnMogFpv26XgB0YOKAwBeGf5yMFQ=;
        b=ozR0oEZdm8hYoFOW1PL7bXX5Dea3GvOAjoRMsqowfjYNE3ybeJjWKLu/lMLkgoooHv
         tftxKvZdgdgdTbzjqkU9qhngw7x/Ms+qfko4pfFAE4OoSfVhF7mTxA5cfDPE5h4FxdTY
         BB3HBKhVFX0OyJ5YNJix9FqKylCT9S7k94OBnKf7FpYuOtY/KxbP9Vws+3SNIN2k3sVq
         qGAzG6UycXhiHXPYK4mDNe5BVBTucd5ziCKl3US/O5/U2/UBJhNKfdo+a33QFtVKhInL
         GxlAuE3di3035PXPnTz8y0s+YcilCsq/51CE1QLYRuK82hJuI4y/YjfJdFclXbghtjEz
         cT/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqax7jzRIT8IwUKI4MBh7uTSILGJoeulIQA891uJboIyd9Cmeu3705Jm+JN/0U3L+AchJaJca162HvgKTpxYIhgKHic/kRyxfOhwzK
X-Gm-Message-State: AOJu0Yz0Zn7jAfP1dne0/xI6nDJb9RMoXcH0JdMC+Ix+49bicfFabGMS
	BM5FgXltrO4FqMfKvo7JZMwFPYspm1LX0+NvVxNFKofPIn7Zd9tZ/TMem+mAbkY=
X-Google-Smtp-Source: AGHT+IEq64EJCggEORBlIJB1OWGqyMwlcWFmqpkNavRqagxVZRYkxxK0bKpUF6pEa88q/AkIt4dLtg==
X-Received: by 2002:a05:6358:2923:b0:1ac:65e7:9399 with SMTP id e5c5f4694b2df-1b393183744mr1458504855d.9.1724070585139;
        Mon, 19 Aug 2024 05:29:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369ff0ec9sm40028471cf.26.2024.08.19.05.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 05:29:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sg1W4-00CHou-2H;
	Mon, 19 Aug 2024 09:29:44 -0300
Date: Mon, 19 Aug 2024 09:29:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Move PCI PASID enablement to probe
 path
Message-ID: <20240819122944.GT3468552@ziepe.ca>
References: <20240819051805.116936-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819051805.116936-1-baolu.lu@linux.intel.com>

On Mon, Aug 19, 2024 at 01:18:05PM +0800, Lu Baolu wrote:
> Currently, PCI PASID is enabled alongside PCI ATS when an iommu domain is
> attached to the device and disabled when the device transitions to block
> translation mode. This approach is inappropriate as PCI PASID is a device
> feature independent of the type of the attached domain.
> 
> Enable PCI PASID during the IOMMU device probe and disables it during the
> release path.
> 
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> Change log:
> v2:
>  - Move pasid enablement the last step in intel_iommu_probe_device().
>  - Clear pasid enabled flags after pci_disable_pasid().

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

