Return-Path: <linux-kernel+bounces-287917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4EB952E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56721C21C6E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057DA17C9B0;
	Thu, 15 Aug 2024 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QTHmeGah"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE23F17BEB6
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723724814; cv=none; b=t6yPYwOkifC+QrDxBnUwq8fGKt/zBuGvhZZo/d6kNKTc4WzYzLxF58eb0fqC1mrLOzB4h92URjKtYzje5/rrmlkgSoloAhZ1PYF1twpZlIdREeJOtG2LeViA3QuNSqQgm+KRAz9fZPi9xsdp9NLrAEHYspOZVjDXQFRPtq0aHYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723724814; c=relaxed/simple;
	bh=750x1RMHzIv/ueCXLwScvIKOM9dB2CXFH/BKYl7u370=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOWz6CuJV0sWzatPDkKsY3TBEr2VChjgmSCSpboxSW/bPVAImaKBp16c1wFKss2iB+hIsIpXHedAfnYzbZNkg4ixILLcm/49NEZvCfDgEGyGEqpls3DlPT+aBHv4C0+yVX6n0xvsLjFsEz7zJ5Tpgdg2h5UUSeGt/36G5sJuIiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QTHmeGah; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bec507f4ddso1938a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 05:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723724811; x=1724329611; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sRNnLXXPpV7IoEhJzOcwO3JZYHZ/+fzxuXA54WcShzs=;
        b=QTHmeGahQq4mzyhiE89B7UaInIsYV5eG4U7wSGnJ5tJaIMbzrHfoRa5SvOgIeBttgl
         KRG5Tua05IUfAFRMkki1GOKxmg/yqVXISGk0fQruNgGlRconhuG5hw6Obctxo6GH0I2d
         fmq6hXKqm1/p3sDdgftnxlnuv5TsV7euXVh/YcVDhtKag8lyOOmChglcuK2dVQm9EkyU
         XRS71l2RVsc8qY3D8NgTHgN4XXDy8tlyxuKtLdGMdVxHVAXL3M/7PG6C6MwB6MorsJSF
         +xR+5jOqfIkg5ZzydSIDbd+Urmb57ntHU6IquYEuBujBiYxww7gpXmu9J0Hn4nkUYpMV
         PZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723724811; x=1724329611;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRNnLXXPpV7IoEhJzOcwO3JZYHZ/+fzxuXA54WcShzs=;
        b=X+iFcMtGIHR7SPHGZ9T0Kgxw53OOcjR6DQDHzbLbdwjCwv8S6nz9K5Zx5w8f65Vyu6
         Tqtu5UjqNEyk6gHljxoaIj4LbTP3BY0A6jpqK+mubSpMDqyFloL7318PIONJRq7r0Yed
         1yqfsgB3SeQZ+VAvm4g0gjcvrMXtaw1btOjLeoyRt7tPGCvPHMfPgkpDy6uuQt1PyaQj
         R/uRA6U/EeA1solTWF7MxHFI9+IP9lx6Mr1lZ1ve/2EwMAj+pbsmcK6GB3TuckXZzIXZ
         X0iBQCHiwtXGu5EyOdxbdLnjQMUuFxX702dbHEO0vUsucdSvX0YnCGPHiWtTXSxVD0Xd
         afcw==
X-Forwarded-Encrypted: i=1; AJvYcCXp8ziZzrMzhhZXDL0Pn5k1cYhZZ2UUu1Sta7+3yCFPPAcxHohGopCMU3Sr50PP1BmzEhUfi4z8oZ9Q91yRMD+l7Ct0NWFKa9aF2Za2
X-Gm-Message-State: AOJu0Yz1OLOAzor18Tw9qDLYCxT43y98BJ9QIoPJnR5JBwMdYDqCkjum
	fSk7IB6T4QgatJCSDMGo5oengJ8RVyQryy2deb1+OmxEbYdlGhFwiKM8Vfy5TA==
X-Google-Smtp-Source: AGHT+IEuekxOlZ5dLJvvllpYlIVkQLQ9BPwqLmRzpY5P2uQKac8q8/lokXLciY9vp8RMaQM8cBEPNg==
X-Received: by 2002:a05:6402:40c1:b0:58b:93:b624 with SMTP id 4fb4d7f45d1cf-5bebb9c4981mr57307a12.1.1723724810459;
        Thu, 15 Aug 2024 05:26:50 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded287d0sm48228805e9.12.2024.08.15.05.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:26:50 -0700 (PDT)
Date: Thu, 15 Aug 2024 12:26:46 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	will@kernel.org, joro@8bytes.org, jean-philippe@linaro.org,
	nicolinc@nvidia.com, mshavit@google.com
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Match Stall behaviour for S2
Message-ID: <Zr30BjAcVDKJPv3B@google.com>
References: <20240814145633.2565126-1-smostafa@google.com>
 <20240814155151.GB3468552@ziepe.ca>
 <Zr3m4YCY7Ape3R6y@google.com>
 <91d6574d-c67e-484c-ad96-91c9fd3d0c43@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91d6574d-c67e-484c-ad96-91c9fd3d0c43@arm.com>

Hi Robin,

On Thu, Aug 15, 2024 at 01:16:19PM +0100, Robin Murphy wrote:
> On 15/08/2024 12:30 pm, Mostafa Saleh wrote:
> > Hi Jason,
> > 
> > On Wed, Aug 14, 2024 at 12:51:51PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Aug 14, 2024 at 02:56:33PM +0000, Mostafa Saleh wrote:
> > > 
> > > > Also described in the pseudocode “SteIllegal()”
> > > >      if eff_idr0_stall_model == '10' && STE.S2S == '0' then
> > > >          // stall_model forcing stall, but S2S == 0
> > > >          return TRUE;
> > > 
> > > This clips out an important bit:
> > > 
> > > if STE.Config == '11x' then
> > >    [..]
> > >    if eff_idr0_stall_model == '10' && STE.S2S == '0' then
> > >        // stall_model forcing stall, but S2S == 0
> > >        return TRUE;
> > > 
> > > And here we are using STRTAB_STE_0_CFG_S1_TRANS which is 101 and won't
> > > match the STE.Config qualification.
> > > 
> > > The plain text language said the S2S is only required if the S2 is
> > > translating, STRTAB_STE_0_CFG_S1_TRANS puts it in bypass.
> > 
> > Yes, my bad, this should be for stage-2 only which is populated in
> > arm_smmu_make_s2_domain_ste()
> > 
> > > 
> > > > +	/*
> > > > +	 * S2S is ignored if stage-2 exists but not enabled.
> > > > +	 * S2S is not compatible with ATS.
> > > > +	 */
> > > > +	if (master->stall_enabled && !ats_enabled &&
> > > > +	    smmu->features & ARM_SMMU_FEAT_TRANS_S2)
> > > > +		target->data[2] |= STRTAB_STE_2_S2S;
> > > 
> > > We can't ignore ATS if it was requested here.
> 
> I don't see much value in adding effectively-dead checks for something which
> is already forbidden by the architecture. The definition of STALL_MODEL
> explicitly states:
> 
> "An SMMU associated with a PCI system must not have STALL_MODEL == 0b10".
> 

Ah, I was expecting that as otherwise it's contradiction, but couldn't
find it while searching. Thanks for pointing it out, I will drop all
references to ATS then.

Thanks,
Mostafa

> Thanks,
> Robin.

