Return-Path: <linux-kernel+bounces-383221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D669B189B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 16:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2426D1F21EE1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 14:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4453E1804A;
	Sat, 26 Oct 2024 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ioWmhbjo"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579BBEAD0
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729953137; cv=none; b=WyUrPemHQtcHoVRumuu2WgDyN9NELnDuC2S1pqD/80IedqOXLWa0vz/OzilPZWitnoj46iq2YuQIybRWBYwEGA0JFNNSwNg8GGs4LuHZSNt1zG/4bJVW2dBUxH3+O9PrzJOY3Wgi0jtXC3ROAOshKFPqI3EGedePmzLNEUw+ovg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729953137; c=relaxed/simple;
	bh=FahuXXaMZ/9ZscVkGyo9Tba+JPZAuKkH0qtbhjVacd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBnNGt1vgYC6k0U+w2Z4ieqpOqRw5OvF+fx8Qha9Bf329DmyugBjmqaQ/eoWsv/9bTqR3+sBW+bD5SRGfPWqMfLeMriQyQ30Kxdz8vFvuo5AA+ZHHBcqnhSyAdduI92y8TI9MgV+lAS1Qb7ClE8QUH5xGb3baNBIqHulHQPh0F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ioWmhbjo; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 26 Oct 2024 14:32:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729953131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iDrJjoXe96jtaGbZQ/F1djq7fODfGCzzGpz/Lz+dRHI=;
	b=ioWmhbjoTUdaVLhZ52kRWU0xlN3PhCoOaVqbYJ1QwtWk9i+7sKbCODYdWiHuaS8SvmvvLG
	mLcIR2vs+88bjLX1DXct357tkBvxcVx/gE3JS71Xy7auPw5s310Oeaejlnw4hNv7WB1c2Y
	kJUV5jdnqxzbmT6ll9OwVtNpEXRhnoM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/18] KVM: arm64: nv: Describe trap behaviour of
 MDCR_EL2.HPMN
Message-ID: <Zxz9YonLVsaLuMEJ@linux.dev>
References: <20241025182354.3364124-1-oliver.upton@linux.dev>
 <20241025182354.3364124-11-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025182354.3364124-11-oliver.upton@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 25, 2024 at 06:23:45PM +0000, Oliver Upton wrote:
> MDCR_EL2.HPMN splits the PMU event counters into two ranges: the first
> range is accessible from all ELs, and the second range is accessible
> only to EL2/3. Supposing the guest hypervisor allows direct access to
> the PMU counters from the L2, KVM needs to locally handle those
> accesses.
> 
> Add a new complex trap configuration for HPMN that checks if the counter
> index is accessible to the current context. As written, the architecture
> suggests HPMN only causes PMEVCNTR<n>_EL0 to trap, though intuition (and
> the pseudocode) suggest that the trap applies to PMEVTYPER<n>_EL0 as
> well.
> 
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> ---
>  arch/arm64/kvm/emulate-nested.c | 160 +++++++++++++++++++-------------
>  arch/arm64/kvm/pmu-emul.c       |  18 ++++
>  include/kvm/arm_pmu.h           |   6 ++
>  3 files changed, 120 insertions(+), 64 deletions(-)

Gonna squash in the following to fix !CONFIG_HW_PERF_EVENTS builds.

diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index e6103df9ef5d..feb5d1d35f0f 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -188,7 +188,7 @@ static inline u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static inline bool kvm_pmu_counter_is_hyp(struct kvm_vcpu *vcpu)
+static inline bool kvm_pmu_counter_is_hyp(struct kvm_vcpu *vcpu, unsigned int idx)
 {
 	return false;
 }

-- 
Thanks,
Oliver

