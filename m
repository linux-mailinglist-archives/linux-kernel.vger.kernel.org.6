Return-Path: <linux-kernel+bounces-329867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398BE9796D8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 15:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A0A11C20BA1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 13:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779911C6897;
	Sun, 15 Sep 2024 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dJCjoYZD"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DF31C460F
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726407457; cv=none; b=sM/myChqmfSR9Hi3fob8DpAjAzAWRUILWzQ2VTbYz6PUkNlFBKD6CW5yDAQ95nijC4j/l/99sGqitQ826XH1NIEwbR1DpAuSze6zVy2DRxOunjYV4k7yWtdbPV7ciQljXUMcJXfwLdMt+NAzPVM3XsEBl09wF1A/mxRgO58dyqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726407457; c=relaxed/simple;
	bh=L6cmcVSm6s6ur33vGGXDnTAV40rwRA5m3muhdQu0Uw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzFZblFDSFqendDGHuaj9kUXlN03gGi4DoQuQy1vySaszvXVr6yPCcXVERVSIbR0nsTOlZCi7NtMPG4VheV+8IT6KYVZJoVEO1ybrUZfOtvpXoxrYiC/C9AJJoTL1rpMBlUhsiXm0ewDGyTXOqBxypzfbQNOXIfvKWhgitccab0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dJCjoYZD; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4583083d05eso30677471cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1726407455; x=1727012255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pJtqx75Y9mJu+/ng9YWrbJuiU7tTID0jo0U01oAXREw=;
        b=dJCjoYZDUVYwNbQUZ6A13ZV7FBWFrWnCFeMTnsZ39weIYZm1scMXNFRELtrSuwAbKz
         aLbgB+HzKR/zzNvxvCUqlvE60saTCV2fHhFjW3atAh8QjrMu+3sA0FxRSrfO8IvVmJ7t
         fqlNOOtRE5teuHz1p3FTN5hCbaSWOBTWoqV3OItqLW+mM6GZLHUaVzwFv5Ef/xbuWDfQ
         FZgxZGhOzXd/RyEG6pChLQJyasV+0N9RKE2QH86F9q3kPBh4xNn0UyHgy1BwB7ba2UlD
         v6vC/Sts18Fx/Yx7tSZjpuDkDtyAZQ5J+B+XGylRuKJz+lttYNfQCP297wE8Vfk6fhyi
         IHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726407455; x=1727012255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJtqx75Y9mJu+/ng9YWrbJuiU7tTID0jo0U01oAXREw=;
        b=Y+nwuSMFwsWEVILOdTKn83XvjxPovNI+9qjtnLGoRT0dw2pA3pxzqwd2JeJaWptN2J
         LNI98LUbFx26umDtwVY0PRsDQKicXZtCEEGq3At9l6Mv5h+f/OcVHAfKFsOSBzNhnis/
         YN8HKyB4ZCAowtX1H7rZ59C+mXyqkeySLQNOPFU7DhiqcJIku+IX18jHCgVRStqbXQEa
         4ojxRUnQakLK1919RXyg8/L/3W41WMzUIEAE+dexsJdunxKVoC3jOlI4wHGGyQ6HG/+N
         43ArFV1THvsJiviF+uxOecgTayLXuEo/jugenLm31fDvjJTUSsc2R2DLPIp8Q5Dh52Jq
         VYpw==
X-Forwarded-Encrypted: i=1; AJvYcCUyDnkfyK24+HIIVhEAQ2U80+l1ZXAjAnVtAjzsgJxShKYg4BRheCKX4eI4TIRcgo/Lp/TSWJP7dAIMr9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrJyGricrg35UHjaja5wEzXMCynCtLUzB1k4T8k9zC6efyZaLV
	E/COfWwV1uOk9V6R60POrCYFap6UW1dUUVmAD/ErHV/1w83Nxx1Lr+fVLe9KJWM=
X-Google-Smtp-Source: AGHT+IGJ/mUpSv0/GcRtAcb5ZNYaDe4lIMtDnDN+AsOyPpi1SYCFy++nuLWw+hu9AtRRNLvbm439UA==
X-Received: by 2002:a05:622a:51:b0:458:3207:4a13 with SMTP id d75a77b69052e-4586041ef4emr225680191cf.50.1726407455216;
        Sun, 15 Sep 2024 06:37:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-459aaca4a3dsm17953531cf.52.2024.09.15.06.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 06:37:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sppRW-007bBz-8u;
	Sun, 15 Sep 2024 10:37:34 -0300
Date: Sun, 15 Sep 2024 10:37:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joel Granados <j.granados@samsung.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Klaus Jensen <its@irrelevant.dk>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 3/6] iommu: kconfig: Move IOMMU_IOPF into INTEL_IOMMU
Message-ID: <20240915133734.GC869260@ziepe.ca>
References: <20240904-jag-iopfv8-v1-0-e3549920adf3@samsung.com>
 <20240904-jag-iopfv8-v1-3-e3549920adf3@samsung.com>
 <CGME20240907122025eucas1p26776e1be9713e21ecd4ee612e470d5ba@eucas1p2.samsung.com>
 <ZtxFAxM6QQBYVSJp@ziepe.ca>
 <20240911074059.f3i22vso6g6payrj@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911074059.f3i22vso6g6payrj@joelS2.panther.com>

On Wed, Sep 11, 2024 at 09:40:59AM +0200, Joel Granados wrote:
> On Sat, Sep 07, 2024 at 09:20:19AM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 04, 2024 at 03:17:14PM +0200, Joel Granados via B4 Relay wrote:
> > > @@ -51,7 +52,6 @@ config INTEL_IOMMU_SVM
> > >  	depends on X86_64
> > >  	select MMU_NOTIFIER
> > >  	select IOMMU_SVA
> > > -	select IOMMU_IOPF
> > 
> > Does patch 1 still compile if INTEL_IOMMU_SVM=n?
> It does for me. With and without INTEL_IOMMU_SVM. Is there a config that
> is not compiling for you? You can send that you to me and I can give it
> a try, to see if I get the same issue.

Okay, it compiles, but it is broken right? This hunk just can't be
correct, SVM needs IOPF to work

Jason

