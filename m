Return-Path: <linux-kernel+bounces-348166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B94D398E39D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BF831F23DB9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F0A215F63;
	Wed,  2 Oct 2024 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aUpLpdDs"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EEA12CD88
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727898008; cv=none; b=nTxjAp8hKxbJVE7g/zg69uf8x+CaymqdphS0jamLSPb3xO1R2tL9bP3PUlVqsU362sc8DcLZkuL/NgUXr6A08oegeDnPPTIuqABSsmfpNDgxR6HqaICuA+xbsF+fQ0gMI8fYvI+w+Mua/L9GHKzukYb1yEF/0NDWMgIat0V/n3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727898008; c=relaxed/simple;
	bh=Ae7wgJ8xVhwLUvh//cxVW+Yp+e5yvaDUI40ohIjnxFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2VDZ7P+2UCahmr0n1V98t/CHd9W0LMarBSAtH3JIx5dlImmdbE93Zi7v/bQ0l480pcHoYge4Srpcv/9sTCfGEa1tFgaooCcKkuTjb904QyAA5R9iUSd7wxt7xV0oa7Hbrb0KQnCn2wtws7JUvqmlqa9uX8ChEKdpYqOcf31lmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aUpLpdDs; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e2772f7df9so1551747b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 12:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727898005; x=1728502805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XWf+180WAqlNPSTeQUTzH5C0QRhFJTEAE1PXHcV+amI=;
        b=aUpLpdDsIPAQsoHFs71YOGW2QDsRNKnE1tZdGzBuvysOKS2nrOz3OdfI/1TzaAVz37
         CBtQ2CRKgvx1IP1Ua23KCGNGx+mNqogQBmkVMz1Ig/OTRPlc6nCtLGGNAJOt1JtKMK0j
         z6P4k4EnaFyc8OG5MJ36eqI+8jY1106lJQ8+0+VAxTRgkEWlIFPwojxhw7qzjjqACU/x
         OAHriZ39dKuHe7Vsfk7FMVgSBjZvm1HqsEAef1hYwjLyxj7g8JBkVhvD5NLqpjBtPwY2
         LvyY7aS/uVeBEYMFAsgjwMiffSm0a6R4Du1GeZL11PcFemRTCTZWMBWEvT57G2jk26kD
         IZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727898005; x=1728502805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWf+180WAqlNPSTeQUTzH5C0QRhFJTEAE1PXHcV+amI=;
        b=A1NXUS0DQ/t2HfE0R30DaEKZHfoJPjVbZ3d2s/h9eF6blOpHKcQtRGhuWyfqPriPKr
         42dAu0gTMxi5b0n1u0oEwSqTVF+uxRpfIGYGwc5p3ONKLTyu2G0ERldM3rnsPCta9VuR
         vDBO24iQuX1xRZObRVrCSluP6Uk7oIHkvnrVMmLYwDFhI8OLT6LA8t0yWFR25KAr5CCJ
         jgbE6iOTOo4oA+plxv7L4ggVst4P+oPEKf/sqRs/tff6doSecJMXb8EJFr7H/t99klOu
         Ysp1aF20FAbqqXUTHKosi5iOW3IptLy0MAv+gkZMbGIapwlgBjfVQUsbqgZIRRolXMmi
         MRWw==
X-Forwarded-Encrypted: i=1; AJvYcCW5kQxQ2Z1MQAZywuOBZ5QNY6A9cuYzM518Q1YeyY3Fjo0mHBuO27NWowk5CVqeXSxMmfN/D97XZg3Ux3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZUhzOGYawi+wf5T1L/Z7pQZgoiiruwcJwud4h2w3Ghq3JSFmZ
	h/xSl8X1CWamYZjS3unn8t80qWFl9qp14PWzzARARg4olHRfEWMjmXmAGS+tnwI=
X-Google-Smtp-Source: AGHT+IGhwIXQ4Bo1v8MFBLP3lthjzh1jeRFAP2iZWWRBISVwy+gBC6xAgpsTfsX0NOhVcfPEVo8U8g==
X-Received: by 2002:a05:690c:6703:b0:6dd:e837:3596 with SMTP id 00721157ae682-6e2a2af63bamr43427407b3.14.1727898005490;
        Wed, 02 Oct 2024 12:40:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b6008efsm64396736d6.15.2024.10.02.12.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 12:40:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sw5Ce-00AE5g-Gg;
	Wed, 02 Oct 2024 16:40:04 -0300
Date: Wed, 2 Oct 2024 16:40:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, james.morse@arm.com,
	will@kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
Message-ID: <20241002194004.GT1369530@ziepe.ca>
References: <20241002175514.1165299-1-yang@os.amperecomputing.com>
 <Zv2ONA2b3+kMAizm@Asurada-Nvidia>
 <1c9767e1-4d05-4650-bc14-65a18fc63cc2@os.amperecomputing.com>
 <Zv2diJDU6v60hKtU@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv2diJDU6v60hKtU@Asurada-Nvidia>

On Wed, Oct 02, 2024 at 12:22:48PM -0700, Nicolin Chen wrote:
> On Wed, Oct 02, 2024 at 12:04:32PM -0700, Yang Shi wrote:
> > > On Wed, Oct 02, 2024 at 10:55:14AM -0700, Yang Shi wrote:
> > > > +static inline unsigned int arm_smmu_strtab_max_sid(struct arm_smmu_device *smmu)
> > > > +{
> > > > +       return (1ULL << smmu->sid_bits);
> > > > +}
> > > > +
> > > Hmm, why ULL gets truncated to unsigned int here?
> > 
> > No particular reason, but it should be better to not truncate here. Will
> > fix it.
> 
> Yea, and looks like we are going to do with:
> static inline u64 arm_smmu_strtab_num_sids(struct arm_smmu_device *smmu);
> 
> Then let's be careful at those return-value holders too:
> -----------------------------------------------------------
> static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
> {
> 	u32 size;
> 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
> 
> 	size = (1 << smmu->sid_bits) * sizeof(struct arm_smmu_ste);
>         ^^^^
>         overflow?
> [...]
> 	cfg->linear.num_ents = 1 << smmu->sid_bits;
>                     ^^^^^^^^
>                     This is u32
> -----------------------------------------------------------

It would make some sense to have something like:

 u64 size = arm_smmu_strtab_max_sid()

 /* Would require too much memory */
 if (size > SZ_512M)
    return -EINVAL;

Just to reject bad configuration rather than truncate the allocation
and overflow STE array memory or something. Having drivers be robust
to this kind of stuff is a confidential compute topic :\

Jason

