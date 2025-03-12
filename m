Return-Path: <linux-kernel+bounces-558474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7031A5E660
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D2E1892F73
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33691EBFE3;
	Wed, 12 Mar 2025 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gqGnRc88"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230141BD9DD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814291; cv=none; b=nu1IXSGouAlzaoOEiItPGB7AwgchbHyPHBtr0RqKbFxIaeUVCVlfl3xOEZG6dhp3pK3tIzUWycHDxCSBPYleoSkBPHYJ+GbAAt50lawgODrjC4eT6siD/fHZcplGW/Rn9sFHKYKsMAE3EKQONcFpM81kjyxpT8djlgCOc0PRSoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814291; c=relaxed/simple;
	bh=PtjexfcFdoeu/5qbU0udRLgm8sY5gNlZZs0MGmbeEeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJZ+ZJzgKBZXAd7Jrp+GtIMvSX80vua6adUkXz3ZOIM0AtLc9zSicZ/upYZMrGAOqZ12LWI8WLnO0vUhiKzfX+sFHGcIV6PUpLOu9l9+jvLfDAt96wImF5SYyKwi4WOvuWf3QsqWlSwkdXeLnfaawrprrMvbHzeqSprqfDck6YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gqGnRc88; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 12 Mar 2025 14:18:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741814287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N3AyGAijYqYgOgHQR7L9d8btXgT+uidlAsKc8Qo2ewk=;
	b=gqGnRc88hux9lbrnVxYQRdyKyDt4MJa18YG4n8yivznQI2fZptvDXvQakLM+ZAi8JSenHg
	bNWcugfm8kRNaWtNMSwYnVZTwpCDVCfQ6T4hcRsXy95beKjTfNbM8667Vbc8Rnhv3A5DxX
	TwENYecYloS9cQ+jbcLLnF5fTA1hqBk=
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
Subject: Re: [PATCH v3 4/6] KVM: arm64: PMU: Reload when user modifies
 registers
Message-ID: <Z9H6CWz1Z_v7DxvI@linux.dev>
References: <20250312-pmc-v3-0-0411cab5dc3d@daynix.com>
 <20250312-pmc-v3-4-0411cab5dc3d@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312-pmc-v3-4-0411cab5dc3d@daynix.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 12, 2025 at 08:55:58PM +0900, Akihiko Odaki wrote:
> Commit d0c94c49792c ("KVM: arm64: Restore PMU configuration on first
> run") added the code to reload the PMU configuration on first run.
> 
> It is also important to keep the correct state even if system registers
> are modified after first run, specifically when debugging Windows on
> QEMU with GDB; QEMU tries to write back all visible registers when
> resuming the VM execution with GDB, corrupting the PMU state. Windows
> always uses the PMU so this can cause adverse effects on that particular
> OS.
> 
> The usual register writes are already handled independently, but
> register writes from userspace and ones for reset are not covered.

Ah -- that explains why you're moving the KVM_REQ_RELOAD_PMU from
kvm_arm_pmuv3_enable().

> @@ -4259,6 +4262,9 @@ void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
>  	}
>  
>  	set_bit(KVM_ARCH_FLAG_ID_REGS_INITIALIZED, &kvm->arch.flags);
> +
> +	if (kvm_vcpu_has_pmu(vcpu))
> +		kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);

nitpick, but maybe this can be added to kvm_pmu_vcpu_reset() instead.

Thanks,
Oliver

