Return-Path: <linux-kernel+bounces-559078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60736A5EF47
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFB31895C83
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2161F264609;
	Thu, 13 Mar 2025 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DFQpRe3U"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF2C1F0E4F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857234; cv=none; b=vE3u15upEim41M+ZI4JiEN9EQigRUdPPuONnlF0vRF+RVKrOjdB/j4QKwVJz3kwv/YiF8k/5BmVuGe32Zw5LAx3LYdW0iBRsA/j1ogx7dIN4ni9hQ293IJlpdNaJv24o9GMflcz4i8GZTwjeqq3Rh3nODpYnGVQlExOn/MK4iMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857234; c=relaxed/simple;
	bh=ydB9bTeNot+OE1Xz0uP/spOJpO+hHXQWfxo/NKrFah0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6am8Bi1KeYTO/Ssw17q6lafJn9oAZeu2nEATSSToUyi9HyiEu1TUdCuJDXCLkBaYyavk9q5x3eF0VJIJcL1CemrmYVhGgOSItN9drTwOOPoLVtAaT8tnrBefiOcZvBYb152MQXMLLqJTsJZVjx8RYSeKiSbzku0bBdP3q5ulKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DFQpRe3U; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so4031035e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 02:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741857230; x=1742462030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A1vA9sHgurzlxpNTPQ3LIOp8IB6esizGYotCRKHRMvg=;
        b=DFQpRe3UkXzDaxmmom5RmpsTdbJDxNuDNiivDin1gnEa5Dh4DAW7uNAFUEFzsjyRGW
         kcCYgewraVCzIEcCunrWzyQej3//X3CsfLT47+9w8t+xbenV+iDBrUIGGBLbq8/8fa9B
         o/tmMPESFGOPcD5UQiNO0N9fCygAekQC7l8og/ofUQR18GHEkK1HOf5C5IWhkB2IJfxJ
         5aF3NsMjD5OqiGUT+mhlDRt6NEexx6KTMh/duWL+unl3MwqnyZAaUXpC7THeMtrareyv
         v9TBGvmFlQvM6W1VUVNazu1FfSB4ZffUDhJkZdDxhbAlKCGC9agTObnE6ugYlnuD/Nyz
         Q2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741857230; x=1742462030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1vA9sHgurzlxpNTPQ3LIOp8IB6esizGYotCRKHRMvg=;
        b=WhMbJHoWziAw5VFJ4Eu4jqawpaH1n5BVsfb9OxppywDJqhW8Y9zF5q+5YNukrnDxpY
         +xLsOB3DgMV+Z6kPEajlgBbr5aawBcaZR+t4IzoZPZhn4mUP84wsTaeAepj2W8D/UTsY
         8rjxmkoQ1inWgHaGY9/modCWHHHVXrilalHDt8wXtrxSe8muEqHHZ220f+Wnou/VtcMo
         nokojNUOhWBFPaHOD/DOkIKhAxw0rrBT0Z3z4f6YMAjrqKjklolAgLpc5sCe3HEX0m0b
         RJa9yPREF7EC/Hk5EgxAxtY4hoDhUJQnnXNO9BF3uCV1q4YjXNjCBxWGdixd+CJifGYa
         ZAYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/x7NxQ0ra2F6pVOJ/cnjQ6btJZ7l6K69pbsg1LYAc6f/Fre9Pr9n5LKG6De2ml0nqdRMt7HJT3IESDoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4j/zsGum6oKW8ETKg/aGrUHY47BrOzKz0FBY5eMVyDGttoO91
	Y2F5TsyDHNb24SFUUO+Der3Ha6FCBWSvqriXOUpCmvWvZmXhHh5Xq7/q8qGoUg==
