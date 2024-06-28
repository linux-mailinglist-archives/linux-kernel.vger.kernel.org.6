Return-Path: <linux-kernel+bounces-234739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1895091C9EF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 03:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB43528279F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 01:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B61925745;
	Sat, 29 Jun 2024 01:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oNoP67ZD"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225C21CD2B
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 01:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623517; cv=none; b=b5xXYjps+j7/7brSLyfq/JbLT1OmB6MTQ8cvIW7hFpzDKYRcRy65dtMWlecnMLxOmmCfKiTChZbiw8zNvI79EO8R9/9OaZoYa8XhQLNw2KGsNISHYoLSnk/13R0OBuYvbN9+Pe79aqlWJbc3mjakK1Bb1x9SK4jeaZC9oNA+fUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623517; c=relaxed/simple;
	bh=owo+cNn/TUw6Wew2s0YPnRqOgIVxnweK7ckD+KeIf3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyMH7UIatXB0wUrMevEqWyDJCgvi6f10Jzj5+g++Q758iH6snWlZD2pHzpKehn3OHkSUDz3Id6BEUxvISpHFidj5Xr+SlDubzXH8BNdAJGvcWBVtlgasty1oBzZ7vx6OmqupXehQQmpbkyNqMa76uDsAXEJltt6jhZQ55xiGqmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oNoP67ZD; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3737dc4a669so5098795ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719623515; x=1720228315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rdZPgDV7aIl0J73xlRHxxXH5BwM06TOu62VfOoYuq0w=;
        b=oNoP67ZDK6jQ+recwOVCPXahIloN/pLpGcWrh2tkNGEoenpzVjpFZp1FM1CwOJTn+L
         b48uoc/CfLTuqBpUaDWhara5Wv4jGamALaoBo96Hxt8XNA/t+2nU0mu5UWQEbWv7FsWt
         kNz3UGmsu9aE8qpld9AgyNPz5mq4xQ580rhm1rHA+aCQFLeUjmg5p5xIpJa+OG3dVzVz
         PwMw3CKZTXlGdnE6z4DCDookjiX/ai/3+ZoxGAh7xHnPt108aQBPmtDsZJIp76tUgZ/0
         ohX5wYMVpLxG71wECzvUwyfq52I69Oy6j7acnCb7tGe7nb7irmAktBYSpnJOLsbEYYNY
         iuxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719623515; x=1720228315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdZPgDV7aIl0J73xlRHxxXH5BwM06TOu62VfOoYuq0w=;
        b=ixI85t7Sw/iTMLrP0+dwKI7cd1WzbEIT8qwfum1JKEMGErYjHFnUQ+yUHEco4yj9bj
         LeAw2jXRBdYIMmJRb/BNE9L8PYNHrP9qXCGXPsHN3VIAQ6OWMcdALdxSeCYQC/wd5CQr
         lNXdCS9GghNGuLOx1VRSwxF8yBtgJDCrAX1A3BHeAFKclQyxNRjtquAl9wbo34Xzjt5U
         M4yXD9+8CsK5m256Z5yGcIO/Vo46mmvBwDDxRnRDqF8F6PZBxcGjuOCU+9PCHYO8pVkX
         E13mkBqvkt5EAkFwODEtZdKmHwq0VWvFequqxFs10tILMM5lC2rqabccTWLQW9zyrPif
         MKvA==
X-Forwarded-Encrypted: i=1; AJvYcCURV255+Hynv1UtZOPB2mLj+V0Ip6nuTkh68LI8vlmy1pcj25CZbx0v03a9Y5wDnhk6P3g1c2f1XpNbOw6Q5DFryRJ7Zp9OdJ+4n4U3
X-Gm-Message-State: AOJu0YxLRZliCOtnqX0HVdu3E6qvHzI3IWtXcv4yDlJWpA3VlWwX7i1m
	xG5rAv6wEUcXJWJ+RVY4YJOCdi0qWbr9a/X2/Cyro25I+fjSchYrJ0p4lfl+Oi8=
X-Google-Smtp-Source: AGHT+IHX2JUaclIoPrHTyWd3NWpAL4bg4r61iFuy9mfBP9il15TCI+aZkWxWAJEJRM9M8Gi0RE+u5w==
X-Received: by 2002:a92:c24d:0:b0:374:97b4:dbd1 with SMTP id e9e14a558f8ab-3763f633817mr217872295ab.18.1719623515458;
        Fri, 28 Jun 2024 18:11:55 -0700 (PDT)
Received: from ziepe.ca ([24.114.37.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53be5sm1784142a12.16.2024.06.28.18.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:11:54 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNJr9-0004o0-Ot;
	Fri, 28 Jun 2024 19:14:11 -0300
Date: Fri, 28 Jun 2024 19:14:11 -0300
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
Subject: Re: [PATCH v7 06/10] iommufd: Add iommufd fault object
Message-ID: <Zn81szS0G27keAwB@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-7-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616061155.169343-7-baolu.lu@linux.intel.com>

On Sun, Jun 16, 2024 at 02:11:51PM +0800, Lu Baolu wrote:
> @@ -6,6 +6,7 @@ iommufd-y := \
>  	ioas.o \
>  	main.o \
>  	pages.o \
> +	fault.o \
>  	vfio_compat.o

Keep sorted

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

