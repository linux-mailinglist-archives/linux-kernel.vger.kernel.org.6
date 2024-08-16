Return-Path: <linux-kernel+bounces-289869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3C3954CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652EE1F2685A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656661BD02C;
	Fri, 16 Aug 2024 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lrd0Z0Y/"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185441BCA14
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819379; cv=none; b=ErS3RMQWHPe4fhDihtDOVrmXsflwLUKXFODsiqbSKsxqP6HW+h8O/dOS8Qt9uUFi5/dPz86cf2c1LtM1ncmGDM2NJtV9p2URm4HfOduwIjhp4dStL4JGuw4cwTzkXais1+8K51XYsNMctQQfe5e1eJzpRBXf2mXmUe38QVJSrW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819379; c=relaxed/simple;
	bh=/ZcdoQZgWUioXpD8yYGIrCkiY4QmlOOvZmIkF3rOxVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnlwPkT3MkE+TdTWN9AM1roGCH6XjJtGnbbsXxP7CPo7c035R2jvEon+b2ZAPdUUWc+KK7oLvbxpXnogoVj4sSXWew1f1YVhSaNnAg5l8EQE78B9gnvp4yzvp6/fnz41qc/18a3mekxwkyvLkYiCLqLCwY6ulgZQx6dZ9J0TQlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lrd0Z0Y/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bebc830406so7290a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723819376; x=1724424176; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=opFPN7f3AVgmlYBsPIGvsO2bTRdIA2J78NUkiklHncQ=;
        b=lrd0Z0Y/ubFrTr9zHiYcgt5StC4QwicbfQpplnB1kHSluFVBvADcRUP62vvaIa8328
         vVctLYTOsHS6JmKf0/qBFYXaT6RP0twDI4WI089Ph3z0a8IFMSANluTHw9oSz1uh49BO
         XKm6vx2fZVBQI2mc69tx94z61H+kKZp5BoAkazgwDe5wWlCdBa+BPZYiUHtc8isUPPTn
         +q4RfmV4mpfyH+l+paPNCGbRmnI0mKLXk99+jqDRP8r+4rEBbb1etb+wWHzZ9gidtZUe
         9vLAdq/tT52Y8vSXoHbctwAwzPIoOySXK24ZbPSwmcPcKOTbv6F2toHfHpOey1xXqtvS
         o/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723819376; x=1724424176;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opFPN7f3AVgmlYBsPIGvsO2bTRdIA2J78NUkiklHncQ=;
        b=iKVaTh29cR3NTpkLzhVLGydiWp8YMZbTIEU5ZFldZqnHTJ07shfQt5gNJ/TlzJTYTN
         NLJXXoiSKwXUyW2t8j4i19E/TZ0MhVWnigzpL6kDjwWhcagWUqob19FxfAixo10i7sN1
         atfWuus6cJfdLgnb9kq+SCmev8hVvvPCeQ6thoupZyoJETa+N/oVHYr1i31bOkKRwKNI
         rjDT1mULFOVzpf7dJnsyJ7Wgc1/L/zaR4oyX8vbDXa83X6gPZXlJ7wCAJd2dTA+qdXK3
         vUS9tV8cRSbB/nL7p+k28apa1srD4B8bdJ4cu3+arS9mcj9+ywtRhQE0EuPH3jfd0PFl
         +SGA==
X-Gm-Message-State: AOJu0Yx83c0w1MKLXhE7beAxXSz00ruHz4dn8Nh4n7XZ5DuB1v6MhGUo
	DykNdhcV0CqHhmXE5zpZRvRb7PO18RW4AvjOzitwugkah7Mqrp7BR1shpKugvw==
X-Google-Smtp-Source: AGHT+IELDozvOpO3OAJVEnbrz3xGHmp3wJyCr54Jrj7tBHZQPhYLug8LXtro0KRrV9QeYK401189nw==
X-Received: by 2002:a05:6402:40d4:b0:58b:90c6:c59e with SMTP id 4fb4d7f45d1cf-5becd6e59d2mr86465a12.7.1723819375968;
        Fri, 16 Aug 2024 07:42:55 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718984c0d0sm3764157f8f.38.2024.08.16.07.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 07:42:55 -0700 (PDT)
Date: Fri, 16 Aug 2024 14:42:51 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, jean-philippe@linaro.org,
	nicolinc@nvidia.com, mshavit@google.com
Subject: Re: [PATCH v3] iommu/arm-smmu-v3: Match Stall behaviour for S2
Message-ID: <Zr9la0hy34IDgbGd@google.com>
References: <20240816125901.3773388-1-smostafa@google.com>
 <20240816133135.GP3468552@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240816133135.GP3468552@ziepe.ca>

On Fri, Aug 16, 2024 at 10:31:35AM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 16, 2024 at 12:59:01PM +0000, Mostafa Saleh wrote:
> > According to the spec (ARM IHI 0070 F.b), in
> > "5.5 Fault configuration (A, R, S bits)":
> >     A STE with stage 2 translation enabled and STE.S2S == 0 is
> >     considered ILLEGAL if SMMU_IDR0.STALL_MODEL == 0b10.
> > 
> > Also described in the pseudocode “SteIllegal()”
> >     if STE.Config == '11x' then
> >         [..]
> >         if eff_idr0_stall_model == '10' && STE.S2S == '0' then
> >             // stall_model forcing stall, but S2S == 0
> >             return TRUE;
> > 
> > Which means, S2S must be set when stall model is
> > "ARM_SMMU_FEAT_STALL_FORCE", but at the moment the driver ignores that.
> > 
> > Although, the driver can do the minimum and only set S2S for
> > “ARM_SMMU_FEAT_STALL_FORCE”, it is more consistent to match S1
> > behaviour, which also sets it for “ARM_SMMU_FEAT_STALL” if the
> > master has requested stalls.
> > 
> > Also, since S2 stalls are enabled now, report them to the IOMMU layer
> > and for VFIO devices it will fail anyway as VFIO doesn’t register an
> > iopf handler.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > 
> > ---
> > v3:
> > - Set S2S for s2 and not s1 domain
> > - Ignore ats check
> > 
> > v2:
> > - Fix index of the STE
> > - Fix conflict with ATS
> > - Squash the 2 patches and drop enable_nesting
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +----
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 1 +
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Actually this misses adding S2S to arm_smmu_get_ste_used() as it is
a new bit :/

And that is not detected by “CONFIG_ARM_SMMU_V3_KUNIT_TEST” as it
doesn’t test stall in masters, I will fix that and add coverage in
tests for stall for both stages and respin.

Thanks,
Mostafa

> 
> Jason