X-Gm-Gg: ASbGncs3REJwp8zND9HspMiG9ZQVlHeWKjbuCFxR5UIHAfw9+6xl3Z2/B0CZonYiSiG
	vEw+jEGUpyNeXqfNwH3IoKwtbZDKEwRm4EvxSGf1ysbTp4DxYZCx4baMimeiNzrTkO8yVK/nTi7
	CU1qwhR32tt/AgP33XUr2buYGPHeOke/Tfkiwc69679FTdzCqsbumtw8VU+Qa/C6j+NABqHYSUY
	KRw6WP83WZl0oPpb71jcRpB4jEVpsyylSUGL8zpdtHUo9qaWFZSNoBoqo4wB/8d8PK7ym24uwIV
	9+99ieSU74MpY+lTJ6BLFN87I7wfKZoDbgDJ8uo7tcVXJyDlTUk5rqm0hEOg1Uaaipx0AFd5Uko
	mVrjFwiMYlfSp
X-Google-Smtp-Source: AGHT+IE8nhdSI8oCc7HhvHZ8FNICrr82pSWj5KiIjJGm0gYMIEOr9ifulYDK2iTUrARjY9lcII5V5Q==
X-Received: by 2002:a05:600c:3591:b0:43c:f16a:641e with SMTP id 5b1f17b1804b1-43cf16a6b0cmr139569915e9.6.1741857230356;
        Thu, 13 Mar 2025 02:13:50 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d188affdbsm13931305e9.7.2025.03.13.02.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 02:13:49 -0700 (PDT)
Date: Thu, 13 Mar 2025 09:13:45 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
	qperret@google.com, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH v3 2/3] KVM: arm64: Distinct pKVM teardown memcache for
 stage-2
Message-ID: <Z9KhybW0J2WIX1eU@google.com>
References: <20250307113411.469018-1-vdonnefort@google.com>
 <20250307113411.469018-3-vdonnefort@google.com>
 <87plim7hgc.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plim7hgc.wl-maz@kernel.org>

On Wed, Mar 12, 2025 at 08:59:15AM +0000, Marc Zyngier wrote:
> On Fri, 07 Mar 2025 11:34:10 +0000,
> Vincent Donnefort <vdonnefort@google.com> wrote:
> > 
> > In order to account for memory dedicated to the stage-2 page-tables, use
> > a separated memcache when tearing down the VM.
> > 
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index 12691ae23d4c..ace3969e8106 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -246,6 +246,7 @@ typedef unsigned int pkvm_handle_t;
> >  struct kvm_protected_vm {
> >  	pkvm_handle_t handle;
> >  	struct kvm_hyp_memcache teardown_mc;
> > +	struct kvm_hyp_memcache stage2_teardown_mc;
> >  	bool enabled;
> >  };
> >  
> > diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
> > index 3927fe52a3dd..15f8d5315959 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
> > @@ -678,7 +678,7 @@ teardown_donated_memory(struct kvm_hyp_memcache *mc, void *addr, size_t size)
> >  
> >  int __pkvm_teardown_vm(pkvm_handle_t handle)
> >  {
> > -	struct kvm_hyp_memcache *mc;
> > +	struct kvm_hyp_memcache *mc, *stage2_mc;
> >  	struct pkvm_hyp_vm *hyp_vm;
> >  	struct kvm *host_kvm;
> >  	unsigned int idx;
> > @@ -706,7 +706,8 @@ int __pkvm_teardown_vm(pkvm_handle_t handle)
> >  
> >  	/* Reclaim guest pages (including page-table pages) */
> >  	mc = &host_kvm->arch.pkvm.teardown_mc;
> > -	reclaim_guest_pages(hyp_vm, mc);
> > +	stage2_mc = &host_kvm->arch.pkvm.stage2_teardown_mc;
> > +	reclaim_guest_pages(hyp_vm, stage2_mc);
> 
> This looks odd. What counts as stage-2 pages here? Or is it that
> reclaim_guest_pages() is very badly named?

Yes, this is a naming issue here. How about 

  reclaim_pgtable_pages(hyp_vm, stage2_mc);

Then I can probably drop that /* Push the metadata pages to the teardown
memcache */  comment as it is clear what is pgtable and what is meta-data?

> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

