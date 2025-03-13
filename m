Return-Path: <linux-kernel+bounces-560247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3464CA600DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10264188AF5D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227801F1911;
	Thu, 13 Mar 2025 19:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BM2m+0kW"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40341F1526
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 19:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741893202; cv=none; b=M82K8M4mFjQ5vpAh10Ygz3Fm6Ihi+nAy5i+6MtNcV71EGuDneDPyRkIRy/XoOO3aW9hrDAvu4j3neaNNg4Y5J3u3FpJmo4aEBfguS4m+WRC+zJEqHngKD2bKzF6KWIcsuT6+BZUxEHlbBLn5hB7pMxo4tqao5T84LyTYAqhiEYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741893202; c=relaxed/simple;
	bh=FtUI3xUhxfCo5TgFRn1lRnA7XfmVSLNMqAj1tPGSaBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V26aDNqNLw6fI6JKv+iH5vL5eHMFLI9UILI1UgaZ9+N4P2WQGBUCXGdrjhSvIay/bsMXVcFAtn07EMldMdvNP06Lmn9UfCAfr4BCsDs2b/Uu5U8QYiy2zQ1nMmyurjW9vMf0Vz7Jtk5o35gcSuB0IqyrskY80sk/g9ymtYdltRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BM2m+0kW; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so1984960a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741893199; x=1742497999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L3F+szF2XQGRywilPjvawnmOy3jehJGbZVMLTgFQTJw=;
        b=BM2m+0kWYaoOMaff7ibqlVxIW1NPKqT1tR8uFXbxbiiGioqXfO661XUiKjuVIjEO7v
         jeRe32l1128gVtt+iQn1PMoM1umRjTYOMwNVGi9otOMvSuKKnS9ec8uHsNdR0DnkZ0fu
         ijN8FMZaBB7fMSanneTRbnQ3Ii5fhWzraA2ECF0WIGdZsSLezb8Yp0swhveu/DCNz/Lt
         iKVM938dYzkottfKkg5uvcZlWowzW1+GeAQhxkRzUwLa40WxaSyO8Z5iT7EsjfucrEfk
         0ZiTU2UR19iKZkhMmiQzAoPQ6s0f9cuse6DLTTf8tulSlFY/DbbaOgGOv+WqnBiaNtqd
         Qcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741893199; x=1742497999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3F+szF2XQGRywilPjvawnmOy3jehJGbZVMLTgFQTJw=;
        b=fszTVW9O49famLk4YN+OMqIHW9iSGevcwyeydXrGPgEV6+B1We6mOfNDsRkKgjH2wY
         fJohHQc8o5klrfSJRV8kxornjJqOHPMaPPsKQP5ML70wyz/V1xzeT5JkFSO1FUsc1khq
         ZaL4VfJrzCm6QqhDEbmRmvtMfEHX+6zzhnJaVJQIb6olTZwmUIcEZdq5akxfnFoDItq4
         CISguWJwdNylhnm0Z5DGkiMlQQYa/M9uDcRCcmMH+CqmNvjPjKex00tw4IVwGfiBy2Ka
         74q3kItMIQEVdM4fTKehOs/LgbdSbfm8IPXwn1+wrFdpliJ6nuReuPJESUSVhrfLt+24
         Q/sA==
X-Forwarded-Encrypted: i=1; AJvYcCVQQSxWjOeUDq3RzmwUp+u+Hr2Er7vGzBTiSDftiAnrU7U9R+ezx+udELZblWecavU0rUu+H+8nbU/8dmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjJPhe8GgU9gw6vWLkiVR/BZQ3Btisl3ynVsUMJMx36vXLzkoz
	RJvn3JswOP3Iv6Wtlwt/NpWbzCfF2qflhWEhqZxz9+c7t1N592la8k2n4CbqJA==
