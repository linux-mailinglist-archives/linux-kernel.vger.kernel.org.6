Return-Path: <linux-kernel+bounces-286889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 351AE952006
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672671C2236D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFDA1B3F3E;
	Wed, 14 Aug 2024 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ch9G7Nm8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B73E2BB1C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723653123; cv=none; b=Teb2XtY24vnbvESfMmcrVcyR3pNhePioZ7dnwOAdc3y3AmUYU1pER551N4eoOXsQX9j18hymjl3cG2sHYccKQo0AH86xdYYafXgqq8k0J7JwzqNxaxBZLfdXNxF0VkCaN3u2qUSp2LlEZbOhZ7FhRzlkt7Z5BsLtLcP/4Wz+pN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723653123; c=relaxed/simple;
	bh=sjmlatt2FALf0Ln7dqSn1SM9Qe1qHhGhBTGOwE8pY3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4DjypuGFQAPjS0pUnTi2Y+y4VqWspi9zoHd3m9SEDg5KVgWt1+6zp1cfn3GoQfdMZuTomzACKPk3G4zHH98kAZFmyOP/XSN5ksM6mnRQOYznkNECz9Cnvt2vmjI5Ls9qGKUDWNnhgWI5DGUURYFzJI782Jh8kxtFkgmtcYMAW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ch9G7Nm8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723653120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nAJHyDS3x0gvP3kndDtDDCyfUKvxnbZEPAFmNsdiAMA=;
	b=Ch9G7Nm8l00oAAitR87aoyl2h61SAV4ORyKxjyxGkHGeyMfS5uqwPOIpEZPU5PvoONqC0L
	7V/T93p12gFpPHqWGfJimiinRyFdIKBnRDCHrA8QNI8/nlUdFnZDhh64SOK38LPLh3HSJd
	CpK4lurk8lsQnEzcE2vHZKCkJdDpzOo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-e7AASxShN1Ca2vZgIOaLGA-1; Wed, 14 Aug 2024 12:31:26 -0400
X-MC-Unique: e7AASxShN1Ca2vZgIOaLGA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-44fe92a34d2so424711cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723653086; x=1724257886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAJHyDS3x0gvP3kndDtDDCyfUKvxnbZEPAFmNsdiAMA=;
        b=nA3vP2Scet5eLASsXLEIsbrcK6BdA8ouEDemp32xi6p9Cn2/TV6LPJ9dtyNZylZfFQ
         7I3yRzE84VNcOz0bXZwrPKtg/NMdk9B5QJoksfL5pmL6EXNRkJGrJx6uLLRqyubiyU0R
         Bp/vDtpqWYBYomuVkaa91+fH6ObyIZ6unbt87DPIBWoF+7U7CPmorqCsb3AcDKC0LlaB
         NS9A3/T7YPB46ZgRZZCsa/gi34xKw7kuoEy6w1kd7EDm1oMDy1ve/PdDtc2aILBdlBAz
         Wm3u0BbWf8ho8zDAFiI3hI5Bvz41abLBMSHutFUMIICf2Zn7BV3hjWgxPPln8LeU2J+P
         OKCg==
X-Forwarded-Encrypted: i=1; AJvYcCW69kHTPWaBOXUjSCR98Lo0kFCDj7BpntGIG8xDLGMX3ItvITEvj3jzzwLvFpAdrfReSqBxIJ3fvcN5u1n96Ex7kahBzVjSzGqYcf21
X-Gm-Message-State: AOJu0YxLtm4i5BLe+5njS7FrK4OpN6DisMPWov/PyZDbOzivC6yXpKjW
	EwsZVL2N7l2sFE37bJkMnbk1wuSD2l75Lx5u6/difZyqqrtLTLG/Ea6Qha/9Ir0fyRqh+ULmKgl
	SXVVn9IBTpE5Yrkh2WiPGbSrNznaYPn8pCiTsEADvoeSaovq9I8kRo6Fv0mlXjQ==
X-Received: by 2002:a05:620a:4007:b0:7a1:d73f:53d2 with SMTP id af79cd13be357-7a4ee32e764mr396351985a.20.1723653085778;
        Wed, 14 Aug 2024 09:31:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcPEkykVU98AdM6W9o/QSTPGbN3EfEAVyCEDTjPHObiNLTpHiFF4NBrrvxVGHGtrmageAm9w==
X-Received: by 2002:a05:620a:4007:b0:7a1:d73f:53d2 with SMTP id af79cd13be357-7a4ee32e764mr396349385a.20.1723653085500;
        Wed, 14 Aug 2024 09:31:25 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7e13605sm447993785a.135.2024.08.14.09.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 09:31:25 -0700 (PDT)
Date: Wed, 14 Aug 2024 09:31:23 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] iommu/vt-d: Always reserve a domain ID for
 identity setup
Message-ID: <ykrcnvpm2wbiwepykl2wmitaabyp3yngw4dborhnlm65ek3ctl@6wteh2n6zrzk>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-4-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806023941.93454-4-baolu.lu@linux.intel.com>

On Tue, Aug 06, 2024 at 10:39:37AM GMT, Lu Baolu wrote:
> We will use a global static identity domain. Reserve a static domain ID
> for it.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/intel/iommu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 723ea9f3f501..c019fb3b3e78 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1440,10 +1440,10 @@ static int iommu_init_domains(struct intel_iommu *iommu)
>  	 * entry for first-level or pass-through translation modes should
>  	 * be programmed with a domain id different from those used for
>  	 * second-level or nested translation. We reserve a domain id for
> -	 * this purpose.
> +	 * this purpose. This domain id is also used for identity domain
> +	 * in legacy mode.
>  	 */
> -	if (sm_supported(iommu))
> -		set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
> +	set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
>  
>  	return 0;
>  }
> -- 
> 2.34.1
> 


