Return-Path: <linux-kernel+bounces-389787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D847E9B714B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0E7AB21696
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66321200CD;
	Thu, 31 Oct 2024 00:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jJ1BaLc4"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15A11CFB6
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 00:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730335562; cv=none; b=NS0sDb2H4yxUvwpPzjx2mJNSo+vs/K5tWjK+K/cZLtOKIMOy0TGHy3Fr112zk/uejcBkM20o36SDkNToiF8iZCEVwNfNChSI0gA2FuX2T4hKDuNYZlOSbW2TwoXSvYQfVTl5wdwe8dcNedtp7xMs+naxmereuHyWK9vWtY5ChFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730335562; c=relaxed/simple;
	bh=IpKzPmzcLGJxeHvO97bJ+m4VuehGRu63odWb5HxFFHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VB52Tsts1Httn80bx4/pXMrRjsoytO49ZogWuSp5YRYt3FS5iNOslrUFLBj9TLaZGGYcys/MKqEKSO+S1JpGOszK/4bikP8oi6272MnsLXI/SN8W7QN7eOr/v8nUfPdLdH0q7oIVX96uCzkdAB3WexnTf4ZKrBp9X0nvuBONWFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jJ1BaLc4; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2e3be80e9f3so1289198a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730335560; x=1730940360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gyl9/1C5HeGcTttaTqyDIBgciB0UcwwX5pUS0N0eRvs=;
        b=jJ1BaLc4CHSPIMYEWgNpBVN1vVVAifjYATPh1uvrZes0FgUEREVVpOUIqdp0dO8GbL
         G2lRqgUlnp79wf9ZRVyWzROwXHcIjoDOYFHoE7kGkIAEq0oghVX7aCZaMdepin9+gnqq
         wMhJ/k8KJiW1+3zibkt6xNORpkEoe/JpaYxyWS3gOivrl5bZGXqTRwIPMmfnjVXZaIm7
         tyd/poHkiZQ3+mrbd8kh3Lv9So8SJFgEwpTZWfHRGbcXjeLxCHbxx3o7CJ4zpFY0h/pM
         AW1R16/i/yay9mPDokMQtcAPoTBAjonZ1eSO0GX/b28OOuHnAFq4BL/n4DYkkYcFhOzO
         Xfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730335560; x=1730940360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gyl9/1C5HeGcTttaTqyDIBgciB0UcwwX5pUS0N0eRvs=;
        b=EyKqgRv5YfuLTey1GoX7AuNwV5FdFQL0edpIQXh4e+sUH1+uW7K2ktepWYF17uwK73
         XeFD/+5LHxmKXxA8INDGpL6UVk6wgzF2G2WIoS/pucYjtrUbPzgyPOeoGlps3SJ4/ebN
         Xo+iKXA9YbwVtfWJSQYsTPEXv+JW3KkJ6sTTQ/jhANERM9/PvqLu5p9duykXkK3R1sb6
         0jZxem6GOAtzOunZBd1HMBrn72PHh44w6AIbTdGUpXL9vRSNMTpmDwe6da3o34U3nOCd
         Z/mMNat3ycFoyGZ3EMlC2SNC1XXXkzOndxiqxTFVXBiABri/s9shVrH0pgXfq1IL7nXO
         jmmw==
X-Forwarded-Encrypted: i=1; AJvYcCVRVaFOg1A2rCLrW6g6271NXDrWSNLU+1CUyhwzRfzI0C9BzwMRmClArzYYX7d1NKtElfPmH91gSWA7gr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3AiKx35DfXh16K5X6Zs8pgpBBjkYZPUjzlEzLA6eZF+YPgqtc
	V8qmZU6i1Tj/BMjJVvIr88SRXkw5/ywU4vA/1ZlwXI01RW3/TEIV6UTMXqW+ep4b7JUZyTeHTBN
	Tqg==
X-Google-Smtp-Source: AGHT+IHYrYQB+D6mNZJCl+ZASHUSfOs9wlbaXCC+ICbJJpkLJgeze8yyiPVVOGub7wJOpEnFZ8x4cXZ4Y40=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:90a:4963:b0:2e2:8f4d:457 with SMTP id
 98e67ed59e1d1-2e93e173419mr2042a91.2.1730335560227; Wed, 30 Oct 2024 17:46:00
 -0700 (PDT)
Date: Wed, 30 Oct 2024 17:45:58 -0700
In-Reply-To: <20240906221824.491834-4-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240906221824.491834-1-mlevitsk@redhat.com> <20240906221824.491834-4-mlevitsk@redhat.com>
Message-ID: <ZyLTRvbLq9ZTXBim@google.com>
Subject: Re: [PATCH v4 3/4] KVM: x86: model canonical checks more precisely
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, linux-kernel@vger.kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 06, 2024, Maxim Levitsky wrote:
> As a result of a recent investigation, it was determined that x86 CPUs
> which support 5-level paging, don't always respect CR4.LA57 when doing
> canonical checks.
> 
> In particular:
> 
> 1. MSRs which contain a linear address, allow full 57-bitcanonical address
> regardless of CR4.LA57 state. For example: MSR_KERNEL_GS_BASE.
> 
> 2. All hidden segment bases and GDT/IDT bases also behave like MSRs.
> This means that full 57-bit canonical address can be loaded to them
> regardless of CR4.LA57, both using MSRS (e.g GS_BASE) and instructions
> (e.g LGDT).
> 
> 3. TLB invalidation instructions also allow the user to use full 57-bit
> address regardless of the CR4.LA57.
> 
> Finally, it must be noted that the CPU doesn't prevent the user from
> disabling 5-level paging, even when the full 57-bit canonical address is
> present in one of the registers mentioned above (e.g GDT base).
> 
> In fact, this can happen without any userspace help, when the CPU enters
> SMM mode - some MSRs, for example MSR_KERNEL_GS_BASE are left to contain
> a non-canonical address in regard to the new mode.
> 
> Since most of the affected MSRs and all segment bases can be read and
> written freely by the guest without any KVM intervention, this patch makes
> the emulator closely follow hardware behavior, which means that the
> emulator doesn't take in the account the guest CPUID support for 5-level
> paging, and only takes in the account the host CPU support.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/emulate.c       |  2 +-
>  arch/x86/kvm/mmu/mmu.c       |  2 +-
>  arch/x86/kvm/vmx/nested.c    | 22 ++++++++--------
>  arch/x86/kvm/vmx/pmu_intel.c |  2 +-
>  arch/x86/kvm/vmx/sgx.c       |  2 +-
>  arch/x86/kvm/vmx/vmx.c       |  4 +--
>  arch/x86/kvm/x86.c           |  8 +++---
>  arch/x86/kvm/x86.h           | 49 ++++++++++++++++++++++++++++++++++--
>  8 files changed, 68 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 8c8061884a019..60986f67c35a8 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -654,7 +654,7 @@ static inline bool emul_is_noncanonical_address(u64 la,
>  						struct x86_emulate_ctxt *ctxt,
>  						unsigned int flags)
>  {
> -	return !ctxt->ops->is_canonical_addr(ctxt, la, 0);
> +	return !ctxt->ops->is_canonical_addr(ctxt, la, flags);

And conversely, passing flags to ->is_canonical_addr() belongs in the patch that
adds the plumbing.  Even though flags isn't truly consumed until this patch,
passing '0' in this helper is confusing and an unnecessary risk.