X-Gm-Gg: ASbGncvZmsi9IC3XDwa26zoCigkP/YnUgUbGFRcqpdpjriQBG7uK9bagsAZUqrXw5Gb
	26zthTdhxD54QDDkwm+Uysae+igkg86helJmiKh8lagPPzePcIiLYuhfAYc31zupJKPefsMSnHu
	pSBIKN92/wED7YI+RVL3sKnwEc/Nesx+D8WN3hUhxEvOopsnNrAMI1py/kb31VHE2uwa7HZlvmV
	YlAJVGC/xAkmWe19nbUte3N81z6l9YGie0dtk3g9cyBRDGbze+s1FlZ7aOm4dWWeqH4divyvLg5
	ObBSCa0im7PeySY48PyQOwMISy8o9NVzSpVvOX52+geh2mwlDMm0dRdUC7rOxtxVA7c1iuZ+A83
	cw0ebLsm5oRYzlA==
X-Google-Smtp-Source: AGHT+IEanomM0uBClXIAdabeKJSIm41T83oGDtOVqnFsMRhIN+NlCFIyaB46i6op0dkiYwNIf1+dsA==
X-Received: by 2002:a17:907:9718:b0:abf:c20d:501a with SMTP id a640c23a62f3a-ac3290b6383mr73370666b.16.1741893198827;
        Thu, 13 Mar 2025 12:13:18 -0700 (PDT)
Received: from google.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149ced82sm113262066b.123.2025.03.13.12.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 12:13:18 -0700 (PDT)
Date: Thu, 13 Mar 2025 19:13:14 +0000
From: Quentin Perret <qperret@google.com>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] KVM: arm64: Move hyp state to hyp_vmemmap
Message-ID: <Z9MuSsOQuTy1kAwK@google.com>
References: <20250227003310.367350-1-qperret@google.com>
 <20250227003310.367350-5-qperret@google.com>
 <Z8V6xOVCPp7OOX6g@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8V6xOVCPp7OOX6g@google.com>

On Monday 03 Mar 2025 at 09:47:48 (+0000), Vincent Donnefort wrote:
> [...]
> 
> > diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
> > index 1a414288fe8c..955c431af5d0 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/setup.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/setup.c
> > @@ -194,16 +194,20 @@ static int fix_host_ownership_walker(const struct kvm_pgtable_visit_ctx *ctx,
> >  
> >  	/*
> >  	 * Adjust the host stage-2 mappings to match the ownership attributes
> > -	 * configured in the hypervisor stage-1.
> > +	 * configured in the hypervisor stage-1, and make sure to propagate them
> > +	 * to the hyp_vmemmap state.
> >  	 */
> >  	state = pkvm_getstate(kvm_pgtable_hyp_pte_prot(ctx->old));
> >  	switch (state) {
> >  	case PKVM_PAGE_OWNED:
> > +		set_hyp_state(phys, PKVM_PAGE_OWNED);
> >  		return host_stage2_set_owner_locked(phys, PAGE_SIZE, PKVM_ID_HYP);
> >  	case PKVM_PAGE_SHARED_OWNED:
> > +		set_hyp_state(phys, PKVM_PAGE_SHARED_OWNED);
> >  		set_host_state(phys, PKVM_PAGE_SHARED_BORROWED);
> >  		break;
> >  	case PKVM_PAGE_SHARED_BORROWED:
> > +		set_hyp_state(phys, PKVM_PAGE_SHARED_BORROWED);
> >  		set_host_state(phys, PKVM_PAGE_SHARED_OWNED);
> >  		break;
> >  	default:
> 
> Are the SHARED_OWNED/SHARED_BORROWED still relevant since the introduction of
> "KVM: arm64: Don't map 'kvm_vgic_global_state' at EL2 with pKVM"? It doesn't
> seem we have any !OWNED pages in the hyp anymore at setup, do we?

That's a good point. I personally don't hate that we have this code here
for completeness though -- it's simple enough that maintaining it isn't
too bad, and if we were to add shared pages in the future it would 'just
work'. But no strong opinion. I guess we could also remove this code as
a separate clean-up, this isn't specific to this series.

Thanks!
Quentin

