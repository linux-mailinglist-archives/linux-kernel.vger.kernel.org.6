Return-Path: <linux-kernel+bounces-542650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E32ABA4CBF3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D43CE7A29FA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D6D22DF95;
	Mon,  3 Mar 2025 19:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eFhViSfq"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C40022CBE2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029994; cv=none; b=t7xS5bQTaGc2kLDy61Q/3hhZYhw67uy3HPIhoIPTp0GAcSFE0427UE82EafBHJWsAz2N1hfpobAa0iuBgGKwqJ0ojOfLBKzgJkWsuqEs4kQgi2YPHPTHkP+nxhZSSb3SnS7aHOjIo0uG21KHbvZaaLAUI83LAZy28jCIcWhyOJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029994; c=relaxed/simple;
	bh=6n5OAu3OQDn5PljzYrxWVEErtjd6yDALZ0uj2qlJZyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbpv1ye0WK6/r8YI8zq3XpRBr0BOCXR9n0fJUF/ZmM6DN1TyET0x7KxmkQdIEYRdt/gOT8q1KrtVhuv/2tzvbV9RFZnFWM5ksTUT/Z/9hGU26Jub7NDN5aGHSKzXTULnCsq9k8bduR+MLNweDgkqGNdbdpXQkSOBN2aEPjBw3ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eFhViSfq; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 3 Mar 2025 11:26:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741029989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e6Ssv1Pi5/l09GtY5Tp1NZoyz32uNw/sUvPD95BnsD8=;
	b=eFhViSfqEkZ4vo/8zItk5pKaSpk2SrRf5ADD1i/13+D1jULcmd/qNRMxEhT0n2KKindPvf
	jaymDdXLv6vRnzAnGEtD9tNCfzmZQUpGN2+BFeyBnx9/mlhUlDuR4fsYbOPrCUC+MC0dn8
	DGB4YRjuRVwPLZbEwriBSpv/8CrjoEo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Andrew Jones <drjones@redhat.com>,
	Shannon Zhao <shannon.zhao@linaro.org>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, devel@daynix.com
Subject: Re: [PATCH] KVM: arm64: PMU: Fix SET_ONE_REG for vPMC regs
Message-ID: <Z8YCUFkt8gdnWRSk@linux.dev>
References: <20250302-pmc-v1-1-caff989093dc@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302-pmc-v1-1-caff989093dc@daynix.com>
X-Migadu-Flow: FLOW_OUT

Hi Akihiko,

On Sun, Mar 02, 2025 at 05:12:54PM +0900, Akihiko Odaki wrote:
> Reset the current perf event when setting the vPMU counter (vPMC)
> registers (PMCCNTR_EL0 and PMEVCNTR<n>_EL0). This is a change
> corresponding to commit 9228b26194d1 ("KVM: arm64: PMU: Fix GET_ONE_REG
> for vPMC regs to return the current value") but for SET_ONE_REG.
> 
> Values of vPMC registers are saved in sysreg files on certain occasions.
> These saved values don't represent the current values of the vPMC
> registers if the perf events for the vPMCs count events after the save.
> The current values of those registers are the sum of the sysreg file
> value and the current perf event counter value.  But, when userspace
> writes those registers (using KVM_SET_ONE_REG), KVM only updates the
> sysreg file value and leaves the current perf event counter value as is.

Are you trying to change the PMCs after the VM has started?

> Fix this by calling kvm_pmu_set_counter_value(), which resests the
> current perf event as well.

I'm afraid this could introduce some oddities for save/restore of a VM.
The PMU configuration (e.g. type, event filter, nr event counters) is
subject to change before KVM_RUN.

For example, if the VM programmed an event that was filtered on the
source, KVM could erroneously allocate a perf event on the target if the
filter is restored after the vCPU sysregs.

A similar issue could happen with the PMU type not matching the final
selection as well. Attaching the perf event in KVM_REQ_RELOAD_PMU avoids
these sort of issues.

> Fixes: 051ff581ce70 ("arm64: KVM: Add access handler for event counter register")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  arch/arm64/kvm/sys_regs.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 42791971f75887796afab905cc12f49fead39e10..1de990edc6a3e9be2a05a711621bb1bcbeac236a 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1035,6 +1035,22 @@ static int get_pmu_evcntr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
>  	return 0;
>  }
>  
> +static int set_pmu_evcntr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
> +			  u64 val)
> +{
> +	u64 idx;
> +
> +	if (r->CRn == 9 && r->CRm == 13 && r->Op2 == 0)
> +		/* PMCCNTR_EL0 */
> +		idx = ARMV8_PMU_CYCLE_IDX;
> +	else
> +		/* PMEVCNTRn_EL0 */
> +		idx = ((r->CRm & 3) << 3) | (r->Op2 & 7);

nitpick: Let's get rid of the manual decode for both the getter and
setter. r->reg already provides the right info, we just need to
transform that into a counter index.

> +	kvm_pmu_set_counter_value(vcpu, idx, val);
> +	return 0;

WDYT about only calling kvm_pmu_set_counter_value() if the vCPU has
already run once, otherwise update the in-memory value of the register?
I think that would fix your issue while also guaranteeing that the perf
event matches the final configuration of the vPMU.

Thanks,
Oliver

