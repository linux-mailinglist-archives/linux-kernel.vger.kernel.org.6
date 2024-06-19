Return-Path: <linux-kernel+bounces-221495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DB890F468
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479301C20DA8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3371154C0D;
	Wed, 19 Jun 2024 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aH4T97NA"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59B1153BFC
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718815584; cv=none; b=HsN0CxjkZQ1vWhfIHg5OH5Dc0WIsXiFhJcTid9Mbuq8VdUmkH0qXFbuYPBama24PrGEno2V+klVNwOuXdVYzAyf5s33YOgASVGRuN3LDFB5MT2SQi4V78OoTAzQ70cPG6ZrIy6pJ+XIPD3t3vnesdCzxdIUlVR1LiD9d4VZ0ubM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718815584; c=relaxed/simple;
	bh=i2wzYdncE4Uj1scV06TvR9t7Hu52uO38FhyEFQdg5Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2fvwK++Qddz4J9ak8EcoknGeChYs9IvCuk/2A69N1pN8Cu8Z9OKFvydvfWX2rA/T93/zyxtMUbGa2kI82twUAOZvPAEtkzBomxMshozoWxI9Uc9fMGj3xAuXnWzNuh02G7g2kqX5YvI1cuNW4GuAxPo+8lFiuuvxy25OXrj9gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aH4T97NA; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d4430b8591so1480832b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718815582; x=1719420382; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E8mnx4OwG0UyI7bQS+VANjYh2iOUaECLFPS0ndpki1c=;
        b=aH4T97NAnpuoyKRQGEcbdwJLjjGeys+2xCnpoVNP5S9K35kNNNFvB+XC5hLhf6ducq
         61hebsjTpu0hInZ4FnofX7TegA0bf0xZdEqwSMRQG/CSWBqUcLP/7MLrgrW+rQS4IJpd
         yNeonN6/sSLbSZyGT8/PLXhdFJhXlKPM+OIz5BlGdtVoNvIWoHY8WN0sXvOn1Vk11Q4m
         cChTasBt00AWd/uUN8mM3EPOmQZEZXXhhtul5z+4hwGm3UNMm2Qk/PZLPbeKaZP4Ttub
         umaBay/7iIdSkxudeEfn9DuFc3XOlMDqQuHgtMK4OnvBH1KyBgdt4AvJFKbeAQ9StpXF
         1qRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718815582; x=1719420382;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E8mnx4OwG0UyI7bQS+VANjYh2iOUaECLFPS0ndpki1c=;
        b=QnxgNbCRnQWvi3/ovHyMohrKFTnNXQhDObZarGCwrntq6gTqH6rOkR+mlwB5tgHSyy
         3kBxLjLT4jur2CW9f9eTtJS/Kgg/SGITFdSyOpFR84G4MLNSTYKXcKYuUbsLX9FEP+eP
         2E7epw1U9qSbHIijDKNkJsPjhPc+Njy7adu4a8cvBA9zyZ1rPDeDw4MLI3chAOVASXqE
         spc295WEzvBq6FPaEqQ2L/nqZE4r0ocW+emKpzasYC2SpTAxx/zWKB/C/YqrTzrbcThR
         Wow5me/+rWgUrQEEjqO3y/jM5899DL0jTE6BqtlYf1Sxb+hRyyhlhQTGpPWeA9U9Lbcj
         NMtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDwOW/Mgz+APKFv2PuxsaURU4HuVihvj3KfXgoijSfmCgwwk6g9wX1YGXyBjkz2PEIi2aGcdwfYqsJ7HFElp34A/HZRUcQGMfu1XN9
X-Gm-Message-State: AOJu0Yz+0rmHZzd8lKkBShf29XiLjHGtFnGeYSk+otXVnbHiA2EGHW8v
	Fsnh+GWKZJfFwJBmWcWJzIjAfUy3ldRP9h9uc4z0SlqiSlnYqlp/fdwPc0gLbwgZFlxolxTEB82
	6
X-Google-Smtp-Source: AGHT+IGneY1pKAnHRD88iFVlCOLssoGEupUkhzfkeqqSHzdXECbdWncqaGkPBBeJ+2eGeeDCX1uBdw==
X-Received: by 2002:a05:6870:54:b0:24c:a415:fd4b with SMTP id 586e51a60fabf-25c94a0e479mr2674379fac.35.1718815581733;
        Wed, 19 Jun 2024 09:46:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaedbf4esm620998485a.38.2024.06.19.09.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 09:46:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJyRw-005E9K-9z;
	Wed, 19 Jun 2024 13:46:20 -0300
Date: Wed, 19 Jun 2024 13:46:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix missed device TLB cache tag
Message-ID: <20240619164620.GN791043@ziepe.ca>
References: <20240619015345.182773-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240619015345.182773-1-baolu.lu@linux.intel.com>

On Wed, Jun 19, 2024 at 09:53:45AM +0800, Lu Baolu wrote:
> When a domain is attached to a device, the required cache tags are
> assigned to the domain so that the related caches could be flushed
> whenever it is needed. The device TLB cache tag is created selectively 
> by checking the ats_enabled field of the device's iommu data. This
> creates an ordered dependency between attach and ATS enabling paths.
> 
> The device TLB cache tag will not be created if device's ATS is enabled
> after the domain attachment. This causes some devices, for example
> intel_vpu, to malfunction.

What? How is this even possible?

ATS is controlled exclusively by the iommu driver, how can it be
changed without the driver knowing??

Jason

