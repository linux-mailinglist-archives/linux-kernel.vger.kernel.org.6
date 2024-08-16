Return-Path: <linux-kernel+bounces-290360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7C49552B0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E181F23881
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220FF1C57B2;
	Fri, 16 Aug 2024 21:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="octqA8eo"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F141D7C6D4
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723844963; cv=none; b=pY+xsAIHwa+URYb5srs2NM0VtFzmZvrPr8ieX4iqoD4fmDYHzs3tN59+l5cdeZmvePm9qiU1mfz0pUK83cyiL312qfmiyopBuER/RUH8bESdCaL+r0kJ/K6SyxlW3KAwC34ldFgeP/S+Svi7SOjYk3cvqIeO6qFDQcZYh+YIlOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723844963; c=relaxed/simple;
	bh=OGQ7WZrVLTJ0pBljhL5oPE+F/gv8Y+hNJQan50IpCWk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SKhuQUniLAOHmB0jEkPb9bV9oXil44JFp31e8Y2YcWRwkfi+yL3/SCXx1y+HRY/rR246wwJffRIqLnTMPxJkjCJHM9P24DuYK4PTL+InopxW5obqGm7LISQ+pGm0kxtC1mOFIslxpkaTMYWZp8bYhn6SgKSKjdGK+7dpXpVOL0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=octqA8eo; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7a23a0fb195so1967320a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 14:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723844961; x=1724449761; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cF6TDGuCzVhvL73s1WFyMM+Vfbt+o6ZdWp8+twlWiMY=;
        b=octqA8eooioiHpY4QCJkTcZoHB8qtjeWsjAVgPNBQme1sCu/Zc9Ln2aEdL+TZa+kbs
         YYI42tly7Rx0EeOAmClRtMbr/z1wduWrPICZjx4eEeoghbXljbSbTSp90S4HBGGYMJv0
         SoDGnkEh0Nio4x/LuNb5yh4QNWgTZ1ciMB1ixgqkD/g3R+4kxt+lhbikjuhomVpQwjCj
         B4WvU5bcysET4CYPD2XKdfG+VAIIdEFEFdf7jPCluXfzxa3pYfxR6Zr372Sz3qMMOUkg
         4XYrhXNKloyl2+oQuDJmK48/UQzhAfc2R1jVGDfuScNGsDOSBBSip5CLjSqtWseFk5Ja
         5IuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723844961; x=1724449761;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cF6TDGuCzVhvL73s1WFyMM+Vfbt+o6ZdWp8+twlWiMY=;
        b=TEFPiRK/gFZT5BMLLhuCbXFEqciYhzzTuPp9e8StqFW2suGvHam8U5R3F917VmX/bz
         I4bJK484bduUMZcyvpJFoTbOrTut4rRqzUIRlweq5F5i/gcRKMu1jk4pQtdAz7FO4oU4
         fzxkxsIFRZFk2yP+jFE5JTQ/psOd1zhfBhF+Veu3psHWQnaMujd70/1+PkOJeOI5bQnX
         sft1TmX9mWsQv954AlWPoZaaio01kYSunrozOl0ypmOvlr68ow6Bff6RD5FX0vzaGP8V
         VFFv6+7lSaV6ifsG2siyCtJ255v0+PozPw6zrkqvA6I7AOiFBlzwwN1hyUaNR4LM8VKD
         hvQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkDH/kfNd2dz7T68wyLVohIUdqw4EVQzwdL3To5qtcndQWq81+sKmeUNZ0G6wgnRqLiwNVJifTj8OJEyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgQ6nr44ayjmnN++Q9KGk3o1qSYDqVbWfCfH+4rnmox1caYjKP
	1D34JeqeNi0aV4Y95gbJ7Lw0FB52JHG2qIGsGhoNDKwHtT8PHCQDsfCjv8wS64uEJx/M3phV9Db
	MEQ==
X-Google-Smtp-Source: AGHT+IHYSx+l/bDu509hvMyjrwIbr08u7dqCkl8Nxs9bS1fDGCpHkw1LgDQfzzj9IkuDYKF/rMNtJesxcVo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:9506:0:b0:75a:b299:85b6 with SMTP id
 41be03b00d2f7-7c978ce7e4emr7678a12.2.1723844961033; Fri, 16 Aug 2024 14:49:21
 -0700 (PDT)
Date: Fri, 16 Aug 2024 14:49:19 -0700
In-Reply-To: <20240815123349.729017-2-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240815123349.729017-1-mlevitsk@redhat.com> <20240815123349.729017-2-mlevitsk@redhat.com>
Message-ID: <Zr_JX1z8xWNAxHmz@google.com>
Subject: Re: [PATCH v3 1/4] KVM: x86: relax canonical check for some x86
 architectural msrs
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 15, 2024, Maxim Levitsky wrote:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ce7c00894f32..2e83f7d74591 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -302,6 +302,31 @@ const struct kvm_stats_header kvm_vcpu_stats_header = {
>  		       sizeof(kvm_vcpu_stats_desc),
>  };
>  
> +
> +/*
> + * Most x86 arch MSR values which contain linear addresses like

Is it most, or all?  I'm guessing all?

> + * segment bases, addresses that are used in instructions (e.g SYSENTER),
> + * have static canonicality checks,

Weird and early line breaks.

How about this?

/*
 * The canonicality checks for MSRs that hold linear addresses, e.g. segment
 * bases, SYSENTER targets, etc., are static, in the sense that they are based
 * on CPU _support_ for 5-level paging, not the state of CR4.LA57.

> + * size of whose depends only on CPU's support for 5-level
> + * paging, rather than state of CR4.LA57.
> + *
> + * In addition to that, some of these MSRS are directly passed
> + * to the guest (e.g MSR_KERNEL_GS_BASE) thus even if the guest
> + * doen't have LA57 enabled in its CPUID, for consistency with
> + * CPUs' ucode, it is better to pivot the check around host
> + * support for 5 level paging.

I think we should elaborate on why it's better.  It only takes another line or
two, and that way we don't forget the edge cases that make properly emulating
guest CPUID a bad idea.

 * This creates a virtualization hole where a guest writes to passthrough MSRs
 * may incorrectly succeed if the CPU supports LA57, but the vCPU does not
 * (because hardware has no awareness of guest CPUID).  Do not try to plug this
 * hole, i.e. emulate the behavior for intercepted accesses, as injecting #GP
 * depending on whether or not KVM happens to emulate a WRMSR would result in
 * non-deterministic behavior, and could even allow L2 to crash L1, e.g. if L1
 * passes through an MSR to L2, and then tries to save+restore L2's value.
 */

> +
> +static u8  max_host_supported_virt_addr_bits(void)

Any objection to dropping the "supported", i.e. going with max_host_virt_addr_bits()?
Mostly to shorten the name, but also because "supported" suggests there's software
involvement, e.g. the max supported by the kernel/KVM, which isn't the case.

If you're ok with the above, I'll fixup when applying.

