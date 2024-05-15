Return-Path: <linux-kernel+bounces-180076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C1C8C69D3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2072830E5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73321156236;
	Wed, 15 May 2024 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WTtZjw49"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EFD149DEE
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715787282; cv=none; b=qC4epqxKV2y250i5hKdh8szTDjeDKkfkzfBAa3fEzZR1/79Z0Lb78he6WdQWssV8AK+b3mP1qnQLJFbDRkmkPQzNjN5DJ2OCjg6F0OWJB917LAF2Y+ioV+B0OENuVhWI8HmOi6BDhGPMK6uggm9q9FDKXMxk9hMVt6xgTI3tino=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715787282; c=relaxed/simple;
	bh=+6lvtOMgb8NfcJpPVhWpPBvUs9h1AGaJCCBTFnP3VW4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GKiYZsR01Gm0Mzf3a7ttmM83S8gnO65Z3wDUgENL6hwoxGfnnfZ/gx83lv/9ZHsENYyAbeiCbn/rr3AIqPy5WDuOHRLMDHEsOmHf7uHSERDbDxJ0bPoIjGOxDKkloYpLnqRSSHdGD3alW5RT8LA8VfqablCbdG9mlTM7Qx6F5LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WTtZjw49; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be325413eso88530047b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715787279; x=1716392079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E0LavojhfVwl7DnLAtnm8Qy4FATLmcCOxBK1w2ovU0k=;
        b=WTtZjw49yJAlrBsWoLMDPiBAFbMDa25LWrj1ZJ7Bssxq0pl0kWbu8Jhh4U+71o6Xoj
         QDUO4mOXZR1ViT71COSuuf/VMARSHOy58m/r+0zq8u6A3IMLks/yAUpdoDNRRZLOdd+X
         7ZUs5yzUiSa+9Es7UPC1nwDoZKUtwuyHBEHzciH0cdcL6/nkJ9xrNxLvY/FmnU5skhWv
         zAShlLPON77vhSsuE61DgqHCsoWEVGlO+w8ExNVbrBq7RHbHVHL1IiLEuccDPNd9X0J/
         wu3GyzaSFYxTnJNFGgI76lZV4fasx4c69uFwrQDo8xF3LF1XJKIwIDqP+1ngm+jHYaCF
         TaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715787279; x=1716392079;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E0LavojhfVwl7DnLAtnm8Qy4FATLmcCOxBK1w2ovU0k=;
        b=MlT81Bl4nyFjsTTx8M/Va8yvmWCE1AOXIi8oPtbl73z0Hi0lPTIx3L2S0LItjMFKNT
         93A0fyEMfEu846Iuil4epZuOHebQ1dFNE+7v1nExkLy8YlwPc9bQ8UzBpViM5VzqRTMO
         /fX52ypK7JNkgwJeVcAQ3DLqsPRxTyI9ry8UqqTtPS8nRU8oOwReFz/RnUOxiIIGTx7L
         nSSpjD32w+HOY7SpceiC8Wtel7hXs9OA4GjBoOsa/B7j0/vWwuh15C1okZ+gkSoyNOBX
         oU4PtHf0QYA1zMYbXvNkjlsHtV1UcBoJNt+FFOqb1S4aT/8rBWdekXIzPzOaehHn36PH
         7sAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNfruy/Pp8g+qsYEGalzXc2zdqJ4FarDtT6MG1gGA6CYQdXItalwcwtBxVj1GxPyI30csW2lZwbwo9A1TRgMbBgx6E5O6BCEMHUQpc
X-Gm-Message-State: AOJu0Yw57wYRnkeoDNcnSfMHqmgi6thrMAxL3jyy5t0C8z12ZTHoQklp
	+uJQDYJSjj4J2CIvPdZO5ZHimkzanahbjl9nxa+OR0XyMPYv3PN+jbxyGK0SjGQ53Ft6Vp6ZqGa
	A6A==
X-Google-Smtp-Source: AGHT+IF5uAGw+7wTn1ut3VTIpcletP4NVFs8Qv2hh7B6QoVI5g2sD9UfP2zaDADu7pIYOlsU4mejwOydYwQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:e2cb:0:b0:61a:f3ea:3994 with SMTP id
 00721157ae682-620993b8121mr40095297b3.3.1715787278967; Wed, 15 May 2024
 08:34:38 -0700 (PDT)
Date: Wed, 15 May 2024 08:34:37 -0700
In-Reply-To: <20240515005952.3410568-9-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240515005952.3410568-1-rick.p.edgecombe@intel.com> <20240515005952.3410568-9-rick.p.edgecombe@intel.com>
Message-ID: <ZkTWDfuYD-ThdYe6@google.com>
Subject: Re: [PATCH 08/16] KVM: x86/mmu: Bug the VM if kvm_zap_gfn_range() is
 called for TDX
