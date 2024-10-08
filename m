Return-Path: <linux-kernel+bounces-354467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E363993DD8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 06:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CB2AB2208E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89485770FE;
	Tue,  8 Oct 2024 04:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ckfdw51z"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885B237171
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 04:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728360703; cv=none; b=GEPBvOsHylFrEOXCGrBXDsijTaCdZvXH5bH9eb1XJRuNzFJBbZAoc0z0j18h3ueLrr46TiEcRb/87uxJXygXAOpqfC6Hkf/bW9PO5iI9zINf/pUBnPMWtuvhIuvfaNJ/lPoQ9UsjD8a3Luc8g/QUkBwOwaTbY2I0fb9WBlNdJXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728360703; c=relaxed/simple;
	bh=xHUeZPjnyNfxgmZvay/uXpUvSXQlNZnyff8aXOYTIhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIXsbNw2OcJt4BpuHZfEOOKiMCde+Ov093DC5p0GfzRYXVNZ6XY4CHhAG2bWGBkXsvPSh8v1twK4Nz85OgRQMHwm7ETKefEXdzHg/Tn7kbAjvf9jZlBza38rsndNDpZyKYWRgs9B4V3WrGcgbv6wxI7J1AY2EBZoktmp6lmC7wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ckfdw51z; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20b061b7299so96215ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 21:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728360701; x=1728965501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt8hffJScv5jNjHoFtqD8thrv7v16Xwl3JO7k28wD2s=;
        b=Ckfdw51z2y6U4Bm0Ya6jKd+atHet/r9dAU282Sdje1YWUW9Dy6PJ1FhaLKeQnXGMYL
         s7VCKfvvohur4LyZW/BeP8l4SApKlU3PowwBxhja/WVqtTyHC3Z3s8Of8I2V70YOukfE
         15R8rXkP8xOvo/qG+aPWAEgeiQml5Z9rFVm84zDMSKPkIsnMWY63lvirYyLMvcjtdInF
         YnAbLz6mVGErsxYlDJvOHmRjbM++AHOOmPOY9ahI5bS9wU4y8P7LGcoTo6BaHXfaFMkm
         E51joTcdBoYCUyAjjWQ4tT3lBmg9ybLMudSFoo7CbFZdJEjF5qX0BKd3mM52l4Y6RHo7
         8H0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728360701; x=1728965501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yt8hffJScv5jNjHoFtqD8thrv7v16Xwl3JO7k28wD2s=;
        b=t+ohDJMz2E9F4rnbwPKko7UA21vErbfLSGt2Z5K91EyI3EMstpGnz0jRvezlHbHHjn
         /XMzX1DPgjxxbr9uS7yUXyAuiPAMKhXNm91ap1tzlq5guHMYG2bBz9Ogvpl9hpzkw+b9
         GfhHHDVNncLSMTwm3gR0KuY5w7ouYYV7cMlrax8mw0PJAnwG1atu9ZVI9TRJ66COSBL9
         U9hP9aCQozE9WldLhJb4GL/5OFH1xdhA9dfqBhrYvGD3IQQnD7GhSVlr98KRr7mreE2a
         E0QqlOFDbe8lcd+u3yKK9YOYACvRmyjunN5dr6dNtu8wfF6tugBy/+K/+tVb6rVv79fE
         I4mA==
X-Gm-Message-State: AOJu0YxkNyyYxrtDBDjGlicbYlXnU6bSxFVZtXDOdWofzu36A25Vjz4z
	5YFrk48a6K2SfICjQP3qKlu9rYgc6C7zV1JDAJpn83m5BwdcFLeZ5m5EsOVruQ==
X-Google-Smtp-Source: AGHT+IEWOcc+/xlAlRTOTLbj2HgNvO32Gnzd5pqkk7sJNk0Hnf6Q819vTTIrdHPhT4iJJ/Aj8kG2XA==
X-Received: by 2002:a17:902:d50b:b0:20b:8776:4901 with SMTP id d9443c01a7336-20c5352f6b0mr1131265ad.27.1728360700548;
        Mon, 07 Oct 2024 21:11:40 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d4665dsm5211374b3a.116.2024.10.07.21.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 21:11:40 -0700 (PDT)
Date: Tue, 8 Oct 2024 04:11:32 +0000
From: Pranjal Shrivastava <praan@google.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	jean-philippe@linaro.org, Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix overflow with sid_bits when
 computing level1 table index
Message-ID: <ZwSw9OK5vMKgY6Q8@google.com>
References: <20241008031831.1254130-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008031831.1254130-1-aneesh.kumar@kernel.org>

On Tue, Oct 08, 2024 at 08:48:31AM +0530, Aneesh Kumar K.V (Arm) wrote:

Hi Aneesh,

> As per the spec, max bits of StreamID can be a value between 0 - 32
> inclusive. With the FVP model, SMMU_IDR1.SID_SIZE returns value 32 which
> results in arm_smmu_init_strtab_2lvl computing the last_sid_idx wrongly.
> This caused a failure in ahci disk initialization with the FVP model as
> shown below.
> 
> [    7.147067] ata1.00: qc timeout after 5000 msecs (cmd 0xec)
> [    7.147177] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> [    7.458320] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [   17.643140] ata1.00: qc timeout after 10000 msecs (cmd 0xec)
> [   17.643251] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> [   17.643359] ata1: limiting SATA link speed to 3.0 Gbps
> [   17.954651] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 320)
> [   48.107079] ata1.00: qc timeout after 30000 msecs (cmd 0xec)
> [   48.107190] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> 
> Cc: Nicolin Chen <nicolinc@nvidia.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Will Deacon <will@kernel.org>
> Fixes: ce410410f1a7 ("iommu/arm-smmu-v3: Add arm_smmu_strtab_l1/2_idx()")
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 737c5b882355..01a2faee04bc 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3625,7 +3625,7 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
>  	u32 l1size;
>  	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
>  	unsigned int last_sid_idx =
> -		arm_smmu_strtab_l1_idx((1 << smmu->sid_bits) - 1);
> +		arm_smmu_strtab_l1_idx((1UL << smmu->sid_bits) - 1);

There's another patch [1] from Yang Shi for this discussion already.
Daniel had another similar patch [2] which was converged with [1].
>  
>  	/* Calculate the L1 size, capped to the SIDSIZE. */
>  	cfg->l2.num_l1_ents = min(last_sid_idx + 1, STRTAB_MAX_L1_ENTRIES);
> -- 
> 2.34.1
> 
>

[1]
 https://lore.kernel.org/linux-arm-kernel/20241001180346.1485194-1-yang@os.amperecomputing.com/

[2]
 https://lore.kernel.org/all/fd04bbc8-8ebb-4091-b56d-32072587fa99@os.amperecomputing.com/T/

Thanks,
Pranjal

