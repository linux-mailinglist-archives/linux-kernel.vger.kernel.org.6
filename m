Return-Path: <linux-kernel+bounces-276649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C57949690
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D973C1C22E93
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAD4482D8;
	Tue,  6 Aug 2024 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KtQt+Hs/"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D68846450
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964757; cv=none; b=QHi/0MK0SOD6lzmtrz6l3aVnKf+x8orLz+MfsKHUTJwUNtaGIpjaaCbNWx8hnVqmbAT66CI4MONBVkuAPIqSUz7ACd4I9ygt4TYwNHtkWmBRpX703Twk/dzA8s5i8GkP1yfwP5syk/G15GbgyJ7sD6873KKpnaPMRPSPUC8ycXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964757; c=relaxed/simple;
	bh=Hb/+tPVqAQWvgaPsgJW4aPVNF6FCLcdaqCDPIDqB//Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrmIKjnqrUSUoYVhkmv/jFAeR1xqkEeZmFAejjX3scbg4620DdBZi/v6Z6MT8TCMUz/HbNPU3/eAceQO254OEGitW2NJyI36fc/uEvcCex7QjoVdk+zebSDz70RcTfJOPEIpo1z4hZVLw63cDTW85+BXhqiWAvYZSyuxEKD5yKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KtQt+Hs/; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3db19caec60so498115b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 10:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722964755; x=1723569555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lnVSlhvJ85XTxy5jZqZA/ThJT+x+jYZ/M/nznNX86D8=;
        b=KtQt+Hs/0nOifjLMwDANkZ5kWq8PVW/p06bkIGOliDr+Mw5farE7plALewv2fAzssY
         n+1AOkSETID4WM1ES7mTpvUMRRrZUOQRzjZgTtKK9OKdK+pobzREj2P6XXPVuk5LDg5c
         Xp0eyhhsH5CY2gOvgLIRLv2eEzRx7izIrMueihHwk7oAgTE42H8D/loiJeKbGiMrk92K
         0fD9fzcSSbMCaTpR7B3eBHjsby4LlWqBB8gu0b4GvyUUj+KGJWdpJAMMFuZ/z2E52DqA
         vNex0TJ31S2ti6/5SMldhR8kgGAh5Spn2+u22gBjQ1Pa1ehwahXYM7BOs/EiIEy3CoZE
         y/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722964755; x=1723569555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnVSlhvJ85XTxy5jZqZA/ThJT+x+jYZ/M/nznNX86D8=;
        b=w2kmOCx+xpPVElZrXCbIQBW3V5zuXh72n1GTNBdl4unPtD28fnuJPpZxm7xROXpIis
         iP9g9HBQJ7PXS3E4m+m0hFviPO6LyrxawZMLi4goEIJPyARPQmBeyEoir8fDYawGpLWl
         vrOG1z4ApNeD3M6LN61B8GcQWCdOL7f9xI4Ezd1tK6M1krAgid8kSGrgfu610IPYeCC0
         pgrw/2v+aMHCGpyN5in8cisCSQOkPM54umSCC0R+uFtSw3PYSZoMDe8kr8k87eJwHJwO
         pJZ89o1XKVB1R+arDheCEPKC8JHMc/IXHcFV17thdWtcl8OLk3LnBpML6DC/7+9Yo81X
         1uSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsAcBBIgrYA0X+KROh88WjlzkmF7F/TwuuLOtgL5kTfJd3FJs22epWm/luSGhP6i0H1PN4jDYbvguoDKbILrk4E+DfeEhLdu0W1Shs
X-Gm-Message-State: AOJu0Yykh3B5dza5CFA+qz+yTvCcW2DcQtx6QcoNdA9PHTG1g9xmHiP3
	zXK9Lw1LvmvjyUy1Ftb4lvx1sNqdqmApcZNO+NnWCCcywqKtJIn7q2EJkC+n8pA=
X-Google-Smtp-Source: AGHT+IHI19NFI8GSPICZyj8vYfIaPfAqCHhgKRzwvZh0ZTjRq61net8P9HeYMp49A9Gp/SrOVlRyhw==
X-Received: by 2002:a05:6808:140e:b0:3d2:23e0:d7aa with SMTP id 5614622812f47-3db5580a00fmr22145427b6e.13.1722964755518;
        Tue, 06 Aug 2024 10:19:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6dc7b3sm475252585a.12.2024.08.06.10.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:19:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbNq6-00FXB4-Kw;
	Tue, 06 Aug 2024 14:19:14 -0300
Date: Tue, 6 Aug 2024 14:19:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] iommu/vt-d: Cleanup si_domain
Message-ID: <20240806171914.GP676757@ziepe.ca>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-8-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806023941.93454-8-baolu.lu@linux.intel.com>

On Tue, Aug 06, 2024 at 10:39:41AM +0800, Lu Baolu wrote:
> The static identity domain has been introduced, rendering the si_domain
> obsolete. Remove si_domain and cleanup the code accordingly.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 91 ++++++++-----------------------------
>  1 file changed, 19 insertions(+), 72 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

