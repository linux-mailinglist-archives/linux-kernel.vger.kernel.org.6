Return-Path: <linux-kernel+bounces-349068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7A698F059
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA9B1C21456
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DDB19C554;
	Thu,  3 Oct 2024 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="D4KoFvFn"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63AA186E46
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962050; cv=none; b=ISay1q9sIvljxG+WHxEdplJAr08mlvp0i5Hc3l55vwLqwe/7tahQELZVGz0MhdODXzAGGhocSpqHhMs7Qjhx+j7cJZmRgmAbtKFo5d41qXstaPdnvbKPHnfmpvHC2C7LWHlznu1CemNEFqX4pMozz/U+x0An5GsCLmI6xXOpvuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962050; c=relaxed/simple;
	bh=bQDBIqvjgHLFGYT9bOVK3nBw3OiQmakouIHTBhyKrVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXsb2cJHZberUbkqUQCbqnZGIAeRuZvwbnOGtxnettI73+xZpr1LWmA7pipzajYsx2ttKr7ABEuYoD+F2p5vyxDy673HLnz6SannvZLrScIUytE8ARC3W6v+/QkopfHibeZuWsVoMGb2Fo8/MC/3t5t/wjqdGFWh1GsUAJqs9I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=D4KoFvFn; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-45821ebb4e6so7534831cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 06:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727962046; x=1728566846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cc2GtirUmQ6kR3TGzhvl/zPuGFrMGbjNkhjuKGHEBZE=;
        b=D4KoFvFnVfvIPUuYScbf6zxmMXbcTEIRwZSiT+SLdWxuIkMx9ZKtHk4bxJBvTKtmvL
         yJG4cuUQ/D+528SD/ryh4jQ+3qOZy+yYVBA9j43nAShSJoYxC5GQHeRwO15SR5k/gP4t
         JWNfZIGMOm85MHq4k+omu8oIQ7qUPl8IyaC0rQ0YLMbZiCo+pIEBMAoJNWfsCKvO8vhX
         MNnte7/ah+I0xGptDEz9+bUOxsyXo8Eo51ZceOfmNKSBDbRw2ziXHX7h0/Cg+Ks6bdtX
         vr2l9VOC0kENiwdCDUCFyF/fZrp2n4KszkDJnbFL0GnjchO20m9CCa1m+G0/zh9Vrg/H
         OCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727962046; x=1728566846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cc2GtirUmQ6kR3TGzhvl/zPuGFrMGbjNkhjuKGHEBZE=;
        b=s7aTqf506sya+scxNvc/H6myL2fKttZAgMivueM2ArPTjgcI5B7Ia/vf6malyiYvh9
         GkrDgLeaoyxSXoTx2Xs2Cp3RWE+KQvIDhHC2y3r8PnRSiUJKoAghyT/zuVLe0hCSmgYN
         xGcEYoOYOadi4VDowwg5liy6ifkKL0k6UYY1N9/MvmFO4AuWEcnkTSXTwEWgHElYGuCy
         KTY0EqnXPcuKq/26IoalYIdq1mqZPaLuzL5+ARBcGFB7TKsAwaC4/IZr1y9nH1a8W2s2
         8cuR1wVWh4SZL+6mq+HpIolG/l1KnqoX+F0HdZJ1f0WaLbYHUS64Q9YGYJT2oTKWBR72
         CWcQ==
X-Gm-Message-State: AOJu0Yy0q8POQ7jaalcXBIWBmMf0mJffY1e/drLK8u5hqV8sYaJDmWTP
	+0dfQ/g1INC2BDlZ/bMQDMhvrdxOLo8i9VTGcX5GrlWgmHVV9rQPv4JccYGLCFw=
X-Google-Smtp-Source: AGHT+IHdsqmMnAikLaL30SlmXTNHCfwHdVdF6V4bu8a+VKbWoQ7V+K/jqGWmGx8IKfbi50OEOlxglA==
X-Received: by 2002:ac8:5746:0:b0:45d:7ebd:76e0 with SMTP id d75a77b69052e-45d8054de1emr92224521cf.44.1727962046402;
        Thu, 03 Oct 2024 06:27:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45d92e30a82sm5511161cf.57.2024.10.03.06.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 06:27:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1swLrZ-00ASSm-2s;
	Thu, 03 Oct 2024 10:27:25 -0300
Date: Thu, 3 Oct 2024 10:27:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Gowans <jgowans@amazon.com>
Cc: linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
	iommu@lists.linux.dev, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Alexander Graf <graf@amazon.de>, anthony.yznaga@oracle.com,
	steven.sistare@oracle.com, nh-open-source@amazon.com,
	"Saenz Julienne, Nicolas" <nsaenz@amazon.es>
Subject: Re: [RFC PATCH 03/13] iommu/intel: zap context table entries on kexec
Message-ID: <20241003132725.GA2456194@ziepe.ca>
References: <20240916113102.710522-1-jgowans@amazon.com>
 <20240916113102.710522-4-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916113102.710522-4-jgowans@amazon.com>

On Mon, Sep 16, 2024 at 01:30:52PM +0200, James Gowans wrote:
> Instead of fully shutting down the IOMMU on kexec, rather zap context
> table entries for devices. This is the initial step to be able to
> persist some domains. Once a struct iommu_domain can be marked
> persistent then those persistent domains will be skipped when doing the
> IOMMU shut down.
> ---
>  drivers/iommu/intel/dmar.c  |  1 +
>  drivers/iommu/intel/iommu.c | 34 ++++++++++++++++++++++++++++++----
>  drivers/iommu/intel/iommu.h |  2 ++
>  3 files changed, 33 insertions(+), 4 deletions(-)

We should probably try to avoid doing this kind of stuff in
drivers. The core code can generically ask drivers to attach a
BLOCKING domain as part of the kexec sequence and the core code can
then decide which devices should be held over.

There is also some complexity here around RMRs, we can't always apply
a blocking domain... Not sure what you'd do in those cases.

IIRC we already do something like this with the bus master enable on
the PCI side?? At least, if the kernel is deciding to block DMA when
the IOMMU is on it should do it consistently and inhibit the PCI
device as well.

Jason

