Return-Path: <linux-kernel+bounces-287876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48BE952D85
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788A02832B0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176331714B0;
	Thu, 15 Aug 2024 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JkkjGJrU"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CED61AC88A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723721449; cv=none; b=YsomLwwvqFzwrClZ0Ne+KhUHT47AIV+I+PftlEuF0u90gk657Bv/tt66dfZO1sA0uTKjxVM63G4RlhgTkqvGNk9bqa7GqiZvc2J8gmYcdBpx0iiMXE3twc14D7NvmBFQ+nZdfXyf6Uot9ZCwOilimQWz53K3/BGUhJOM5dgTYzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723721449; c=relaxed/simple;
	bh=3hPeB0miGi08HxbqeR2o5mZeyed1ipEcLe4OJB8eAHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQ+ksrgAW7PkKjGH4BIQ1q5H2SJIAzxwm52kC/pe7u1GWRRHzgJwDLSysCFiIEkgH7L/KqncRufuQAqwb/aqlKzvFVIhKu+MbD8fN5r50iaDzqN6ag+/7Ff/rfbQCvDzhvfXW7zI9bFxqtT3KQWBt97cgmiw//bU8DE+9gC4XpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JkkjGJrU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-427fc9834deso28355e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 04:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723721446; x=1724326246; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nph2IWy3jC26Kw2+GT803V7uudXWcralv4F4DFT3HI4=;
        b=JkkjGJrUYXTXr0kMd/VNPhKbQrOL//XSNCrHtocnON0sbf5m7vf/tKsaYirozykNzZ
         i/yUxRnkWGVQqG02XcWosImDrrEAwoe9g/ymCsfGEifNa4PlNHSLv3qw6nTRm9qGCA0+
         a80YP5DGm+I3WR/AtcO6dOHZZKqpl2Jb4bttwinykTjs6YUTAR1AJOfOhuu/wuzg9de4
         wJb+fc+9dhxDHewld+1rtsHDw36kcu7V2YT86DCj4ChOzRSk0qDycvmlIJYdoHgJlCeh
         XNEtA/Nj9hk0TFs7mJfGw6LK4N+giRT9QjnEokpBEV9zLxIs0EampyIK+G7cntwQ/780
         JzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723721446; x=1724326246;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nph2IWy3jC26Kw2+GT803V7uudXWcralv4F4DFT3HI4=;
        b=hOkjtQLc9cZFkNIrZKk4dJaT7QtDSWYp2pLsfG8e1wC4aSn0SE8XJ820VHV9ceaLgm
         V7+v0yH0LNDGkA/T3//11laCYjoobbibT//Uym4/O+HUAGF5YFNCnTKYw5IjEYKD2TOP
         e38DkMvyt8hFJaUPKzcsn99bCbt9XIuihX1YR5MvaEOh2bVfehl6yEWTvu17EeLWR7yb
         XLXtgCNacMFxPUXAecHpkqDHEW931Mif/9SwDoC3RpSR07p2APjr9fpBp5ei7llSOTBU
         EbFLdewqlIe6TnVnrQZ1DDp+Uc9joX/Bb4MXbzkib5X/0zAYAaoemYA5u6VgY9cNaJL9
         3TYA==
X-Gm-Message-State: AOJu0YzUg5yo/lYrPvE2NCTBE/Z00QskNmCgxUAaUcUIzpozkdhVcKSt
	r6zsPrSCXOv0UaFNwIHtnCPB+MTkVsnVc1i5OI6daXAOQm3s+DBIUfoJNyFKIA==
X-Google-Smtp-Source: AGHT+IFpzQX/OizeMLkTPYCQLbf3yV11OTBYRepBz5eYNmZ1H3l9hqm/tpwdPV0j1jS4WBe1B2eN5A==
X-Received: by 2002:a05:600c:cc7:b0:426:6e95:6ea7 with SMTP id 5b1f17b1804b1-429e6bd665amr450785e9.0.1723721445377;
        Thu, 15 Aug 2024 04:30:45 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429e7c03d53sm16680175e9.19.2024.08.15.04.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 04:30:44 -0700 (PDT)
Date: Thu, 15 Aug 2024 11:30:41 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, jean-philippe@linaro.org,
	nicolinc@nvidia.com, mshavit@google.com
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Match Stall behaviour for S2
Message-ID: <Zr3m4YCY7Ape3R6y@google.com>
References: <20240814145633.2565126-1-smostafa@google.com>
 <20240814155151.GB3468552@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240814155151.GB3468552@ziepe.ca>

Hi Jason,

On Wed, Aug 14, 2024 at 12:51:51PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 14, 2024 at 02:56:33PM +0000, Mostafa Saleh wrote:
> 
> > Also described in the pseudocode “SteIllegal()”
> >     if eff_idr0_stall_model == '10' && STE.S2S == '0' then
> >         // stall_model forcing stall, but S2S == 0
> >         return TRUE;
> 
> This clips out an important bit:
> 
> if STE.Config == '11x' then
>   [..]
>   if eff_idr0_stall_model == '10' && STE.S2S == '0' then
>       // stall_model forcing stall, but S2S == 0
>       return TRUE;
> 
> And here we are using STRTAB_STE_0_CFG_S1_TRANS which is 101 and won't
> match the STE.Config qualification.
> 
> The plain text language said the S2S is only required if the S2 is
> translating, STRTAB_STE_0_CFG_S1_TRANS puts it in bypass.

Yes, my bad, this should be for stage-2 only which is populated in
arm_smmu_make_s2_domain_ste()

> 
> > +	/*
> > +	 * S2S is ignored if stage-2 exists but not enabled.
> > +	 * S2S is not compatible with ATS.
> > +	 */
> > +	if (master->stall_enabled && !ats_enabled &&
> > +	    smmu->features & ARM_SMMU_FEAT_TRANS_S2)
> > +		target->data[2] |= STRTAB_STE_2_S2S;
> 
> We can't ignore ATS if it was requested here.
> 
> I think that does point to an issue, ATS should be fixed up here:
> 
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2492,6 +2492,9 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
>         if (!(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS))
>                 return false;
>  
> +       if (master->stall_enabled)
> +               return false;
> +
>         return dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
>  }

Makes sense, I will add that to the patch instead of checking at STE
creation time.

> 
> And your hunk above should be placed in arm_smmu_make_s2_domain_ste()
> not arm_smmu_make_cdtable_ste()
> 
> Not ignoring the event still makes sense to me, but I didn't check it
> carefully. We can decode the S2 event right?
> 
Yes, s2 translation fault events are the same but with an extra bit
set (S2), and with a new field for IPA which is not relevant here as
we only report the IOVA.

When full nesting is supported, as iopf_fault doesn’t understand
nesting and only have the IOVA in addr, we would need to filter the
event by stage.

Thanks,
Mostafa


> Jason

