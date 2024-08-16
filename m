Return-Path: <linux-kernel+bounces-290370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1EB955300
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694DF284697
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F11143722;
	Fri, 16 Aug 2024 22:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yS/9nKNb"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2471D13C673
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 22:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723845726; cv=none; b=qrETVZ8diF4cYl7S0I4SVku4iz2pszFHpIHTQLyXUTmQMFA1a4ntZwbWwxY6Xc2bbQZv6Q4SFdrnqYDykPgbvo2Rz1Mr73zOfh0kVsUOyMVFRwPc6hnM0mGeUb6Y8XuCiRGYkF5Sqf2YjH3aCiJugmR3x52im78HFHxmUFV98mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723845726; c=relaxed/simple;
	bh=KtDb2ds5PWGJ0eczGNSDLNo9BC+Zrw9iC3EAo2c9n44=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PlAxFwfzBNRSKcfh7c93VW7PwF+uk/nTJQtfS5qRAiFqT3gI29JZRoDhjvLXEmi+aaOm4u3AF9EZh9/MPYravl9Ddypz6+yXZhI0iQDyA+zCK3I0LFFs79+VcGa1hFJA5lcIuqqHj8QL1oyhB9BE2XjZUAMCavL5KQQTGQJgqMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yS/9nKNb; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70ec1039600so2271083b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723845724; x=1724450524; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xl6sOD6Fpf5z06hGsRb94eJ2wtPWds8YC3LixShw2Io=;
        b=yS/9nKNbUHywUigcG7CV3NCcTL7ChlO9Ey8QEsLpY9ni16CPW+YNoDCS3jA1J6EJ4B
         o0Tc2ahxese6XkWeSpWyqDO2Hc2/FdT+7sWFWme4/rTsJQDL0465um3v70k57RENF+hX
         +USFnuOK6GiCGeBjUscI4aDRabhqGyBCsjVK4tOx33Hg5h0PVwlb+EuH1WN3ChAM8MlV
         r94J9/kCJ+p8cSIHJiGYxSAlyV+dgc56PH9iNMnp+V3uqd3sq6dEOg+5XYcAqYQFt4qU
         vyhWDg11k3y/mWzWDC8PsfHMvZtwsZlq9SWp4XYykXmcgPjFC+svv4SA9rmyl1ezSjuB
         oa6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723845724; x=1724450524;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xl6sOD6Fpf5z06hGsRb94eJ2wtPWds8YC3LixShw2Io=;
        b=hmRRFLr2pTO4gStFGCfUL9eTqQm6bnv4l6biZnyYLEIlvbgJdWTrXF5N9JWix8Vhwt
         yD/pVFP65AsfAPkOomkKpYSXLwsFn+rdG/pyoEWQJKvrkX2fKMV/1HvtwUA/vv3FNj22
         W4aE5ZTsfslXFq31nZ6/YrX00F61GW0DuTJXkq2wSrTpzyAFy7xJUx/8EoVXctAVoljJ
         /ZR5dScZXEwhF4IZhffILJtotJ8nmkhqUnJDTWM6iIOgZXn7cZbadpnFJihuhMuQeiFE
         VH5hpT0CSjWZfL4gJ3sQxWKdyuJd65V3QXnhHOIS/kPjqkbo11EJ9WZnFcpAnRmtJuTx
         IWTw==
X-Forwarded-Encrypted: i=1; AJvYcCVpbyjmVSOkm4+7t0McGtDWXAfp4kTYTio1EXxSeTiYwCDiaB5FplDFFy3A62AOTESchCDT1+niRiiRAmOb54/trbLeJLW5/4szb9q6
X-Gm-Message-State: AOJu0YwFpcETRxY9KHpx1hzFhbP59fx/aBOcXW3HLKuuMijBGu1LNdYl
	FL4x4g1mHJ1NBqE6J0Xw1nV2HNuktQ1ntyXxW/VHuoW0qq8E29DxaTP7BQzeQZEmDe7cBIUeilT
	XYw==
X-Google-Smtp-Source: AGHT+IGe13wCeSKnV+ARkXa2S708nSRm2RTHJKqZt8MGXxTiEkgm3AZbvp/51xLczJZtR937nuGpafrXYXk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:48:b0:705:ca19:2d08 with SMTP id
 d2e1a72fcca58-713c53d82d5mr11813b3a.6.1723845724266; Fri, 16 Aug 2024
 15:02:04 -0700 (PDT)
Date: Fri, 16 Aug 2024 15:02:02 -0700
In-Reply-To: <Zr_JX1z8xWNAxHmz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240815123349.729017-1-mlevitsk@redhat.com> <20240815123349.729017-2-mlevitsk@redhat.com>
 <Zr_JX1z8xWNAxHmz@google.com>
Message-ID: <Zr_MWkZwJHidWjlQ@google.com>
Subject: Re: [PATCH v3 1/4] KVM: x86: relax canonical check for some x86
 architectural msrs
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 16, 2024, Sean Christopherson wrote:
> On Thu, Aug 15, 2024, Maxim Levitsky wrote:
> How about this?
> 
> /*
>  * The canonicality checks for MSRs that hold linear addresses, e.g. segment
>  * bases, SYSENTER targets, etc., are static, in the sense that they are based
>  * on CPU _support_ for 5-level paging, not the state of CR4.LA57.
> 
> > + * size of whose depends only on CPU's support for 5-level
> > + * paging, rather than state of CR4.LA57.
> > + *
> > + * In addition to that, some of these MSRS are directly passed
> > + * to the guest (e.g MSR_KERNEL_GS_BASE) thus even if the guest
> > + * doen't have LA57 enabled in its CPUID, for consistency with
> > + * CPUs' ucode, it is better to pivot the check around host
> > + * support for 5 level paging.
> 
> I think we should elaborate on why it's better.  It only takes another line or
> two, and that way we don't forget the edge cases that make properly emulating
> guest CPUID a bad idea.
> 
>  * This creates a virtualization hole where a guest writes to passthrough MSRs
>  * may incorrectly succeed if the CPU supports LA57, but the vCPU does not
>  * (because hardware has no awareness of guest CPUID).  Do not try to plug this
>  * hole, i.e. emulate the behavior for intercepted accesses, as injecting #GP
>  * depending on whether or not KVM happens to emulate a WRMSR would result in
>  * non-deterministic behavior, and could even allow L2 to crash L1, e.g. if L1
>  * passes through an MSR to L2, and then tries to save+restore L2's value.
>  */
> 
> > +
> > +static u8  max_host_supported_virt_addr_bits(void)
> 
> Any objection to dropping the "supported", i.e. going with max_host_virt_addr_bits()?
> Mostly to shorten the name, but also because "supported" suggests there's software
> involvement, e.g. the max supported by the kernel/KVM, which isn't the case.
> 
> If you're ok with the above, I'll fixup when applying.

I take that back, I think we're going to need a v4 (see patch 3).

