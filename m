Return-Path: <linux-kernel+bounces-561546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1F9A61354
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304081895A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D84F1FE46B;
	Fri, 14 Mar 2025 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7hqIbrH"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C461F03E6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961217; cv=none; b=Jaz6uDv4sN/6Ug736gLFFlZLYRpaOmUlp2znr1/uf/JAxbr7gchMv3qKSc6krUoJ57bTZEvlcH1kgIcEcyBLw9XQbF+oETxTKGP9ekQkjp2Yc7qrJgMlpRrTCI8JHy2xDDxWwqMpkwoyC7wUcXbmVqbGL9/jSea2X6/3Hk0liEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961217; c=relaxed/simple;
	bh=8RpETn+FdL6begYD7ajY/6rjV7NaSs7qLxer9fBw2+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kz39bRBXCnOiKPSc93bmfxzkf0A4893gUNMdcE87IYnCNFJCtT4BcULgMcHXXMWJeBCqlqqY9+J3ADIMW/GqqbDOV2Be9bVN0t/tGNGXNlLveozGNFnLU59FAF/5+HkV+FIQOvyoGP46kAHBiLMk8HVPmu60nirCZWqK4A+mkWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S7hqIbrH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac298c8fa50so401613166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741961214; x=1742566014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xQ30pCMhWZJ/vu1HO8OFsVgK23FsiB3oCPyd4i49RYc=;
        b=S7hqIbrHP90ycYZvx8su08/vK2EnLux4MaDAnw6ZGtVgMDe1NpNqsojT6o/sxo9mOa
         bpJDKmWdNOltTvVTUWVxUvcZPfBgeTEUvNq9e6t7Yp2KE+mz4WJ8en6GcdxWYKCmn7ve
         Q50C1KkEofmzX1FETucbq2nR6Ln2PS1ZUgc4t4+ByHwskZc3hNSIk/pA0DCPX27eTnWN
         Bw64k/hipPzzkzq5hXs5EUCWAaeJIl/CTrQunvtGMNNroYZasF+LPAdXRtL+tx3223Ea
         1YcdCuUr8Tj39yOnn4CbNb/RMt7jy4qHptObeFlVDMJEspOYD+8eIV0GH0st5VHG3tbi
         mYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741961214; x=1742566014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQ30pCMhWZJ/vu1HO8OFsVgK23FsiB3oCPyd4i49RYc=;
        b=wnHiYTnWAuE1+OLncA961v/oNQtkvfeVbY4p+tYuZW+NQ/a5yA7OkE/atMTHxspake
         XgxAcCogrghXEm2xgfbu31FWnFMZJCDJgeNf4DN6hftuJU6KoyTDS6gztc34xH47oyTL
         aQoMZK3cPA+V1QSS71eHFqeStA8O8ZB52MWoOYmMzOTLXn+AFC7teg3mh1okNzdU0adV
         ZiqgcWn/8N1LuxefM9uO3aIaW8HGBYD/9Uq1yGi4tt2d6rjqZKg2wp/XFFgLmj789GnJ
         ZAHwXo62vmrD8cc3OOlWxo27+xrh3/q/qIohWHZz4lMdYFV8th7ICDCKIYfIUU2/5vVU
         nhEw==
X-Forwarded-Encrypted: i=1; AJvYcCWod5pGT51wbFkzI5Bq6VvQOHawlLxd9gDEXB6oCzvZQObJSf8q+baEljWGV0DJU7l9nRHoDBt5oI/+eOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfynqvXL1MGeHgB8gNZQvK6xDIvPzHLfKIz/WFhyg6PAgP8dtm
	mDi2Zi4EfYgosE8PKCsZcOA8XU2KTdgoXj3Aah7R3AWSXYq01ecVXLIjn1t41A==
