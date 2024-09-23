Return-Path: <linux-kernel+bounces-335390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F3F97E4EE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 05:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC2C2816A0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 03:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D180CCA6F;
	Mon, 23 Sep 2024 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CJqbDzzv"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891CEC13D
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 03:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727061019; cv=none; b=UQJIZZdJhcxmFvsYz/ry4C13rn2tz54EnRn4d16e3bjJ/X5uJjfe2lqaQqZ1MpXUwYr49tfsoRmyrbnDTXhgVV+pNGNE+fpjTnILTENcVydipL36IqHyJCgCh6gbSxvhKaD7W/OADjwLfe8fPKErYGxBQbeg2E6y6DE/x63K5Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727061019; c=relaxed/simple;
	bh=/d31PSOPr0RsVly3ijRCrupc38aH6Gm8vUS22l59aGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VM2JtVRE2knyi9ZscIT1PSiv9CvMXfIkYOPgpWCSmLeEpWef0AvwijerQOh2gnDLNzdB9F8MN6yGuhmArRtSYYK4XhNq6nOT6n6pacG3ISXKHEip1AEiySahVcjPkM7n5KAnpyxZkp37Dt6DM5TgybHXGA2enQlUD3I6emY+U68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CJqbDzzv; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a0cb374167so548465ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 20:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727061016; x=1727665816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IzUtqJjmty9wVx5yKerwbO2p6grMR3z7edk2LwQv0Vw=;
        b=CJqbDzzvVuboZq9c7dUIkN68C/lOM3EA9er6zZwgy+DTOGZUW/+lGJBPtgJii8Lwwg
         1PbcUGID2SDrroXNmqnZQyehMyZ0rN03jItt0/+UgcP7sgepiRjfj18K1QtfpzZzaN0C
         9pmtsFEc8vMjWTMHw/pi6TygIuxzPW4UrMGoNGc1bWYgsWjkn9ye4up00l7WYKeIzkAJ
         sP8QjIjVZuf4y+ALovYvpJQciNSqOxqMU1tb7OQU1JA/xo9MhbNito0cBbaa/s6KKnf8
         TItC8/R6Dj1fECqt7Hjf138pD4OfXAEkAQuipzh3X3tkUXHF+6s6ghjFcrmlBy+toMRR
         D5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727061016; x=1727665816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzUtqJjmty9wVx5yKerwbO2p6grMR3z7edk2LwQv0Vw=;
        b=UZhxavCOvvF7YivsXwK63bsH/mJ3wArb75zalnoPPgaNRHfekhl3Pa9XDP6VHgcYg7
         1Fqu8tW880Tva+JepO/wMuJMly99LUQh0d64yNXkVPZo0cTYUXd6FQ/T2yTqMHomSDEo
         ac9r+ZqRzoRHEEfHGqAI6Cy9VW2NntRLC8raEuychTcD40J0bv6kMoGbYJ2vGJJCvf2V
         ZrZ4otJYJeASaTo0AvtEDUct4Ce1CiJ3DR6rl3ub6UHBUL6u43qtF8xt9IKETJcGZfnL
         /jdCluDDe/aLhpeVMwPhA+gceseIey45hr+TeLMxvYT2A2mqBFAWxXBqOEvrezb0ArGG
         pvbg==
X-Forwarded-Encrypted: i=1; AJvYcCUw/6GLmWGCUn+YxzGbAhD4Q6utkoY5bej8xkO1Yw82lQJYUlcE4fVG/xQ6aPaP0kJdXBB9iThttj4obKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6SyhpoPMfBzUgGHQE4TO7gt5sp5FcGiiYWwP3JooX7d6x7bWp
	i1tfZBsgEcpNbPbHDmw+SIEkwrnyn6o/a6E2ZfQl6Hh6wPr5nui65xPdtbqJ3A==
X-Google-Smtp-Source: AGHT+IEwsVm3Qzc9hp+i5gAkymfFTBQJmEMGtLHZj6/ElZzuHZFcBIjTnNj27NumbPM/W2PkBv+lHg==
X-Received: by 2002:a05:6e02:12c9:b0:3a0:b0dc:abfc with SMTP id e9e14a558f8ab-3a192d3bd1cmr4622315ab.7.1727061016347;
        Sun, 22 Sep 2024 20:10:16 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079472e15esm124635595ad.244.2024.09.22.20.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 20:10:15 -0700 (PDT)
Date: Mon, 23 Sep 2024 03:10:08 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: iommu:  Replace null pointer check with IS_ERR
 in arm_smmu_domain_alloc_user()
Message-ID: <ZvDcEFXhpMo3K-Zd@google.com>
References: <20240922155621.49432-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922155621.49432-1-kdipendra88@gmail.com>

On Sun, Sep 22, 2024 at 03:56:20PM +0000, Dipendra Khadka wrote:
> The smatch reported following:
> '''
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3065 arm_smmu_domain_alloc_user() warn: 'smmu_domain' is an error pointer or valid
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3068 arm_smmu_domain_alloc_user() error: 'smmu_domain' dereferencing possible ERR_PTR()
> '''
> 
> The function arm_smmu_domain_alloc() handles the null pointer after
> kzalloc and returns ERR_PTR(-ENOMEM).
> 
> Replacing condition check !smmu_domain with IS_ERR(smmu_domain) and
> returning smmu_domain.

Hi Dipendra,

Thanks for looking into the code. However, I think this was fixed last
month by Dan's patch [1] and has been merged in the master branch.
Please pull the latest. :)

[1]
 https://lore.kernel.org/linux-arm-kernel/172381875518.1794999.1134549433569030700.b4-ty@kernel.org/T/

> 
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index a31460f9f3d4..19c53c6f7578 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3062,8 +3062,8 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
>  		return ERR_PTR(-EOPNOTSUPP);
>  
>  	smmu_domain = arm_smmu_domain_alloc();
> -	if (!smmu_domain)
> -		return ERR_PTR(-ENOMEM);
> +	if (IS_ERR(smmu_domain))
> +		return smmu_domain;

Quick note, using something like `ERR_CAST` is better in such cases.

>  
>  	smmu_domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
>  	smmu_domain->domain.ops = arm_smmu_ops.default_domain_ops;
> -- 
> 2.43.0
> 
> 

Thanks,
Pranjal

