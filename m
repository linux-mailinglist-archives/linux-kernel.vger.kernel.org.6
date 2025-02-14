Return-Path: <linux-kernel+bounces-515575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B06A36661
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE433B2D88
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCCD1C8618;
	Fri, 14 Feb 2025 19:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CBiZTzg5"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1395B1C84B3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562228; cv=none; b=KsvoGZ2B6GK+D32UKtHYc5eLo2tW3b/oMTl6gOIvch6YjtK3PJWnLUErafDvvajpKFn21TvUkWfLD+V0YmK8ykQGPxCbUi/5g86iei6qgLtL1P2446enRgyibLFFj730AEzOfY7h0AH44+rzm/BMWbvbNztkuORBqXjhzbsbDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562228; c=relaxed/simple;
	bh=mhtKeLm5igpgwc6h4fPK4Ajh2FAgScw0xgMCQuun79I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1K52MWWWt5Drf1b2kSrF8s7oatV81sWER0QC6FsFpKxlv5pmkRW4CDaoLv8SCSpWEcIUI10MUXFQSLcae46MqvRqKQOqXhtGu1Q95d2ltXkjQ16RJTUc4nqAOI/UoSIn7RzhxSboGJ1hYV0/dKQ8Cmv7/kKhoCIb617SOPNbQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CBiZTzg5; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e17d3e92d9so22532376d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1739562225; x=1740167025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=buGqXK8/ktUg8RW6l4BfFP62BuolnXWk213EnIe2HCM=;
        b=CBiZTzg5GKUOw30Ap+23iwklRbL66ng3YJfyVAdbawwpmTWgdMIVLSVudrkXbT2t9V
         AUNxZ6oaa6IzKAB5vUxlxm/7vEqHJWCy2Z0VrXyHmFjjVBkWpBzV+zWhACj1MpwPkXA3
         82Iyu6YO6cYWOVlRR+wOTg2ANTejluywnZ6c6ly2SIxoC1iPmrOG33RXHNyC/5d4grN5
         IZfJyLOLwWmbYIx3a+sbuUHeap0fvSkNFiobslWF3O4UqkWFEnu0h7WNB6bK73kwulxg
         wVvuSIuoC/KoiQP2KbroP5G7Wn5huqOwGqIwc6BqTsKG/T7qDrB5+BIP04WmameauOUM
         Lirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739562225; x=1740167025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buGqXK8/ktUg8RW6l4BfFP62BuolnXWk213EnIe2HCM=;
        b=XM9tEuVlDAFDqvE+thjrRyqC881lxMBjmcRILVwpEtG5qTmhDMCoUmRm4QG1FYmsXR
         iS7kI8t17b7Y+IWryg38K6ZQDsvU/3UxJpMz+uc4D6F/3xroziPDpEmSSCchXUGOT6Bm
         X9+w/dJkZ0PvRS0ggpQnMrG/nsJ5xXfZrtfKCfGaOyV8t7dMmHyqppxR+2FHBF/uPnpa
         YxLvVOENLaIOD98uyYTJnRMlCue9LpVMURCLJjn/w3MENq+Nrkn0OciuhW7CZxGuMJDq
         vRmina1iapqWKwXrhtbhYIDhQvnyo/RaHc+0MTteZJcmcAWmbV4OFLEU9uBvbxVYywfS
         qYKg==
X-Forwarded-Encrypted: i=1; AJvYcCVtpiCGUa1xLC903ej/6WtQgtMf3NF3+x/OM23+7LvC58tq3DYQX8wu/zK9P/A2nEGYjwTk6ZQYA/kMEao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyos+s85e3LpT6PXmtZ7ZIYK5aE6ZOg3EfhfViYM0epeRsFbjLd
	o6bva9RI23faq8U6j3B7ZifMbN81DJXBZhjwiBzIqyHm0HAd7n5e0OSL49DqO7M=
X-Gm-Gg: ASbGncvQUPDtFtP9OTR4w0H+qAjWc+40lbNN7NagBawMpEtL0QyiqhcQwjdU/81I9gh
	wqy0p5Il/17L+XH4yQogVWhnczSlGXiyQ+QDVpTm/EoLsXJVevZMSfe5DRo7JnP5J+QpwrXH/9n
	nhqEXCB+h1NY4W47soz2zP9ZXHYnOHYRFu5R8/bRKnqkUB6SILidiFfTIFUVS33v7DChdHMkRnh
	VZgvzM7QJWaerDpos3tXzjP07UiFGq5fj4rOJFJ7tSlCjDUAcuYKJNy+XqZ1RBy2eIlE6XyAVuJ
	jczt1wD7YZ1FBp1Hv4hqJ8Ud0qrwlhuguP6DrFKL9el9iRISbjV6sh/fgwPrqn4u
X-Google-Smtp-Source: AGHT+IFaSyYcyF+Ryh1E4s3MGomseXTapLkA1HeMxX8nrM5eJsPF5uZrRKBhBqh/ftWJjIpaJugHyQ==
X-Received: by 2002:ad4:5d6f:0:b0:6e4:4331:aae6 with SMTP id 6a1803df08f44-6e66cf38b4bmr7577546d6.39.1739562224840;
        Fri, 14 Feb 2025 11:43:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a439esm24231236d6.67.2025.02.14.11.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 11:43:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tj1bD-0000000GmVK-3Ena;
	Fri, 14 Feb 2025 15:43:43 -0400
Date: Fri, 14 Feb 2025 15:43:43 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH 1/2] iommu: Handle race with default domain setup
Message-ID: <20250214194343.GE3696814@ziepe.ca>
References: <cover.1739486121.git.robin.murphy@arm.com>
 <87bd187fa98a025c9665747fbfe757a8bf249c18.1739486121.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bd187fa98a025c9665747fbfe757a8bf249c18.1739486121.git.robin.murphy@arm.com>

On Thu, Feb 13, 2025 at 11:48:59PM +0000, Robin Murphy wrote:
> It turns out that deferred default domain creation leaves a subtle
> race window during iommu_device_register() wherein a client driver may
> asynchronously probe in parallel and get as far as performing DMA API
> operations with dma-direct, only to be switched to iommu-dma underfoot
> once the default domain attachment finally happens, with obviously
> disastrous consequences. Even the wonky of_iommu_configure() path is at
> risk, since iommu_fwspec_init() will no longer defer client probe as the
> instance ops are (necessarily) already registered, and the "replay"
> iommu_probe_device() call can see dev->iommu_group already set and so
> think there's nothing to do either.
> 
> Fortunately we already have the right tool in the right place in the
> form of iommu_device_use_default_domain(), which just needs to ensure
> that said default domain is actually ready to *be* used. Deferring the
> client probe shouldn't have too much impact, given that this only
> happens while the IOMMU driver is probing, and thus due to kick the
> deferred probe list again once it finishes.
> 
> Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
> Fixes: 98ac73f99bc4 ("iommu: Require a default_domain for all iommu drivers")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iommu.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

