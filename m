Return-Path: <linux-kernel+bounces-361496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 920F199A8F0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9171C21721
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90771991A9;
	Fri, 11 Oct 2024 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KMZrIiOp"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E8518027
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664385; cv=none; b=es5raMr4bkaUWUhq0uHB+mMpu18XVsrh7v7OznxaK7MGG4kZeKIf7iahGH+4pKo0IVKDggVriDPD7EyKpSIey3NnRW1hGCBmK8DvLemVYsTRl8t+w9phyyKCSLLwWE6iUf4e3E2BYMXgieSl1AwCuyDA86OwYCs0VfeYmiNFpyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664385; c=relaxed/simple;
	bh=xbQaPynXdEpvRxqGa7X5AdacfjDSR/YzwITPO53jrz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMfLYHJysmIOMrivIR1wKBsR82qIBiNAx9XqkuD5uHj7hQjySWoZ+aQeSYHtocKIZw5+82Qk9WMPmOVUCZm/RDQGEkgYcWHJEWAqPAuPiYRClUnQCTP1W2vsOD4zHjSWKAsUXgza7x+7TwGnzyc1aetr/zJtNnItw6paD7wr6WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KMZrIiOp; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cbf347dc66so4772826d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 09:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728664383; x=1729269183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vOLTO6qowPv73dfBzIlXGTy79lrTXY1ifwKbI9Z39rY=;
        b=KMZrIiOprMGviZqBXL6Ww04gtH1KSLRS6lxCkNWsP+qBI3nMNKbORhbUvWrYvVSzLN
         qDmYmXr3xQ7BPrVcGOV62uZ8NNYzevqUPxdeYVPYzpJ8hpFaMYPmw8o/waoceQ0RdNVy
         LzgF49CHjYucRSAmzPs6Qr+pv+hF6jBnA+mioF1MlJKCDIGkuO5MDQoMUUkg1hDwouxM
         SHe+ThIptcz9ryaud4DTOVOfIW401n7vJh4ca2w2eTy9FwVZyGofxvM3PVxDRCwIGotW
         Jzwr87wye95SArmVTShkd72eiC82chtBC2/WwYxbZ94c+KyklScxpATz1ZmDhXFS8B41
         rFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728664383; x=1729269183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOLTO6qowPv73dfBzIlXGTy79lrTXY1ifwKbI9Z39rY=;
        b=o/BnS3iP11y7VcCFtqGa1a1EUpNdcqOqEhLaybzNzBOdYUfWxRm59Bp0O5o3zcIG4I
         8T5b+QBYjI4cNJW89XBI1BYvQn8M0KfcGE2pgeS5QDac2CkMcQwcSuNySQ2VUki8xYTi
         aGNboRT4TphyNciUfUM/zJurjxoLwNluB6twUC7OYwxaPR4rHCzv0fXt3967hhMR3szC
         rbOqqTx31A5Du+9omFGAd3/UH1nYvBScU7OJRHSoYDap36rZwp/W/8aJ/i50gVffURxV
         GxvrqxcjYiaLAzBOzIR2kE3hXyk/l164o0V64acDdgoFVBmhdvzzV6wvW6lIQC7yEWfW
         iq2w==
X-Forwarded-Encrypted: i=1; AJvYcCUTRPd/Vey88/Ws3ZzZ4G1KefHi686kuk35DIW1wWKoQynCifHxUUYRfUTOnjhzrRvKGlJ5jA4TzIUsaxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQmHZodIhRGf6L7N+7Ouq2b1fJ2wsVBDDUp3vBJi42pPofOu24
	nXaVNiF2Tsem49x89VMKPEV1Cbq3kLc4pQ61g72WzFNDvcoKzv6dimYpv1d1Xjg=
X-Google-Smtp-Source: AGHT+IEEs/9BNK3lbSt1K/hYPpP58NiKoems4hd75VVnpLGrm2nR2TXu9DwOV4j9JmofQupNl7DYHw==
X-Received: by 2002:a05:6214:5913:b0:6cb:e69d:4c0a with SMTP id 6a1803df08f44-6cbf0102302mr47652796d6.48.1728664382945;
        Fri, 11 Oct 2024 09:33:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe8608d7esm16733616d6.100.2024.10.11.09.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 09:33:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1szIZZ-007ekU-To;
	Fri, 11 Oct 2024 13:33:01 -0300
Date: Fri, 11 Oct 2024 13:33:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] iommu/vt-d: Add domain_alloc_paging support
Message-ID: <20241011163301.GQ762027@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-2-baolu.lu@linux.intel.com>
 <20241011132252.GJ762027@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011132252.GJ762027@ziepe.ca>

On Fri, Oct 11, 2024 at 10:22:52AM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 11, 2024 at 12:27:16PM +0800, Lu Baolu wrote:
> 
> > +static struct iommu_domain *intel_iommu_domain_alloc_paging(struct device *dev)
> > +{
> > +	struct dmar_domain *dmar_domain;
> > +	bool first_stage;
> > +
> > +	first_stage = first_level_by_default(0);
> > +	dmar_domain = paging_domain_alloc(dev, first_stage);
> > +	if (IS_ERR(dmar_domain))
> > +		return ERR_CAST(dmar_domain);
> > +
> > +	return &dmar_domain->domain;
> > +}
> 
> With the direction that Vasant's series is going in, I think this
> should be skipped and instead your other patch to make
> domain_alloc_user (which we will rename) a full functional replacement
> is the right thing.

Though I guess for patch ordering purposes it makes sense to just
leave this and remove it the next cycle

Jason

