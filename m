Return-Path: <linux-kernel+bounces-361490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E92CE99A8E7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F42285C40
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C5F19923A;
	Fri, 11 Oct 2024 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Rhk/bN9X"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1044E198A31
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664240; cv=none; b=rVm8hyp2hEVNCK5ZtgtsaQIiBsat28pJj8Oe3rfDgDoYfoMgKalUBJ4rqcJM5uwLhNc2it6eZpU76gPzzHnLvlTxp7JrGNgZlQYrjBuxm6YMT5h5Od8BEGYyqsNygfjLIcE0x8oDyX0AvPrVQFYrftQ9LgQlevu730hNcK53jro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664240; c=relaxed/simple;
	bh=2Dt28Fwtz8IPz128aCTHRBpWzuAHFuoCTDFAVrA+BTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uM+gqHCCYHvrzeb/PzwJDUHkGmdw5yn5OTORI1sZpSgtkTmEGBlaNnuqPowOklFrKrR/1erIBimLDFb/uiyjgldHWqnZrbjkXkXCvHzhs0iWxOteewHMJUxX9c2ZRsuNMWUAsk5d5qNGysv4GwSnDTgHrrVM875NFu3Ry5bBTNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Rhk/bN9X; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5e7aec9e168so1042466eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 09:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728664238; x=1729269038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3HMYBZOfFBzfB3xbbGKRT2aXeTeXYa+qmBIc5mdM83Y=;
        b=Rhk/bN9XTopU12f/IGOKkyTxeRz4/jUr1jwrhwa4QEwFr7tXPPIipUWdK7j0HgsX5i
         K+g4wdQYka4NUekBd3PlU/HAGHFcOcyv+LyD5B3k6weBiQcOcpH35FvYdkZHZv83mGAZ
         mRNWH4ReEjThm3T2mucEKkUh8Wip4idPp7qV91Dt09//KR59fWxM+zPHiil0iGviR0R3
         ANm87M9OZGxPLxEdN1WimVsN9xcBOpZGT1FIJk3FCiOgYI8rGbYsKk01m3nSzLCM9OQM
         uLT7DtSBV0jyGK7sbzHGpW0rAn7/T5kzyOzdctTxiSesx7na8MwoeYuuU04knYceL+5D
         Kuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728664238; x=1729269038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HMYBZOfFBzfB3xbbGKRT2aXeTeXYa+qmBIc5mdM83Y=;
        b=l+9A5XBJpAg557CMvAnYsghnyevDDfM7t89GyuyBdyIhZGsS1pYH+8mf4+NCFRPPqm
         u6gzj+wrif6wMKrEkekHtGTJUsGW1DwaI/FLMM7Wl7GI0q9BH8bE+jw/whJ3jij//L0M
         PIECnSKHv7K713AKAATxPaf9BirrDuURiCWfQaDg3Ozr7Lk/9IRbj0G7KOf0js/zeDzV
         Q/roHjZHm9zysf3xRnp+u0PTeK7nGn2oo+yPmAY5TRaOJOykVWpkO5EatW3bxDmW1RWS
         aEUq4cuxFfI7BEt0ZqjjRz7RN8+z3Na7vzzioC8YvehRwkrsS9WMMeISfqBN9woBUduO
         U26g==
X-Forwarded-Encrypted: i=1; AJvYcCW7VNbzLJTusf6OISWEPvCDNDtgOfk07nJmY9ytVkjrgAe7bg3RIfp2wvRDJdh5hgR73w8dgWdxVf3IXO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx575J3UEdRCzs5fR8shS4taWAtMZY/2VJuphFPq3mO4olAfTeY
	gAgiaIaerGRwvZ6+2xBbqFDqc0ZYvPq9J4jfas90AdRoQcZM686g+24z3DXgC4I=
X-Google-Smtp-Source: AGHT+IHGT0DmoxFiFdtcfOeyfYi6NN5cYcuiaTlJxj6mXSXrbGwgzolCWN9AgIpKpOcs/zOIQVHqGg==
X-Received: by 2002:a05:6870:1706:b0:25e:1cdf:c604 with SMTP id 586e51a60fabf-288874761e1mr129847fac.31.1728664238001;
        Fri, 11 Oct 2024 09:30:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b11497acb3sm145223785a.120.2024.10.11.09.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 09:30:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1szIXE-007e6u-St;
	Fri, 11 Oct 2024 13:30:36 -0300
Date: Fri, 11 Oct 2024 13:30:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] iommu/vt-d: Remove domain_update_iommu_superpage()
Message-ID: <20241011163036.GN762027@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-6-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011042722.73930-6-baolu.lu@linux.intel.com>

On Fri, Oct 11, 2024 at 12:27:20PM +0800, Lu Baolu wrote:
> The requirement for consistent super page support across all the IOMMU
> hardware in the system has been removed. In the past, if a new IOMMU
> was hot-added and lacked consistent super page capability, the hot-add
> process would be aborted. However, with the updated attachment semantics,
> it is now permissible for the super page capability to vary among
> different IOMMU hardware units.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 39 +------------------------------------
>  1 file changed, 1 insertion(+), 38 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