From: Sean Christopherson <seanjc@google.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	isaku.yamahata@gmail.com, erdemaktas@google.com, sagis@google.com, 
	yan.y.zhao@intel.com, dmatlack@google.com
Content-Type: text/plain; charset="us-ascii"

On Tue, May 14, 2024, Rick Edgecombe wrote:
> When virtualizing some CPU features, KVM uses kvm_zap_gfn_range() to zap
> guest mappings so they can be faulted in with different PTE properties.
> 
> For TDX private memory this technique is fundamentally not possible.
> Remapping private memory requires the guest to "accept" it, and also the
> needed PTE properties are not currently supported by TDX for private
> memory.
> 
> These CPU features are:
> 1) MTRR update
> 2) CR0.CD update
> 3) Non-coherent DMA status update

Please go review the series that removes these disaster[*], I suspect it would
literally have taken less time than writing this changelog :-)

[*] https://lore.kernel.org/all/20240309010929.1403984-1-seanjc@google.com

> 4) APICV update
> 
> Since they cannot be supported, they should be blocked from being
> exercised by a TD. In the case of CRO.CD, the feature is fundamentally not
> supported for TDX as it cannot see the guest registers. For APICV
> inhibit it in future changes.
> 
> Guest MTRR support is more of an interesting case. Supported versions of
> the TDX module fix the MTRR CPUID bit to 1, but as previously discussed,
> it is not possible to fully support the feature. This leaves KVM with a
> few options:
>  - Support a modified version of the architecture where the caching
>    attributes are ignored for private memory.
>  - Don't support MTRRs and treat the set MTRR CPUID bit as a TDX Module
>    bug.
> 
> With the additional consideration that likely guest MTRR support in KVM
> will be going away, the later option is the best. Prevent MTRR MSR writes
> from calling kvm_zap_gfn_range() in future changes.
> 
> Lastly, the most interesting case is non-coherent DMA status updates.
> There isn't a way to reject the call. KVM is just notified that there is a
> non-coherent DMA device attached, and expected to act accordingly. For
> normal VMs today, that means to start respecting guest PAT. However,
> recently there has been a proposal to avoid doing this on selfsnoop CPUs
> (see link). On such CPUs it should not be problematic to simply always
> configure the EPT to honor guest PAT. In future changes TDX can enforce
> this behavior for shared memory, resulting in shared memory always
> respecting guest PAT for TDX. So kvm_zap_gfn_range() will not need to be
> called in this case either.
> 
> Unfortunately, this will result in different cache attributes between
> private and shared memory, as private memory is always WB and cannot be
> changed by the VMM on current TDX modules. But it can't really be helped
> while also supporting non-coherent DMA devices.
> 
> Since all callers will be prevented from calling kvm_zap_gfn_range() in
> future changes, report a bug and terminate the guest if other future
> changes to KVM result in triggering kvm_zap_gfn_range() for a TD.
> 
> For lack of a better method currently, use kvm_gfn_shared_mask() to
> determine if private memory cannot be zapped (as in TDX, the only VM type
> that sets it).
> 
> Link: https://lore.kernel.org/all/20240309010929.1403984-6-seanjc@google.com/
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
> TDX MMU Part 1:
>  - Remove support from "KVM: x86/tdp_mmu: Zap leafs only for private memory"
>  - Add this KVM_BUG_ON() instead
> ---
>  arch/x86/kvm/mmu/mmu.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index d5cf5b15a10e..808805b3478d 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -6528,8 +6528,17 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
>  
>  	flush = kvm_rmap_zap_gfn_range(kvm, gfn_start, gfn_end);
>  
> -	if (tdp_mmu_enabled)
> +	if (tdp_mmu_enabled) {
> +		/*
> +		 * kvm_zap_gfn_range() is used when MTRR or PAT memory
> +		 * type was changed.  TDX can't handle zapping the private
> +		 * mapping, but it's ok because KVM doesn't support either of
> +		 * those features for TDX. In case a new caller appears, BUG
> +		 * the VM if it's called for solutions with private aliases.
> +		 */
> +		KVM_BUG_ON(kvm_gfn_shared_mask(kvm), kvm);

Please stop using kvm_gfn_shared_mask() as a proxy for "is this TDX".  Using a
generic name quite obviously doesn't prevent TDX details for bleeding into common
code, and dancing around things just makes it all unnecessarily confusing.

If we can't avoid bleeding TDX details into common code, my vote is to bite the
bullet and simply check vm_type.

This KVM_BUG_ON() also should not be in the tdp_mmu_enabled path.  Yeah, yeah,
TDX is restricted to the TDP MMU, but there's no reason to bleed that detail all
over the place.

>  		flush = kvm_tdp_mmu_zap_leafs(kvm, gfn_start, gfn_end, flush);
> +	}
>  
>  	if (flush)
>  		kvm_flush_remote_tlbs_range(kvm, gfn_start, gfn_end - gfn_start);
> -- 
> 2.34.1
> 

