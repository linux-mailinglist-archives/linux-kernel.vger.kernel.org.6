Return-Path: <linux-kernel+bounces-346163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FF898C096
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8F61F221AE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6301C7B65;
	Tue,  1 Oct 2024 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r9n/OPXU"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A13645
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793999; cv=none; b=HWxJ/QPlftnEiV6/QTmg8BHUCPMI45yRxQ60FQaGPD/+WVDwT5TvzHbNwT5njroRZynBebbeWbvt38pZUlf5GMQ9BLs/xjghd4P29rmvdCwwehxIXuxaK0iQnkgq3LwVvr3yFmNHPJEzZsdUmT5Fa2dIUjTCE5yGYRVxjY9FF5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793999; c=relaxed/simple;
	bh=rXpTNOgidKvuajSXkBjc8UsOZT9MV56E9Ytx+gJeyD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeAK5Cy/iFI6WgfytX9owxsYN4yOYQ/xXbG2SpH0Ixsq7ff8vToNcHBP3RmOuR/z9EciMILu+P3se9FoZSovqCvzL78fGkjqtsr39/X/pYZ0mSME/SPswzqWTLXqzEYVd9JK8U5F4KRzPKakXfRRqspd8mcmBNKkiopVbNrBfw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r9n/OPXU; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 1 Oct 2024 07:46:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727793995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=krvBzYJaeORgAvAaVCh9MhGFYTCNGpbFuoS8Ici3REA=;
	b=r9n/OPXUXQDaYRcdsKMAxEjrhN2HRpXTM4f3VfmqpaE9JCjSguvWXFRC14STLSBRgZqagK
	WrP+n5L2FXvKwFyltYswmJeEsd9z2nUDt/LDKCzTKndbyRalmnBMaCk9yg6MlAL8c/jUjG
	sTe7e4hhzSekuaTJ5BEdma5v+ubcQZc=
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
Message-ID: <ZvwLRWOKpggCvmH4@linux.dev>
References: <20241001024356.1096072-1-anshuman.khandual@arm.com>
 <20241001024356.1096072-48-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001024356.1096072-48-anshuman.khandual@arm.com>
X-Migadu-Flow: FLOW_OUT

Hi Anshuman,

On Tue, Oct 01, 2024 at 08:13:56AM +0530, Anshuman Khandual wrote:
> +#define check_cntr_accessible(num)						\
> +static enum trap_behaviour check_cntr_accessible_##num(struct kvm_vcpu *vcpu)	\
> +{										\
> +	u64 mdcr_el2 = __vcpu_sys_reg(vcpu, MDCR_EL2);				\
> +	int cntr = FIELD_GET(MDCR_EL2_HPMN_MASK, mdcr_el2);			\
> +										\
> +	if (num >= cntr)							\
> +		return BEHAVE_FORWARD_ANY;					\
> +	return BEHAVE_HANDLE_LOCALLY;						\
> +}										\
> +
> +check_cntr_accessible(0)
> +check_cntr_accessible(1)
> +check_cntr_accessible(2)
> +check_cntr_accessible(3)
> +check_cntr_accessible(4)
> +check_cntr_accessible(5)
> +check_cntr_accessible(6)
> +check_cntr_accessible(7)
> +check_cntr_accessible(8)
> +check_cntr_accessible(9)
> +check_cntr_accessible(10)
> +check_cntr_accessible(11)
> +check_cntr_accessible(12)
> +check_cntr_accessible(13)
> +check_cntr_accessible(14)
> +check_cntr_accessible(15)
> +check_cntr_accessible(16)
> +check_cntr_accessible(17)
> +check_cntr_accessible(18)
> +check_cntr_accessible(19)
> +check_cntr_accessible(20)
> +check_cntr_accessible(21)
> +check_cntr_accessible(22)
> +check_cntr_accessible(23)
> +check_cntr_accessible(24)
> +check_cntr_accessible(25)
> +check_cntr_accessible(26)
> +check_cntr_accessible(27)
> +check_cntr_accessible(28)
> +check_cntr_accessible(29)
> +check_cntr_accessible(30)

I'd rather we not use templates for this problem. It bloats the kernel text
as well as the trap encoding space.

I have a patch in the nested PMU series that uses a single complex trap
ID to evaluate HPMN, and derives the index from ESR_EL2. I think it
could also be extended to the PMEVCNTSVR<n> range as well.

Also, keep in mind that the HPMN trap is annoying since it affects Host
EL0 in addition to 'guest' ELs.

[*]: https://lore.kernel.org/kvmarm/20240827002235.1753237-9-oliver.upton@linux.dev/

-- 
Thanks,
Oliver

