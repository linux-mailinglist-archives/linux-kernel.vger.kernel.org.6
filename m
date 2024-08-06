Return-Path: <linux-kernel+bounces-276640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9D8949673
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E821F22A0D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1444143147;
	Tue,  6 Aug 2024 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lM1pG80n"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D7F481A3
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964361; cv=none; b=fL/uwC+U1VSiG5aLqWx/LDzIUgeZFpzuB98FKgrZK4cVtmLqNs/y9wQFEKL5EU0mouL1v7ihPMzgNHVuvYmroiiUxX0aRjWpwwblwwKfVcQfyFstR+8BwdDjJkmbyvWB/FWgVWcxeq8dQU06tTxMk5ragD1d6BIZ7R16+yoL5CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964361; c=relaxed/simple;
	bh=Y4nXGQdMNF6rbUeYoiFqwWpEYmk4MMZ0QkxtYpu0YYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4P682otuaeqv8En/opGU3K7xGba9BLbZxoM0K+8tKuoheA4UlCqntQwkDWIrqSA2FnHe0N6cxz+JUVziZwnAOrDiPQ/oSU6no6IyTMEIS4attv83gyZDhupfCVAW9S8o2B94jK1bqomI35TH0CD48LeWzStaucPonHFtOf93tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lM1pG80n; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1d436c95fso45995185a.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 10:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722964357; x=1723569157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Paa1t7vb4Zh9PUcYQZ9rYJjYjP4JtD2ssWrDQwkK7e0=;
        b=lM1pG80nRHEXc2/r0Hwn9atBJTjDQgGbAzJa2Z6vcJd+1631XyAxjpvPs3kcDU9d1s
         nZKIbkZHXQRwGYrdXivaPXjX2RFljCvxvvfRu9lHfwXaOszvH8h2bvAZ1FV2pQYklT7M
         29kS9Mj/xGfBIueEpGw+UcT7stC1+bXuqEKbfoMwPWAgnzgN8hvhU4ZsaPkMjtcT/Qx9
         1W7lLY6IZl7oyHJL7LtekaYsnmcui+ksbauwrpYsiykkhG1NxohhpMxC1TUFxg0I0NSW
         ++DqXwHjWQbdPnM/fj+yU+YSgqyPzjD2JUqusjPXGiD4AV3lAuLDhQ4sdZE2UDl+rKzD
         Tlgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722964357; x=1723569157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Paa1t7vb4Zh9PUcYQZ9rYJjYjP4JtD2ssWrDQwkK7e0=;
        b=GJOurYjYscKGKa+p6R+4Q/w/Yfu1k94TWKgm+hpiWmrx2QI//oDTcEuJ77AX/tJOYS
         YfMW3nlDHCxuuONCPT94xcUKb0OwZ2Cv1T0RRkKlU8pOsQ5Nb50VmLpGDdNdbbpcRIn1
         nULyZWaSbHWPx687GvIZmHeWtQ9K48uT/g9Ecjil/Bwq9yuiCKySXGBXkJcHjeWqk5tZ
         +dD2aoHljielFmemdcykGhDSrFdkfU3ZnIRX5FzEDe0J4ncT9SbYonxDocXqajEyJUMv
         Q/4H5xziobSXiFZWsBNXOcAhQWH+/xnYHK4Kv9G7shyVabSpVM4Vzo+yHrWA1pVQOz67
         ZTwg==
X-Forwarded-Encrypted: i=1; AJvYcCXZXwwSYogoUO14GXUcuRUC3ffXZzwaLF5ZROjoqW0UZp4mZ0yPZqYbaGB3Ba/7swT7WINBqRTQHJEAYiSkmk6raHsGpwdUW36oyQH7
X-Gm-Message-State: AOJu0YykW2a99I9bgkwzbXVyulWENLn9roCqBqXaS42JpB9z0rDOancM
	Iru5PYwDxiqKjWJt3UKWvOjMpAPL8hqPx4YPMRxfXvQyKBuPqs3EppDrgnmZzJ0=
X-Google-Smtp-Source: AGHT+IE8W/7y4vs2RWEbhcbYMz+tVGwlO0vYOQAKxa5Dr1b8PGGexDfdO4ikD43yBmWeqI/PWBKLXg==
X-Received: by 2002:a05:620a:46a5:b0:79f:750:e5df with SMTP id af79cd13be357-7a34efeb529mr2013422685a.66.1722964357411;
        Tue, 06 Aug 2024 10:12:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f787aa6sm471273085a.103.2024.08.06.10.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:12:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbNjg-00FVPA-EV;
	Tue, 06 Aug 2024 14:12:36 -0300
Date: Tue, 6 Aug 2024 14:12:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] iommu/vt-d: Prepare for global static identity
 domain
Message-ID: <20240806171236.GM676757@ziepe.ca>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-5-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806023941.93454-5-baolu.lu@linux.intel.com>

On Tue, Aug 06, 2024 at 10:39:38AM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index c019fb3b3e78..f37c8c3cba3c 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1270,6 +1270,9 @@ void domain_update_iotlb(struct dmar_domain *domain)
>  	bool has_iotlb_device = false;
>  	unsigned long flags;
>  
> +	if (!domain)
> +		return;
> +

This seems really strange, maybe wrong..

The only callers that could take advantage are
iommu_enable_pci_caps()/iommu_disable_pci_caps()

But if they are mucking with ATS then the ATC flushes should not be
done wrong!

So I looked at this and, uh, who even reads domain->has_iotlb_device ?

So I'd just delete  domain->has_iotlb_device and domain_update_iotlb()
as well.

Jason

