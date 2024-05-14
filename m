Return-Path: <linux-kernel+bounces-178862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E058C58BF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2451C21A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DA117EBB4;
	Tue, 14 May 2024 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2pVjxJuB"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ABB17EBA0
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715700755; cv=none; b=paYbbxzPIU/9qRdkq+M/tCxZ69M4FaxwWsXGtW4EYxwtwTTIUwzLNdDnbZ7KRzP4xZHWMxtspCHnStnfXJ7DhW4ds+O+KSAYODXlyv3fymi+paf95So9Cb9WBM3U5+M5y4UUSfZYZDxbBmYlkDzkfqVNoGYz0pP9Bp85EyWv+9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715700755; c=relaxed/simple;
	bh=r8rIAmZZFsQuLhmNWTIfRBRPh8u5PDBf4iRKcoOpbIE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TZ592GuqJCGiE7DaBU1KwLGav2aVCyFlvPW7E3lL0lRwmrAlviKfKWFclFSAm63cF4NyIU7dQKiLrrY73rlgzvWVOaqgs89H/lLF/ZmfmUFLKQT+ZVndkySJe1VF+foi3bycYcsjvUBYyDS/MvbytSAepymHx/KAgKDBzR7hzhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2pVjxJuB; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61bed763956so106687027b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 08:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715700753; x=1716305553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=96h7eVdKwv07gp2AQvM4s1ztu5gg15ecBRGPyek6l9I=;
        b=2pVjxJuB+YGHZ6wOT8LKKNoPJtDJLWUisVXyhj+6ETy/Qf+OVveI/ftce6bbLuok74
         rLcI8h1KNr5V0VxjLbYnTCYqw6GXkCpTuCmOBUuT0RfRdnydp1ZT1Y+ZAHmQjq91z9nN
         3HFgW0+lz4ITQ5TahPbLvdQxZR2dZiWIN0n8FG+BRWpdNiI1tfHKr3LaovXuJXjZbpBv
         5C9sv4dKvA5TAnFXRDzkWsLHp9T0EQ4C44nokI3yo5gC4mxJQm2G0wE30lRaFNUqW78U
         Q13hmlo7Izh3QyOEb0VpZD3fARNu3/25QjKJOgxjDBcKtpGvL0bgcUiwIY2NgfKPf0vg
         KUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715700753; x=1716305553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96h7eVdKwv07gp2AQvM4s1ztu5gg15ecBRGPyek6l9I=;
        b=bNkMC/TpdrQpP8AyTLuWQCJMZ6yrdD2BrVpqVUAhabN763S7IioFm1cZ4ehiJwwKVW
         6Or5QQgs1qygVdKYqdg1tMdxZnUVVI3JWOzyPg2x0uYTAf3OhgNOmzsKgLvnPKswooFu
         kVTO8qStKivYliI1500Tq9Qv3LpYrsT9eLzD+fEVErWh73pDPFxYA6tDjhw/RHv/kLkD
         PwDERFCp0mzxcb4nRDQ5qJN3V+HQjQngmwQRb1zFtPpVqERQ6zqZbnW7eUgnvfCheTFH
         7ZnPOskWO3wrXAO48Y07nyHbDfVw/69ST/asjyMUMb+M6XQMUeZ7Uy4R+r/sznLYPujW
         uDKw==
X-Forwarded-Encrypted: i=1; AJvYcCV+aZjwCB7ZVqhPLLR2lJzPZs2mJFsuu/bQZUQ0jecq6xOIWr0yq2vW50GuOe+buRbXqXen9aig6EB4i2F+suczi+p5YpntxEI26zfu
X-Gm-Message-State: AOJu0YzkenDtBwllg9FEXzPsDjRbYbntSTA1e5zTuBzHmBhUR1KzeF+8
	qxR+D1Zz2snJO9TiBZ9q0qNexDbCopGBbTUN2Dz3OuYnNjtDh/B6ERx7UDaTpi1RALyGZGPlQd9
	odQ==
X-Google-Smtp-Source: AGHT+IEt1W8i3fCq5kLF6US0ejZDo0tU1jXXhpwhyf5EsV/KWGIikzFFKqxVOC4SdMnaQbHWMsNh6MWmkeA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:6c87:b0:61b:e15c:2b84 with SMTP id
 00721157ae682-622afff942fmr36354007b3.6.1715700753013; Tue, 14 May 2024
 08:32:33 -0700 (PDT)
Date: Tue, 14 May 2024 08:32:27 -0700
In-Reply-To: <55d00dc8-bfa3-4cf2-9c6a-1d81e5cfd7b3@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507155817.3951344-1-pbonzini@redhat.com> <20240507155817.3951344-5-pbonzini@redhat.com>
 <3b6bc6ac-276f-4a83-8972-68b98db672c7@intel.com> <ZkJOb4zJJnOAYnTi@google.com>
 <55d00dc8-bfa3-4cf2-9c6a-1d81e5cfd7b3@intel.com>
Message-ID: <ZkOEC3PbSmutUdsq@google.com>
Subject: Re: [PATCH 04/17] KVM: x86: Move synthetic PFERR_* sanity checks to
 SVM's #NPF handler
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, May 14, 2024, Xiaoyao Li wrote:
> On 5/14/2024 1:31 AM, Sean Christopherson wrote:
> > On Mon, May 13, 2024, Xiaoyao Li wrote:
> > > On 5/7/2024 11:58 PM, Paolo Bonzini wrote:
> > > > +#define PFERR_SYNTHETIC_MASK	(PFERR_IMPLICIT_ACCESS)
> > > >    #define PFERR_NESTED_GUEST_PAGE (PFERR_GUEST_PAGE_MASK |	\
> > > >    				 PFERR_WRITE_MASK |		\
> > > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > > index c72a2033ca96..5562d693880a 100644
> > > > --- a/arch/x86/kvm/mmu/mmu.c
> > > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > > @@ -4502,6 +4502,9 @@ int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
> > > >    		return -EFAULT;
> > > >    #endif
> > > > +	/* Ensure the above sanity check also covers KVM-defined flags. */
> > > 
> > > 1. There is no sanity check above related to KVM-defined flags yet. It has
> > > to be after Patch 6.
> > 
> > Ya, it's not just the comment, the entire changelog expects this patch to land
> > after patch 6.
> > > 
> > > 2. I somehow cannot parse the comment properly, though I know it's to ensure
> > > KVM-defined PFERR_SYNTHETIC_MASK not contain any bit below 32-bits.
> > 
> > Hmm, how about this?
> > 
> > 	/*
> > 	 * Ensure that the above sanity check on hardware error code bits 63:32
> > 	 * also prevents false positives on KVM-defined flags.
> > 	 */
> > 
> 
> Maybe it's just myself inability, I still cannot interpret it well.
> 
> Can't we put it above the sanity check of error code, and just with a
> comment like
> 
> 	/*
>  	 * Ensure KVM-defined flags not occupied any bits below 32-bits,
>        * that are used by hardware.

This is somewhat misleading, as hardware does use bits 63:32 (for #NPF), just not
for #PF error codes.  And the reason I'm using rather indirect wording is that
KVM _could_ define synthetic flags in bits 31:0, there's simply a higher probability
of needing to reshuffle bit numbers due to a conflict with a future feature.

Is this better?  I think it captures what you're looking for, while hopefully also
capturing that staying out of bits 31:0 isn't a hard requirement.

	/*
	 * Restrict KVM-defined flags to bits 63:32 so that it's impossible for
	 * them to conflict with #PF error codes, which are limited to 32 bits.
	 */