X-Gm-Gg: ASbGncspoOXIUEYzby4uXbv2AOn7ln/GwILqiFbCCIvApYxN6/cdSVastiguanQkmw1
	QdJQZ8QGndkg6cWYfeBAuAb9iYlYPC9mWo5DG5RDPTwD4lNWxo4FlPjJjYc3Vq5Prgj4igm5hjG
	RD/iO63ggjKMOZKWakmtUGyOdt3HjvcqCHitHCCiUPdV2Kr481bx2RUn7IGb0cH8IS6F/jysGiQ
	8mR3LkNYiryvJbHxvHqQsrRt8vSfe8036qoaYFZw7h7wpme34WQQhiiUyU5BexzYlbX/kPForHD
	P5fuRD3bw3aeKGL0ro8hFNcedBNLYhskTF4aEP3NKtLJcvF51OE+vSmhBaISD4DhKTIhGHgC4QJ
	aJLp9USSQ/uRoqA==
X-Google-Smtp-Source: AGHT+IHghq3sPYug54WmaGy7pWa7JmjzZxIJe+VrPTG+PJgUO8Og3FjVLxNejtkRIYczh769vo0fOw==
X-Received: by 2002:a17:907:94c7:b0:ac2:9b34:89f4 with SMTP id a640c23a62f3a-ac330272cf7mr234942366b.23.1741961213314;
        Fri, 14 Mar 2025 07:06:53 -0700 (PDT)
Received: from google.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a49c37sm228471866b.158.2025.03.14.07.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 07:06:52 -0700 (PDT)
Date: Fri, 14 Mar 2025 14:06:48 +0000
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] KVM: arm64: Move hyp state to hyp_vmemmap
Message-ID: <Z9Q3-FM-QwiIn9gh@google.com>
References: <20250227003310.367350-1-qperret@google.com>
 <20250227003310.367350-5-qperret@google.com>
 <86bju3onl3.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86bju3onl3.wl-maz@kernel.org>

On Friday 14 Mar 2025 at 11:31:36 (+0000), Marc Zyngier wrote:
> On Thu, 27 Feb 2025 00:33:08 +0000,
> Quentin Perret <qperret@google.com> wrote:
> > @@ -698,13 +697,13 @@ int __pkvm_host_share_hyp(u64 pfn)
> >  	if (ret)
> >  		goto unlock;
> >  	if (IS_ENABLED(CONFIG_NVHE_EL2_DEBUG)) {
> > -		ret = __hyp_check_page_state_range((u64)virt, size, PKVM_NOPAGE);
> > +		ret = __hyp_check_page_state_range(phys, size, PKVM_NOPAGE);
> 
> OK, I think I finally clicked here. Does it mean that all the tracking
> is now done in terms of PAs instead of VAs?

Yep, that's exactly that. The hyp_vmemmap is indexed by pfn, so I felt
that the conversion to a PA-based tracking made sense. That also make it
clear that the 'hyp state' is not a property of a mapping, but really of
the underlying physical page.

> >  		if (ret)
> >  			goto unlock;
> >  	}
> >  
> > -	prot = pkvm_mkstate(PAGE_HYP, PKVM_PAGE_SHARED_BORROWED);
> > -	WARN_ON(pkvm_create_mappings_locked(virt, virt + size, prot));
> > +	__hyp_set_page_state_range(phys, size, PKVM_PAGE_SHARED_BORROWED);
> > +	WARN_ON(pkvm_create_mappings_locked(virt, virt + size, PAGE_HYP));
> 
> And this is the split between the state now being kept in the on a PA
> base and the actual mapping that is now only takes the page attributes
> and no SW bits?

Precisely, and the next patch in this series takes advantage of the
fact that we're now de-correlating the hyp state from the presence of a
hyp s1 mapping in the linear map range. In the future there'll be more
use-cases for this I think (e.g. the hyp allocator where we'll have
pages owned by the hypervisor but only mapped in the 'private' range,
things like that).

Thanks,
Quentin

