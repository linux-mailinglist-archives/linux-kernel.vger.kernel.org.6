Return-Path: <linux-kernel+bounces-558170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B353A5E27E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ECE47AADBF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B7D25A2DC;
	Wed, 12 Mar 2025 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K9VX7JmH"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B5A257426
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800027; cv=none; b=Hp25ERF8DLATcdbOsGNBdufyDzyzl6nfoV16YfNegOJmYzJI7CpbpbUw9lBK3JyhPCxah+MkPdgsD6dZsCD8Ib3XGeDoxa1q9k612aGHr3+UViIbhTk7P2yGLyPrqZ+FJn4gHCr3Hr/EOsN4fHY7ujk43qJ8eVuXCMidOrxIl9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800027; c=relaxed/simple;
	bh=BgkmSmEqdAivThIbrZrYiT0kLf6v8P60d84U77VcbSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eal8sRBM75p1yCIAPylVMbBuMSWcP8QJDJPn7EgpmM/o6u0imZHVX/+TdVd1csE1e/gAkpIvs5Q0BhijilVTu8v1neV/IltbtMcbkWXU941kaXcU78lDjTDjaV6dQpTE0o5AoUExph3EksEl5eIx4XPMJVTeAIQ1CHKipbrcgqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K9VX7JmH; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 12 Mar 2025 10:20:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741800012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mOs7eQJLJCUGEFSay4U24A8ybWT+TL/OSie+j9EubR4=;
	b=K9VX7JmHz2x3px/JqTTXS6bOObpnE8iYmASgHZpf3YaLhlObaD2TuQ6CegwZRFbF1bPcsu
	zsfhYfG64gFgM94Jjm6QbVRfeDERlVdDlrZwDlfU8QJWPWAxySkVUdGzcVY7Vqq77Ibu56
	DwzXcJmp8MdTB6NrovutjeQmdpHOAEM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sebastian Ott <sebott@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Writable TGRAN*_2
Message-ID: <Z9HCQ40LxShzL4nj@linux.dev>
References: <20250306184013.30008-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306184013.30008-1-sebott@redhat.com>
X-Migadu-Flow: FLOW_OUT

Hi Sebastian,

On Thu, Mar 06, 2025 at 07:40:13PM +0100, Sebastian Ott wrote:
> Allow userspace to write the safe (NI) value for ID_AA64MMFR0_EL1.TGRAN*_2.
> Disallow to change these fields for NV since kvm provides a sanitized view
> for them based on the PAGE_SIZE.
> Also add these bits to the set_id_regs selftest.
> 
> Signed-off-by: Sebastian Ott <sebott@redhat.com>

I can't tell what you've based this patch on, it certainly doesn't apply
on a 6.14 rc. Consider telling git to include the base commit next time
you generate a patch.

> ---
>  arch/arm64/kvm/sys_regs.c                     | 21 +++++++++++++++----
>  .../testing/selftests/kvm/arm64/set_id_regs.c |  3 +++
>  2 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 14faf213d483..0730ed8314d0 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1948,6 +1948,21 @@ static int set_id_aa64pfr1_el1(struct kvm_vcpu *vcpu,
>  	return set_id_reg(vcpu, rd, user_val);
>  }
>  
> +static int set_id_aa64mmfr0_el1(struct kvm_vcpu *vcpu,
> +				const struct sys_reg_desc *rd, u64 user_val)
> +{
> +	u64 sanitized_val = kvm_read_sanitised_id_reg(vcpu, rd);
> +	u64 tgran2_mask = ID_AA64MMFR0_EL1_TGRAN4_2_MASK |
> +			  ID_AA64MMFR0_EL1_TGRAN16_2_MASK |
> +			  ID_AA64MMFR0_EL1_TGRAN64_2_MASK;
> +
> +	if (vcpu_has_nv(vcpu) &&
> +	    ((sanitized_val & tgran2_mask) != (user_val & tgran2_mask)))
> +		return -EINVAL;
> +
> +	return set_id_reg(vcpu, rd, user_val);
> +}
> +
>  static int set_id_aa64mmfr2_el1(struct kvm_vcpu *vcpu,
>  				const struct sys_reg_desc *rd, u64 user_val)
>  {
> @@ -2787,10 +2802,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  	ID_UNALLOCATED(6,7),
>  
>  	/* CRm=7 */
> -	ID_WRITABLE(ID_AA64MMFR0_EL1, ~(ID_AA64MMFR0_EL1_RES0 |
> -					ID_AA64MMFR0_EL1_TGRAN4_2 |
> -					ID_AA64MMFR0_EL1_TGRAN64_2 |
> -					ID_AA64MMFR0_EL1_TGRAN16_2 |
> +	ID_FILTERED(ID_AA64MMFR0_EL1, id_aa64mmfr0_el1,
> +				      ~(ID_AA64MMFR0_EL1_RES0 |
>  					ID_AA64MMFR0_EL1_ASIDBITS)),
>  	ID_WRITABLE(ID_AA64MMFR1_EL1, ~(ID_AA64MMFR1_EL1_RES0 |
>  					ID_AA64MMFR1_EL1_HCX |
> diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
> index 1d65f4a09e6f..322b9d3b0125 100644
> --- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
> +++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
> @@ -146,6 +146,9 @@ static const struct reg_ftr_bits ftr_id_aa64pfr1_el1[] = {
>  static const struct reg_ftr_bits ftr_id_aa64mmfr0_el1[] = {
>  	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64MMFR0_EL1, ECV, 0),
>  	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64MMFR0_EL1, EXS, 0),
> +	REG_FTR_BITS(FTR_EXACT, ID_AA64MMFR0_EL1, TGRAN4_2, 1),
> +	REG_FTR_BITS(FTR_EXACT, ID_AA64MMFR0_EL1, TGRAN64_2, 1),
> +	REG_FTR_BITS(FTR_EXACT, ID_AA64MMFR0_EL1, TGRAN16_2, 1),
>  	S_REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64MMFR0_EL1, TGRAN4, 0),
>  	S_REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64MMFR0_EL1, TGRAN64, 0),
>  	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64MMFR0_EL1, TGRAN16, 0),

Please do selftests changes in a separate patch.

Don't worry about respinning, I'll fix this up and queue it in a moment.

Thanks,
Oliver

