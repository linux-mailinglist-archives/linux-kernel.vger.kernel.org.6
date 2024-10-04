Return-Path: <linux-kernel+bounces-349897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC1498FCE1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 07:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ADA9283046
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 05:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B404DA04;
	Fri,  4 Oct 2024 05:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="drUKYhiU"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6532D17BB7
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 05:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728018093; cv=none; b=H514wnYLBz5//CnraFiYFclKU0Wnkg8USqvydM/vvlJfNK2RJT7OHS6zDzs6jTwGZE11KUIN+zSWwSim33FhQg4GfcAlT/m/aWzYyh9u1WSp0hQ5ekd7Yp2/S33HSc3jmNkCntiluMqKV8NC+2HLVK/nSwyIphCd6U/Zwx/eshk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728018093; c=relaxed/simple;
	bh=n+hq+ke8KIBDS78Wt9NIB7KmLpdUY9ZL/UEBkJnixbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEpbDu+1MJ/z/MMIu6UpyKsSIrGkFIbhA0Wc0k7kllsvVCQTVjKGvUQ4tibihW5YmFDO9kH9mXRXh7frk47LxaLMbYglofdLYI9I3lDdCGebdW0Cbd7Ps0HpAGKY9vOlQRrhfU47PVu19+Pk6g4WuqL6N3RwKPUPcWKg10WvAaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=drUKYhiU; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 3 Oct 2024 22:01:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728018087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AbVygyhcJER/ikyVDJU/xvRALSb1JCr8R5Un1y4HJmM=;
	b=drUKYhiUO0iMloMMld3oZWw9NerZxmcRjYAbDR8dbiSXzYTLATw/ksPKMV4v3CQkudNnXS
	7dwu7pQXP5n5UU9bO46cGGjoLhEBxv+jlKTxtkeevgBmW3xJjH5Ocx6jrc5uE6+J2CVRFP
	hZ9/ZYIPHd40c4N1lrYPzLTHj8iJf0Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, maz@kernel.org,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 47/47] KVM: arm64: nv: Add trap forwarding for FEAT_FGT2
 described registers
Message-ID: <Zv92nsoLxbfI45Ji@linux.dev>
References: <20241001024356.1096072-1-anshuman.khandual@arm.com>
 <20241001024356.1096072-48-anshuman.khandual@arm.com>
 <ZvwLRWOKpggCvmH4@linux.dev>
 <cae8c6ca-d999-4b93-a82d-7a1f9924fcee@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cae8c6ca-d999-4b93-a82d-7a1f9924fcee@arm.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 03, 2024 at 09:46:08AM +0530, Anshuman Khandual wrote:
> > I have a patch in the nested PMU series that uses a single complex trap
> > ID to evaluate HPMN, and derives the index from ESR_EL2. I think it
> > could also be extended to the PMEVCNTSVR<n> range as well.
> 
> Just for reference - the mentioned complex trap ID function from the
> given link below.
> 
> static enum trap_behaviour check_mdcr_hpmn(struct kvm_vcpu *vcpu)
> {
> 	u32 sysreg = esr_sys64_to_sysreg(kvm_vcpu_get_esr(vcpu));
> 	u64 mask = kvm_pmu_accessible_counter_mask(vcpu);
> 	unsigned int idx;
> 
> 
> 	switch (sysreg) {
> 	case SYS_PMEVTYPERn_EL0(0) ... SYS_PMEVTYPERn_EL0(30):
> 	case SYS_PMEVCNTRn_EL0(0) ... SYS_PMEVCNTRn_EL0(30):
> 
> ---------------------------------------------------------------------
> Just add the new system register range here ?
> 
> +	case SYS_PMEVCNTSVR_EL1(0)... SYS_PMEVCNTSVR_EL1(31):
> ---------------------------------------------------------------------
> 
> 		idx = (sys_reg_CRm(sysreg) & 0x3) << 3 | sys_reg_Op2(sysreg);
> 		break;

Yes, so long as the layout of encodings matches the established pattern
for value / type registers (I haven't checked this).

> > 
> > Also, keep in mind that the HPMN trap is annoying since it affects Host
> > EL0 in addition to 'guest' ELs.
> 
> Does this require any more special handling other than the above complex trap
> ID function ?

There's another patch in that series I linked that allows EL2 traps to
describe behavior that takes effect in host EL0.

So I don't believe there's anything in particular related to HPMN that
you need to evaluate. I wanted to mention it because some of the PMU
related traps besides HPMN take effect in Host EL0, so do keep it in
mind.

With that said, I haven't seen an FGT yet that applies to Host EL0.

-- 
Thanks,
Oliver

