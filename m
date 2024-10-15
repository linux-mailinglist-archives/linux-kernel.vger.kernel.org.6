Return-Path: <linux-kernel+bounces-366220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F2899F25C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D452814E2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C0C1F666F;
	Tue, 15 Oct 2024 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tIwSb2gr"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98AB1EB9E6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008660; cv=none; b=dHpoXT2KZwO3oaGpM3xpzNnBhTGsuc4K1vKfFwOaPoN1iSA459xgOB5q11X8cvTt44KwTm5IEY5e3EJUNBFeElEPbFge7aFSBeGZWCbBeqF85ofGySFiInDVf0ZXNs0zt8O7h0hZnS8uDg1/hmDkbgic8SNb0qvMznOK+jAyYQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008660; c=relaxed/simple;
	bh=GA7Fc81A7ztI7UbjRC/32RuEiP8RKKb4G220B9ue1HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qwt+rLUjvOgWJ+OPj3/2ZQjAel/T+ujfvrrRB/nUhuSz2OyztYlN56PvYdDc7Nwq/TXTngUOOBtK1yOZUrdKouTTjgZcabuLjoIl7YabQS09543YrMjl6ruBj+X/DdBozsdnJcN92IbXUUvOLk6Jz1mQ+l2zQVkYhmrDnPPbHSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tIwSb2gr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20ca03687fdso553875ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 09:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729008658; x=1729613458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xGYhfp2OqW3Qzmg96OVHEI/GKpsDJXQmbA11pdTZQhk=;
        b=tIwSb2grunQzvphk9vfpRKUs0laf2elGvUxLxWepdq7SEnQFamZn+G4XrZ0+1QOXuG
         Jtk/7WS3pap3OcfOfJzxLEttVElxRvzMzrxs0dDFD+LAnGWYPiyVbiq84HQoPC6zXInB
         lRKDDqLFJoH6NsIvC+ojEeM1nGmm3SLPHT78pteJbR1A11gVYcY+VqkdXssalBpIBqq+
         1Ws2m7DtgIBCr6KWkP0Mo1sZoQU5khVIFctPJz9YckuZ3+0EJR+uEXkgjZkwbdQ78lHC
         gwYakQ5jd9tZlq4EjQNvvkzgf0sDmNieYmwaFb78yCx6JFnHHglzFArUjcLKBVMnrP1p
         SbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729008658; x=1729613458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGYhfp2OqW3Qzmg96OVHEI/GKpsDJXQmbA11pdTZQhk=;
        b=w8+YMw8PphTPoOzyS8+/KitiYmltri/mVJBmaAT46hsVqNiyny8Duf2/D86GAE3n0g
         6DNG4p2S49oVvW1uzlfa7oMdU9dF8lig8Fbu4O8oRHFNNBDVJeHG8ljOoeXFcusnzvRF
         2kT/pk7Sn5xbiijOqRY9th40TcLR+V0xBiqx3/hXUBxxBdNCPvFVfDCPO7403ZBm4nu7
         I7rJQMk9pSUHUo4pMI1NZ6UU/nIN2mNZwoO/2hjI69+GbidvH+6jZsDh0fGwgGnm6inB
         x++h189qGPLTYCKexA3lvH3RKuEBgCwLCJlQAJ9QWK7f1Rel+DqhT60cSuR6/G2MT7mo
         RX4w==
X-Forwarded-Encrypted: i=1; AJvYcCWoVNhapyUKlOSvJJDu7F4U34A3Wkq6+wIRlUe+e1LokyM52ULllH5EuCnUyswNbHF8ioP7PfSNTrjXpRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKRwBSCnf4fTiMvupeUDNiBQCnWV4zhgn9cEhSUmYsbXbtwXkz
	5bXXi7DTZ43DlItcVQqMYD2P/3cXcwqAlSAQy+Rii70OKR0rO9onAJaeCcBMFw==
X-Google-Smtp-Source: AGHT+IHSgi8+1o+3iy2Nr5pCUXFLnZB8SwGxpqHUBhSE2VfhssmbiQ27u4lhyDBdI5kO8qO8nZD2aQ==
X-Received: by 2002:a17:903:22c6:b0:207:14ca:f0c1 with SMTP id d9443c01a7336-20cbce670dfmr7329985ad.16.1729008657827;
        Tue, 15 Oct 2024 09:10:57 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392e8ec9esm2017723a91.7.2024.10.15.09.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 09:10:57 -0700 (PDT)
Date: Tue, 15 Oct 2024 16:10:48 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC 2/2] iommu/arm-smmu-v3: Bypass SID0 for NXP i.MX95
Message-ID: <Zw6UCLprZj6aaajY@google.com>
References: <20241015-smmuv3-v1-0-e4b9ed1b5501@nxp.com>
 <20241015-smmuv3-v1-2-e4b9ed1b5501@nxp.com>
 <Zw4kKDFOcXEC78mb@google.com>
 <20241015124723.GI1825128@ziepe.ca>
 <ab21d602-5349-47be-b346-2fbc041fa13e@arm.com>
 <20241015153110.GM1825128@ziepe.ca>
 <ce7cc76f-426f-4d19-b4be-3964647a2f2d@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce7cc76f-426f-4d19-b4be-3964647a2f2d@arm.com>

On Tue, Oct 15, 2024 at 04:37:25PM +0100, Robin Murphy wrote:
> On 2024-10-15 4:31 pm, Jason Gunthorpe wrote:
> > On Tue, Oct 15, 2024 at 04:13:13PM +0100, Robin Murphy wrote:
> > > On 2024-10-15 1:47 pm, Jason Gunthorpe wrote:
> > > > On Tue, Oct 15, 2024 at 08:13:28AM +0000, Pranjal Shrivastava wrote:
> > > > 
> > > > > Umm.. this was specific for rmr not a generic thing. I'd suggest to
> > > > > avoid meddling with the STEs directly for acheiving bypass. Playing
> > > > > with the iommu domain type could be neater. Perhaps, modify the
> > > > > ops->def_domain_type to return an appropriate domain?
> > > > 
> > > > Yeah, that is the expected way, to force the def_domain_type to
> > > > IDENTITY and refuse to attach a PAGING/BLOCKED domain.
> > > 
> > > There is no domain, this is bypassing an arbitrary StreamID not associated
> > > with any device.
> > 
> > If the stream ID is going to flow traffic shouldn't it have a DT node
> > for it? Something must be driving the DMA on this SID, and the kernel
> > does need to know what that is in some way, even for basic security
> > things like making sure VFIO doesn't get a hold of it :\
> 
> Exactly, hence this RFC is definitely not the right approach.

Agreed. I assumed the bypass was needed for a registered SID.

> 
> Thanks,
> Robin.

Thanks,
Pranjal

