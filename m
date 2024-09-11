Return-Path: <linux-kernel+bounces-324761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0178E975091
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB00828ED4D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D772185E73;
	Wed, 11 Sep 2024 11:14:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DA5185B69
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726053262; cv=none; b=cQSLs8Oj5HGnVEXszWrA5y1i58KbvSfI8E/rndp7bxoiPCOF49/U3EMixYj+/7ntW/hq3rMqg4eRx3Htgy+pziriKVFgrJD+6EaB7d+uZQzQIaJ42JhrI8QYLe5CWqqA3fhDi8OjQZkKEpnINTQCLaXZwxd5rPIaOJ3K2ecZjhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726053262; c=relaxed/simple;
	bh=6g+bYsg0zkFkyI0B3OG7QNql4JmjFdrtCC86J0V6p1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5+iSjMleCNPxXZuM+wZH+vM/ShgeQ7wkh3MBffTPk71Fkn7xIRg7XCZnCh1T2jkFkTvyrBdvGZzv0DFVy9sepxnuObRy/ug7bWu4NlmcPEW8Zj+ZBAa0R9jnXotofPbH9+Qu+YrLSclFoxpXgkUwcbINfQQSkR8+osezFDeG/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 853211007;
	Wed, 11 Sep 2024 04:14:49 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F4BF3F64C;
	Wed, 11 Sep 2024 04:14:18 -0700 (PDT)
Date: Wed, 11 Sep 2024 12:14:13 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Constrain the host to the maximum shared SVE
 VL with pKVM
Message-ID: <ZuF7hUU1xn/Em9QJ@e133380.arm.com>
References: <20240910-kvm-arm64-limit-guest-vl-v1-1-54df40b95ffb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910-kvm-arm64-limit-guest-vl-v1-1-54df40b95ffb@kernel.org>

On Tue, Sep 10, 2024 at 09:21:17PM +0100, Mark Brown wrote:
> When pKVM saves and restores the host floating point state on a SVE system
> it programs the vector length in ZCR_EL2.LEN to be whatever the maximum VL
> for the PE is but uses a buffer allocated with kvm_host_sve_max_vl, the
> maximum VL shared by all PEs in the system. This means that if we run on a
> system where the maximum VLs are not consistent we will overflow the buffer
> on PEs which support larger VLs.
> 
> Since the host will not currently attempt to make use of non-shared VLs fix
> this by explicitly setting the EL2 VL to be the maximum shared VL when we
> save and restore. This will enforce the limit on host VL usage. Should we
> wish to support asymmetric VLs this code will need to be updated along with
> the required changes for the host, patches have previously been posted:
> 
>   https://lore.kernel.org/r/20240730-kvm-arm64-fix-pkvm-sve-vl-v6-0-cae8a2e0bd66@kernel.org
> 
> Fixes: b5b9955617bc ("KVM: arm64: Eagerly restore host fpsimd/sve state in pKVM")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kvm/hyp/include/hyp/switch.h | 2 +-
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c      | 7 ++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
> index f59ccfe11ab9..ab1425baf0e9 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> @@ -339,7 +339,7 @@ static inline void __hyp_sve_save_host(void)
>  	struct cpu_sve_state *sve_state = *host_data_ptr(sve_state);
>  
>  	sve_state->zcr_el1 = read_sysreg_el1(SYS_ZCR);
> -	write_sysreg_s(ZCR_ELx_LEN_MASK, SYS_ZCR_EL2);
> +	write_sysreg_s(sve_vq_from_vl(kvm_host_sve_max_vl), SYS_ZCR_EL2);
>  	__sve_save_state(sve_state->sve_regs + sve_ffr_offset(kvm_host_sve_max_vl),
>  			 &sve_state->fpsr,
>  			 true);
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index f43d845f3c4e..90ff79950912 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -45,10 +45,11 @@ static void __hyp_sve_restore_host(void)
>  	 * the host. The layout of the data when saving the sve state depends
>  	 * on the VL, so use a consistent (i.e., the maximum) host VL.
>  	 *
> -	 * Setting ZCR_EL2 to ZCR_ELx_LEN_MASK sets the effective length
> -	 * supported by the system (or limited at EL3).
> +	 * Note that this constrains the PE to the maximum shared VL
> +	 * that was discovered, if we wish to use larger VLs this will
> +	 * need to be revisited.
>  	 */
> -	write_sysreg_s(ZCR_ELx_LEN_MASK, SYS_ZCR_EL2);
> +	write_sysreg_s(sve_vq_from_vl(kvm_host_sve_max_vl), SYS_ZCR_EL2);
>  	__sve_restore_state(sve_state->sve_regs + sve_ffr_offset(kvm_host_sve_max_vl),
>  			    &sve_state->fpsr,
>  			    true);
> 
> ---
> base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
> change-id: 20240910-kvm-arm64-limit-guest-vl-d5fba0c7cc7b
> 
> Best regards,
> -- 

It's a shame that the allocation logic lives somewhere far far away,
so the code here needs to "guess" a consistent correct bounding VL for
the host here.  If there's a change of policy later on, someone may
need to remember to fix both places.

Just a thought, but is there a way of getting the relevant bits of
logic at least into the same file?

Cheers
---Dave


